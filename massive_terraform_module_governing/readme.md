---
marp: true

theme: gaia
paginate: true
---

# Massive Terraform module governing

---

## Problem Statement

- When maintaining **hundreds of Terraform modules**, you often encounter the need to **apply the same change across all modules**.
- Example scenario:
  - You want to **set a pre-defined map of strings** to the `headers` argument of **all** `azapi_resource` blocks.
- Manually editing each module is:
  - Time-consuming
  - Error-prone
  - Difficult to track and maintain

---

## Solution: Using `mapotf`

- **`mapotf`** allows you to:
  - Dynamically **match** Terraform resource blocks by type (e.g., `azapi_resource`).
  - **Merge or inject arguments** such as `headers` across all matched blocks.
  - Apply these changes **automatically** and consistently across all modules.
- This approach:
  - Eliminates the need for manual edits.
  - Ensures consistency across the entire codebase.
  - Provides a scalable solution for managing widespread configuration changes.
- By integrating `mapotf` call with CI pipeline, we can customize Terraform configs at scale.

---

## Benefits

- **Scalable Change Management**: Carry updates across hundreds of modules effortlessly.
- **Reduced Manual Effort**: Avoid tedious, repetitive edits.
- **Improved Consistency**: Guarantee uniform configuration across all target resources.
- **Better Governance**: Centralize and standardize updates for easier maintenance.

---

## Demo

`mapotf transform --mptf-dir . --tf-dir .`

* Run transform again to verify whether the transformation is idempotent or not

`mapotf transform --mptf-dir . --tf-dir .`