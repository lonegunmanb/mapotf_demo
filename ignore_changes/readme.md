---
marp: true

theme: gaia
paginate: true
---

# Dynamic `ignore_chanages` for public 3rd party Terraform module by using `mapotf`

---

## Problem Statement

- Provisioning an Azure resource group using the AVM module `Azure/avm-res-resources-resourcegroup/azurerm`.
- Configuration drift occurs due to an Azure Policy in the testing subscription.
  - The policy's remediation task adds a new tag to any resource group.
- Issue: Public 3rd party Terraform modules are not designed for such private remediation configurations.

---

## Solution: Using `mapotf`

- `mapotf` allows dynamic manipulation of meta-arguments.
- By declaring a `transform` block in `main.mptf.hcl`, you can:
  - Modify meta-arguments like `ignore_changes` on the fly.
  - Apply changes recursively to handle configuration drift.

---

## Demo

`terraform apply -auto-approve`
`terraform plan`
`mapotf plan -r --mptf-dir . --tf-dir .`
`mapotf transform -r --mptf-dir . --tf-dir .`