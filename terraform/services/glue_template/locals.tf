################################################################################
# LocalParams
################################################################################
locals {
  # サービスグループ名
  service_group            = "${var.vendor}-${var.countory}-${var.service}"
  # コンポーネント名称
  name                     = "glue-template"
}
