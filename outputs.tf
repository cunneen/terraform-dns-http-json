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
  value       = local.normalized_value
  description = <<-EOT
			An object containing the (parsed) JSON response from the DNS-Over-HTTP
			provider. See <a href="https://registry.terraform.io/modules/cunneen/http-json/dns/latest?tab=readme#outputs">outputs section in the readme</a>
      for more information.
		EOT
}
