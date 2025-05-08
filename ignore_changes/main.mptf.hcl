data "resource" "resource_group" {
    resource_type = "azurerm_resource_group"
}

transform "update_in_place" resource_group_ignore_changes {
  for_each = try(data.resource.resource_group.result.azurerm_resource_group, {})
  target_block_address = each.value.mptf.block_address
  asstring {
    lifecycle {
      ignore_changes = "[\ntags, ${trimprefix(try(each.value.lifecycle.0.ignore_changes, "[\n]"), "[")}"
    }
  }
}