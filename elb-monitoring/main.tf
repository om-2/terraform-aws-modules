resource "aws_cloudwatch_metric_alarm" "healthy_host_warn" {
    alarm_name = "${var.elb_name}/HealthyHostCount_WARN"
    alarm_description = "Warn when ${var.healthy_host_warn} healthy hosts remain"
    alarm_actions = [ "${var.snslog_topic.["warn"]}" ]
    ok_actions = [ "${var.snslog_topic.["warn"]}" ]

    namespace = "AWS/ELB"
    dimensions {
        LoadBalancerName = "${var.elb_name}"
    }
    metric_name = "HealthyHostCount"
    period = "60"
    statistic = "Maximum"
    evaluation_periods = "2"
    comparison_operator = "LessThanOrEqualToThreshold"
    threshold = "${var.healthy_host_warn}"
    treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "healthy_host_crit" {
    alarm_name = "${var.elb_name}/HealthyHostCount_CRIT"
    alarm_description = "Critical when ${var.healthy_host_crit} healthy hosts remain"
    alarm_actions = [ "${var.snslog_topic.["crit"]}" ]
    ok_actions = [ "${var.snslog_topic.["crit"]}" ]

    namespace = "AWS/ELB"
    dimensions {
        LoadBalancerName = "${var.elb_name}"
    }
    metric_name = "HealthyHostCount"
    period = "60"
    statistic = "Maximum"
    evaluation_periods = "2"
    comparison_operator = "LessThanOrEqualToThreshold"
    threshold = "${var.healthy_host_crit}"
    treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "unhealthy_host_warn" {
    alarm_name = "${var.elb_name}/UnHealthyHostCount_WARN"
    alarm_description = "Critical when ${var.unhealthy_host_warn} hosts are unhealthy"
    alarm_actions = [ "${var.snslog_topic.["warn"]}" ]
    ok_actions = [ "${var.snslog_topic.["warn"]}" ]

    namespace = "AWS/ELB"
    dimensions {
        LoadBalancerName = "${var.elb_name}"
    }
    metric_name = "UnHealthyHostCount"
    period = "60"
    statistic = "Maximum"
    evaluation_periods = "2"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    threshold = "${var.unhealthy_host_warn}"
    treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "unhealthy_host_crit" {
    alarm_name = "${var.elb_name}/UnHealthyHostCount_CRIT"
    alarm_description = "Critical when ${var.unhealthy_host_crit} hosts are unhealthy"
    alarm_actions = [ "${var.snslog_topic.["crit"]}" ]
    ok_actions = [ "${var.snslog_topic.["crit"]}" ]

    namespace = "AWS/ELB"
    dimensions {
        LoadBalancerName = "${var.elb_name}"
    }
    metric_name = "UnHealthyHostCount"
    period = "60"
    statistic = "Maximum"
    evaluation_periods = "2"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    threshold = "${var.unhealthy_host_crit}"
    treat_missing_data = "notBreaching"
}

# Latency
resource "aws_cloudwatch_metric_alarm" "latency_max_warn" {
    alarm_name = "${var.elb_name}/Latency_Max_WARN"
    alarm_description = "Warn when max latency is >= ${var.latency_max_warn} seconds"
    alarm_actions = [ "${var.snslog_topic.["warn"]}" ]
    ok_actions = [ "${var.snslog_topic.["warn"]}" ]

    namespace = "AWS/ELB"
    dimensions {
        LoadBalancerName = "${var.elb_name}"
    }
    metric_name = "Latency"
    period = "60"
    statistic = "Maximum"
    evaluation_periods = "2"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    threshold = "${var.latency_max_warn}"
    treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "latency_max_crit" {
    alarm_name = "${var.elb_name}/Latency_Max_CRIT"
    alarm_description = "Crit when max latency is >= ${var.latency_max_crit} seconds"
    alarm_actions = [ "${var.snslog_topic.["crit"]}" ]
    ok_actions = [ "${var.snslog_topic.["crit"]}" ]

    namespace = "AWS/ELB"
    dimensions {
        LoadBalancerName = "${var.elb_name}"
    }
    metric_name = "Latency"
    period = "60"
    statistic = "Maximum"
    evaluation_periods = "2"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    threshold = "${var.latency_max_crit}"
    treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "latency_p99_warn" {
    alarm_name = "${var.elb_name}/Latency_p99_WARN"
    alarm_description = "Warn when p99 latency is >= ${var.latency_p99_warn} seconds"
    alarm_actions = [ "${var.snslog_topic.["warn"]}" ]
    ok_actions = [ "${var.snslog_topic.["warn"]}" ]

    namespace = "AWS/ELB"
    dimensions {
        LoadBalancerName = "${var.elb_name}"
    }
    metric_name = "Latency"
    period = "60"
    extended_statistic = "p99"
    evaluation_periods = "2"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    threshold = "${var.latency_p99_warn}"
    treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "latency_p99_crit" {
    alarm_name = "${var.elb_name}/Latency_p99_CRIT"
    alarm_description = "Crit when p99 latency is >= ${var.latency_p99_crit} seconds"
    alarm_actions = [ "${var.snslog_topic.["crit"]}" ]
    ok_actions = [ "${var.snslog_topic.["crit"]}" ]

    namespace = "AWS/ELB"
    dimensions {
        LoadBalancerName = "${var.elb_name}"
    }
    metric_name = "Latency"
    period = "60"
    extended_statistic = "p99"
    evaluation_periods = "2"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    threshold = "${var.latency_p99_crit}"
    treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "latency_p95_warn" {
    alarm_name = "${var.elb_name}/Latency_p95_WARN"
    alarm_description = "Warn when p95 latency is >= ${var.latency_p95_warn} seconds"
    alarm_actions = [ "${var.snslog_topic.["warn"]}" ]
    ok_actions = [ "${var.snslog_topic.["warn"]}" ]

    namespace = "AWS/ELB"
    dimensions {
        LoadBalancerName = "${var.elb_name}"
    }
    metric_name = "Latency"
    period = "60"
    extended_statistic = "p95"
    evaluation_periods = "2"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    threshold = "${var.latency_p95_warn}"
    treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "latency_p95_crit" {
    alarm_name = "${var.elb_name}/Latency_p95_CRIT"
    alarm_description = "Crit when p95 latency is >= ${var.latency_p95_crit} seconds"
    alarm_actions = [ "${var.snslog_topic.["crit"]}" ]
    ok_actions = [ "${var.snslog_topic.["crit"]}" ]

    namespace = "AWS/ELB"
    dimensions {
        LoadBalancerName = "${var.elb_name}"
    }
    metric_name = "Latency"
    period = "60"
    extended_statistic = "p95"
    evaluation_periods = "2"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    threshold = "${var.latency_p95_crit}"
    treat_missing_data = "notBreaching"
}
