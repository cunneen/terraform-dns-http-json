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
			provider. If the response body from the DNS provider was not able to be
			parsed as a valid JSON document, this object will contain an `error` 
			property with an error message, and a `raw_response` property with the
			(unparsed) raw response body.
			
			***Important***: This module expects the response to be a valid JSON
			document. Note, however, that there is not yet any agreed standard for
			the various providers, and each provider may return different responses.
			For example, [OpenDNS' response in the above
			example](#obtaining-the-local-client-ip-address-with-opendns) differs
			from that of Google and Cloudflare (who have both adopted the same
			response format).
			
			See [Google's DNS-Over-HTTP JSON API specification](
        https://developers.google.com/speed/public-dns/docs/doh/json#dns_response_in_json
			) for more example responses.
			
			**Successful Response:**
			
			| Name                            | Description |
			|---------------------------------|-------------|
			| `dns_response`                  | The response object. See below for properties. |
			| `dns_response.Status`           | The Response Code of the DNS Query. These are defined here: [https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6](https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6).   |
			| `dns_response.TC`               | If true, it means the truncated bit was set. This happens when the DNS answer is larger than a single UDP or TCP packet. TC will almost always be false with Cloudflare DNS over HTTPS because Cloudflare supports the maximum response size. |
			| `dns_response.RD`               | If true, it means the Recursive Desired bit was set. This is always set to true for Cloudflare DNS over HTTPS.                                                                                                                                |
			| `dns_response.RA`               | If true, it means the Recursion Available bit was set. This is always set to true for Cloudflare DNS over HTTPS.                                                                                                                              |
			| `dns_response.AD`               | If true, it means that every record in the answer was verified with DNSSEC.                                                                                                                                                                   |
			| `dns_response.CD`               | If true, the client asked to disable DNSSEC validation. In this case, Cloudflare will still fetch the DNSSEC-related records, but it will not attempt to validate the records.                                                                |
			| `dns_response.Question`         | An array of question objects, with properties as follows:                                                                                                                                                                                     |
			| `dns_response.Question: name`   | The record name requested.                                                                                                                                                                                                                    |
			| `dns_response.Question: type`   | The type of DNS record requested. These are defined here: [https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4](https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4).     |
			| `dns_response.Answer`           | An array of answer objects, with properties as follows:                                                                                                                                                                                       |
			| `dns_response.Answer: name`     | The record owner.                                                                                                                                                                                                                             |
			| `dns_response.Answer: type`     | The type of DNS record. These are defined here: [https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4](https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4).               |
			| `dns_response.Answer: TTL`      | The number of seconds the answer can be stored in cache before it is considered stale.                                                                                                                                                        |
			| `dns_response.Answer: data`     | The value of the DNS record for the given name and type. The data will be in text for standardized record types and in hex for unknown types.                                                                                                 |
			| `dns_response.Authority`        | An array of authority objects, with properties as follows:                                                                                                                                                                                    |
			| `dns_response.Authority: name`  | The record owner.                                                                                                                                                                                                                             |
			| `dns_response.Authority: type`  | The type of DNS record. These are defined here: [https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4](https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4).               |
			| `dns_response.Authority: TTL`   | The number of seconds the answer can be stored in cache before it is considered stale.                                                                                                                                                        |
			| `dns_response.Authority: data`  | The value of the DNS record for the given name and type. The data will be in text for standardized record types and in hex for unknown types.                                                                                                 |
			| `dns_response.Additional`       | An array of additional objects, with properties as follows:                                                                                                                                                                                   |
			| `dns_response.Additional: name` | The record owner.                                                                                                                                                                                                                             |
			| `dns_response.Additional: type` | The type of DNS record. These are defined here: [https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4](https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4).               |
			| `dns_response.Additional: TTL`  | The number of seconds the answer can be stored in cache before it is considered stale.                                                                                                                                                        |
			| `dns_response.Additional: data` | The value of the DNS record for the given name and type. The data will be in text for standardized record types and in hex for unknown types.                                                                                                 |
			| `dns_response.Comment`          | List of EDE messages. Refer to [Extended DNS error codes](/1.1.1.1/infrastructure/extended-dns-error-codes/) for more information.                                                                                                            |
			
			**Error response:**
			
			| Field   | Description                                |
			| ------- | ------------------------------------------ |
			|  `dns_response` | The response object. See below for properties. |
			| `dns_response.error` | An explanation of the error that occurred, as a string. |
			| `dns_response.raw_response` | The raw response body, as a string. |
			
		EOT
}
