output "topic" {
    value = {
        crit   = "${aws_sns_topic.ops-crit.arn}"
        warn   = "${aws_sns_topic.ops-warn.arn}"
        notice = "${aws_sns_topic.ops-notice.arn}"
        info   = "${aws_sns_topic.ops-info.arn}"
    }
}
