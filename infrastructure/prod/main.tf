module "page_creator_lambda" {
  source = "../modules/lambda"

  function_name = "page-creator"
  archive_path  = "page-creator.zip"
  binary_name   = "bootstrap"
  binary_path   = "bootstrap"
  src_path      = "../../cmd/main.go"
}

module "page_creator_lambda_schedule" {
  source = "../modules/scheduler"

  scheduler_name      = "page_creator_lambda_schedule"
  schedule_expression = "cron(0 9 ? * 2-6 *)"
  time_zone           = "Europe/London"
  lambda_arn          = module.page_creator_lambda.arn
}

