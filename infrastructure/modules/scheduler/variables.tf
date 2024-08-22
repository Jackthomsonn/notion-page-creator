variable "scheduler_name" {
  type        = string
  description = "Name for the scheduler"
}

variable "time_zone" {
  type        = string
  description = "The time zone to run this schedule in"
}

variable "schedule_expression" {
  type        = string
  description = "The expression to use to execute the schedule"
}

variable "lambda_arn" {
  type        = string
  description = "The arn of the lambda to target for this schedule"
}
