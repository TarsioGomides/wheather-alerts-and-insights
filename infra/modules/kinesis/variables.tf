variable "stream_name" {
  description = "Name of the Kinesis stream"
  type        = string
}

variable "shard_count" {
  description = "Number of shards for the stream"
  type        = number
  default     = 1
}

variable "retention_hours" {
  description = "Data retention period in hours"
  type        = number
  default     = 24
  validation {
    condition     = var.retention_hours >= 24 && var.retention_hours <= 8760
    error_message = "Retention period must be between 24 and 8760 hours (1 year)."
  }
}

variable "encryption_type" {
  description = "Encryption type for the stream"
  type        = string
  default     = "KMS"
}

variable "enable_shard_level_metrics" {
  description = "Whether to enable shard-level metrics"
  type        = bool
  default     = false
}

variable "enable_alarms" {
  description = "Whether to create CloudWatch alarms"
  type        = bool
  default     = true
}

variable "alarm_actions" {
  description = "List of ARNs to notify when alarm triggers"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Additional tags for the stream"
  type        = map(string)
  default     = {}
}