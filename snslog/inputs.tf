variable "slack_webhook_url" {
    type = "string" 
    description = "Full URL of the webhook to send notifications"
}

variable "slack_channel" {
    type = "string"
    description = "Channel with # to send notifications to"
}
