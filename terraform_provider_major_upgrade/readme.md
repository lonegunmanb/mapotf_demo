---
marp: true

theme: gaia
paginate: true
---

# Seamless Terraform Provider Major Version Upgrade Using `mapotf`

---

## Problem Statement

- Upgrading a Terraform provider to a new **major version** often introduces **breaking changes**.
- These breaking changes typically require **manual, large-scale modifications** across many Terraform configuration files.
- Maintaining consistency and avoiding human error during this process is challenging, especially in large infrastructures.

---

## Solution: Using `mapotf` + TerraformConfigWelder

- **`mapotf`** enables dynamic, programmatic transformation of Terraform configurations.
- [**TerraformConfigWelder**](https://github.com/lonegunmanb/TerraformConfigWelder) is a set of pre-defined `mapotf` configuration files:
  - Encodes the necessary adjustments for major provider upgrades.
  - Automates the injection or modification of required attributes, arguments, or blocks.
  - Reduces the need for tedious manual editing.

---

- Together, they:
  - **Seamlessly apply breaking changes** across your Terraform configurations.
  - Ensure consistency, reduce risk, and accelerate upgrade timelines.

---

## Benefits

- **Minimized Manual Work**: Let `mapotf` carry most of the upgrade burden.
- **Consistency at Scale**: Apply the same transformations across all modules and resources.
- **Reduced Risk**: Lower chance of introducing human errors during complex upgrades.
- **Speed**: Move faster through major version upgrades without halting projects.

---

## Demo

`terraform init && terraform plan`

* Upgrade `azurerm` major version and plan again

`mapotf transform --mptf-dir . --tf-dir . && terraform init -upgrade && terraform plan`

* Run `mapotf` along with TerraformConfigWelder to migrate Terraform configs and plan again

`mapotf transform --mptf-dir git::https://github.com/lonegunmanb/TerraformConfigWelder.git//azurerm/v3_v4 --tf-dir . && terraform plan`