################################################################################
# Identifier
################################################################################
# 乱数生成(name_length<=64制約によるリソース重複回避)
resource "random_id" "main" {
  prefix      = var.random_id_length == 0 ? "" : "-"
  byte_length = var.random_id_length
}
