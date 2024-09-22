################################################################################
# Params
################################################################################
variable "acceptable_method" { description = "受け付けるHTTPリクエストメソッドのリスト" }
variable "container_port" { description = "コンテナの開放ポート" }
variable "countory" { description = "国名" }
variable "environment" { description = "環境(dev/stg/pro)" }
variable "open_port" {
  default     = 80
  description = "NLBが受け付けるポート"
}
variable "region" { description = "利用するリージョン" }
variable "service" { description = "サービス名" }
variable "vendor" { description = "ベンダー名" }
variable "vpc_cidr" { description = "VPCのCIDRブロック" }