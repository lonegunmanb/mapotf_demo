data "resource" azapi_resource {
  resource_type = "azapi_resource"
}

locals {
  azapi_resource_blocks = data.resource.azapi_resource.result.azapi_resource
  azapi_resource_map    = { for _, block in local.azapi_resource_blocks : block.mptf.block_address => block }
  payload = jsonencode({
    avm = "true"
  })
  compact_payload = replace(replace(replace(replace(local.payload, " ", ""), "\n", ""), "\r", ""), "\t", "")
  create_headers = {
    for address, block in local.azapi_resource_map :
    address => try(replace(replace(replace(replace(block.create_headers, " ", ""), "\n", ""), "\r", ""), "\t", ""), "")
  }
  delete_headers = {
    for address, block in local.azapi_resource_map :
    address => try(replace(replace(replace(replace(block.delete_headers, " ", ""), "\n", ""), "\r", ""), "\t", ""), "")
  }
  read_headers = {
    for address, block in local.azapi_resource_map :
    address => try(replace(replace(replace(replace(block.read_headers, " ", ""), "\n", ""), "\r", ""), "\t", ""), "")
  }
  update_headers = {
    for address, block in local.azapi_resource_map :
    address => try(replace(replace(replace(replace(block.update_headers, " ", ""), "\n", ""), "\r", ""), "\t", ""), "")
  }
}

transform "update_in_place" headers {
  for_each = local.azapi_resource_map

  target_block_address = each.key
  asstring {
    create_headers = try(strcontains(local.create_headers[each.key], local.compact_payload), false) ? each.value.create_headers : try(each.value.create_headers == "" || each.value.create_headers == null, true) ? local.payload : "merge(${each.value.create_headers}, ${local.payload})"
    delete_headers = try(strcontains(local.delete_headers[each.key], local.compact_payload), false) ? each.value.delete_headers : try(each.value.delete_headers == "" || each.value.delete_headers == null, true) ? local.payload : "merge(${each.value.delete_headers}, ${local.payload})"
    read_headers   = try(strcontains(local.read_headers[each.key], local.compact_payload), false) ? each.value.read_headers : try(each.value.read_headers == "" || each.value.read_headers == null, true) ? local.payload : "merge(${each.value.read_headers}, ${local.payload})"
    update_headers = try(strcontains(local.update_headers[each.key], local.compact_payload), false) ? each.value.update_headers : try(each.value.update_headers == "" || each.value.update_headers == null, true) ? local.payload : "merge(${each.value.update_headers}, ${local.payload})"
  }
}