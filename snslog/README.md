# snslog

This module was built to handle an alerts pipeline from Cloudwatch to Slack.
It could also be used to handle RDS failover notifications but I have not expanded the notifier to script to be aware of
the message format.

## SNS Topics
This module creates several SNS topics that vary in severity.

 - ops-crit
 - ops-warn
 - ops-notice
 - ops-info
