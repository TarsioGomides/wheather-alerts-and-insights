resource "aws_kinesis_stream" "this" {
  name             = var.stream_name
  shard_count      = var.shard_count
  retention_period = var.retention_hours
  encryption_type  = var.encryption_type

  dynamic "shard_level_metrics" {
    for_each = var.enable_shard_level_metrics ? ["IncomingBytes", "OutgoingBytes", "ReadProvisionedThroughputExceeded", "WriteProvisionedThroughputExceeded"] : []
    content {
      name = shard_level_metrics.value
    }
  }

  tags = merge(
    {
      "ManagedBy" = "Terraform"
    },
    var.tags
  )
}

resource "aws_cloudwatch_metric_alarm" "throughput_exceeded" {
  count               = var.enable_alarms ? 1 : 0
  alarm_name          = "${var.stream_name}-throughput-exceeded"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "WriteProvisionedThroughputExceeded"
  namespace          = "AWS/Kinesis"
  period             = 60
  statistic          = "Sum"
  threshold          = 0
  alarm_description  = "This metric monitors Kinesis write throughput exceeded"
  alarm_actions      = var.alarm_actions

  dimensions = {
    StreamName = aws_kinesis_stream.this.name
  }
}