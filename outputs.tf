# Copyright (c) Mike Cunneen
# SPDX-License-Identifier: MPL-2.0

# Output variable definitions

locals {
  raw_value = data.http.dns_response.response_body
  normalized_value = try(jsondecode(local.raw_value), {
    error        = "Failed to parse JSON response",
    raw_response = local.raw_value
  })
}

output "dns_response" {
  value = local.normalized_value
}
