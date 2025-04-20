output "arn" {
  description = "ARN of the Kinesis stream"
  value       = aws_kinesis_stream.this.arn
}

output "name" {
  description = "Name of the Kinesis stream"
  value       = aws_kinesis_stream.this.name
}

output "shard_count" {
  description = "Current number of shards"
  value       = aws_kinesis_stream.this.shard_count
}