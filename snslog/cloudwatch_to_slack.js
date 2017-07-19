var AWS = require('aws-sdk');
var url = require('url');
var https = require('https');
var hookUrl, slackChannel;
var util = require('util');

var postMessage = function(message, callback) {
  var body = JSON.stringify(message);
  var options = url.parse(hookUrl);
  options.method = 'POST';
  options.headers = {
    'Content-Type': 'application/json',
    'Content-Length': Buffer.byteLength(body),
  };

  var postReq = https.request(options, function(res) {
    var chunks = [];
    res.setEncoding('utf8');
    res.on('data', function(chunk) {
      return chunks.push(chunk);
    });
    res.on('end', function() {
      var body = chunks.join('');
      if (callback) {
        callback({
          body: body,
          statusCode: res.statusCode,
          statusMessage: res.statusMessage
        });
      }
    });
    return res;
  });

  postReq.write(body);
  postReq.end();
};

var processEvent = function(event, context) {
  var record = event.Records[0].Sns;
  var topic = record.TopicArn;
  var subject = record.Subject;
  var message = JSON.parse(record.Message);
  var oldState = message.OldStateValue;
  var newState = message.NewStateValue;

  var critColors = {
    ALARM: 'danger',
    OK: 'good',
    INSUFFICIENT_DATA: 'danger'
  };

  var warnColors = {
    ALARM: 'warning',
    OK: 'good',
    INSUFFICIENT_DATA: 'warning'
  };

  // determine severity
  var severity = '';
  var colorset = '';
  console.info("Topic ARN is: " + topic);
  // A topic arn looks like
  // 'arn:aws:sns:us-east-1:189361104910:ops-emerg'
  switch(topic.split(':').pop()) {
    case 'ops-crit':
              severity = 'alerting';
              colorset = critColors;
              break;
    case 'ops-warn':
              severity = 'warning';
              colorset = warnColors;
              break;
  }
  
  // determine color
  var color = colorset[newState];

  // determine status of alert
  var status = ''; // can be one of 'alarmed' or 'recovery'
  switch(newState) {
    case 'ALARM':
    case 'INSUFFICIENT_DATA':
      status = 'is ' + severity;
      break;
    case 'OK':
      status = 'has recovered';
      break;
  }

  var slackMessage = {
    channel: slackChannel,
    attachments: [{
      title: message.AlarmName + " " + status,
      fallback: message.AlarmName + " " + status + ".",
      color: color,
      text: message.NewStateReason + "\n" + oldState + " => " + newState
    }]
  };

  console.info(slackMessage);

  postMessage(slackMessage, function(response) {
    if (response.statusCode < 400) {
      console.info('Message posted successfully');
      context.succeed();
    } else if (response.statusCode < 500) {
      console.error("Error posting message to Slack API: " + response.statusCode + " - " + response.statusMessage);
      context.succeed();  // Don't retry because the error is due to a problem with the request
    } else {
      // Let Lambda retry
      context.fail("Server error when processing message: " + response.statusCode + " - " + response.statusMessage);
    }
  });
};


exports.handler = function(event, context) {
    hookUrl = process.env.SLACK_WEBHOOK_URL;
    slackChannel = process.env.SLACK_CHANNEL;

    console.log("CONTEXT");
    console.log(util.inspect(context, false, null));

    console.log("EVENT");
    console.log(util.inspect(event, false, null));

    processEvent(event, context);
};
