transform "update_in_place" bump_azurerm_to_4 {
  target_block_address = "terraform"
  asstring {
    required_providers {
      azurerm = <<-EOT
            {
                source = "hashicorp/azurerm"
                version = "~> 4.0"
            }
EOT
    }
  }
}