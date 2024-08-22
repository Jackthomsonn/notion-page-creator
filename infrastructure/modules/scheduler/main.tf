locals {
  scheduler_name      = var.scheduler_name
  time_zone           = var.time_zone
  schedule_expression = var.schedule_expression
  lambda_arn          = var.lambda_arn
}

resource "aws_iam_role" "scheduler_role" {
  name = local.scheduler_name
  inline_policy {
    name = "${local.scheduler_name}_lambda_invoke"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = "Allow"
          Action   = "lambda:InvokeFunction"
          Resource = "*"
        }
      ]
    })
  }
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "scheduler.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_scheduler_schedule" "invoke_lambda_schedule" {
  name                         = "${local.scheduler_name}_InvokeLambdaSchedule"
  schedule_expression_timezone = local.time_zone
  schedule_expression          = local.schedule_expression

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = local.lambda_arn
    role_arn = aws_iam_role.scheduler_role.arn
  }
}
