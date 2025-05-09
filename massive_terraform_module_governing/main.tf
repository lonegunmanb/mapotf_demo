resource "azapi_resource" "queue" {
  for_each = var.queues

  type = "Microsoft.Storage/storageAccounts/queueServices/queues@2023-01-01"
  body = {
    properties = {
      metadata = each.value.metadata == null ? {} : each.value.metadata
    }
  }
  name                      = each.value.name
  parent_id                 = "${azurerm_storage_account.this.id}/queueServices/default"
  schema_validation_enabled = false

  dynamic "timeouts" {
    for_each = each.value.timeouts == null ? [] : [each.value.timeouts]

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
    }
  }

  depends_on = [azurerm_storage_account.this]
}

resource "azapi_resource" "table" {
  for_each = var.tables

  type = "Microsoft.Storage/storageAccounts/tableServices/tables@2023-01-01"
  body = {
    properties = {
      signed_identifiers = each.value.signed_identifiers == null ? [] : each.value.signed_identifiers
    }
  }
  name                      = each.value.name
  parent_id                 = "${azurerm_storage_account.this.id}/tableServices/default"
  schema_validation_enabled = false

  dynamic "timeouts" {
    for_each = each.value.timeouts == null ? [] : [each.value.timeouts]

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
    }
  }
  create_headers = {
    env = "prod"
  }
}
