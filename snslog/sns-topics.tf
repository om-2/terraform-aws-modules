# Following the Syslog severity levels

# Emergency - System unusable
# Alert - Should be corrected immediately
# Critical - Error conditions
# Warning - May indicate error if no action is taken
# Notice - Unusual events
# Informational - Normal operational messages
# Debug - Debugging stuff

# We only use the following
# Critcal, Warning, Notice, Info
# This aligns better with Nagios terminology. I kept confusing crit / emerg
# I kept notice as a non-warning condition that could turn into a warning condition
# I kept info because that's where I'll send autoscaling notifications

# CRITICAL
resource "aws_sns_topic" "ops-crit" {
  name = "ops-crit"
  display_name = "CRITICAL"
}

# WARNING
resource "aws_sns_topic" "ops-warn" {
  name = "ops-warn"
  display_name = "WARN"
}

# NOTICE
resource "aws_sns_topic" "ops-notice" {
  name = "ops-notice"
  display_name = "NOTICE"
}

# INFO
resource "aws_sns_topic" "ops-info" {
  name = "ops-info"
  display_name = "INFO"
}
