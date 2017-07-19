resource "aws_lambda_function" "cloudwatch-to-slack" {
  role = "${aws_iam_role.lambda-cloudwatch-to-slack.arn}"
  handler = "cloudwatch_to_slack.handler"
  function_name = "cloudwatch-to-slack"
  source_code_hash = "${base64sha256(file("${path.module}/cloudwatch_to_slack.zip"))}"
  runtime = "nodejs4.3"
  filename = "${path.module}/cloudwatch_to_slack.zip" 
  timeout = "10"
  environment {
    variables = {
      SLACK_WEBHOOK_URL = "${var.slack_webhook_url}"
      SLACK_CHANNEL = "${var.slack_channel}"
    }
  }
}

resource "aws_iam_role" "lambda-cloudwatch-to-slack" {
  name = "lambda-cloudwatch-to-slack"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "lambda_permissions" {
    statement {
        actions = [
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ]
        effect = "Allow"
        resources = [
            "${aws_cloudwatch_log_group.lambda.arn}",
            "${aws_cloudwatch_log_group.lambda.arn}:log-stream:*"
        ]
    }
}
    

resource "aws_iam_role_policy" "alerting" {
  name = "lambda-alerting"
  role = "${aws_iam_role.lambda-cloudwatch-to-slack.id}"
  policy = "${data.aws_iam_policy_document.lambda_permissions.json}"
}

# Cloudwatch log group for this data-pipeline
resource "aws_cloudwatch_log_group" "lambda" {
    name = "/aws/lambda/cloudwatch-to-slack"
}

resource "aws_lambda_permission" "invoke-from-sns" {
  statement_id = "AllowExectionFromSNS"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.cloudwatch-to-slack.arn}"
  principal = "sns.amazonaws.com"
}



resource "aws_sns_topic_subscription" "ops-crit-via-slack" {
  topic_arn = "${aws_sns_topic.ops-crit.arn}"
  protocol = "lambda"
  endpoint = "${aws_lambda_function.cloudwatch-to-slack.arn}"
}

resource "aws_sns_topic_subscription" "ops-warn-via-slack" {
  topic_arn = "${aws_sns_topic.ops-warn.arn}"
  protocol = "lambda"
  endpoint = "${aws_lambda_function.cloudwatch-to-slack.arn}"
}

resource "aws_sns_topic_subscription" "ops-notice-via-slack" {
  topic_arn = "${aws_sns_topic.ops-notice.arn}"
  protocol = "lambda"
  endpoint = "${aws_lambda_function.cloudwatch-to-slack.arn}"
}

resource "aws_sns_topic_subscription" "ops-info-via-slack" {
  topic_arn = "${aws_sns_topic.ops-info.arn}"
  protocol = "lambda"
  endpoint = "${aws_lambda_function.cloudwatch-to-slack.arn}"
}
