module "kinesis_data_stream" {
  source = "../../modules/kinesis"

  stream_name              = "dev-orders-stream"
  shard_count              = 2
  retention_hours          = 48
  enable_shard_level_metrics = true
  encryption_type          = "KMS"

  tags = {
    Environment = "dev"
    Application = "OrderProcessing"
  }
}