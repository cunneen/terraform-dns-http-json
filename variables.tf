# Copyright (c) Mike Cunneen.
# SPDX-License-Identifier: MPL-2.0

# Constants (as outputs)

locals {
  edns_ecs_name = {
    description = "value of the query parameter to use for an EDNS ECS Client Subnet query: \"o-o.myaddr.google.com\""
    value       = "o-o.myaddr.google.com"
  }
}

# Input variable definitions
variable "name" {
  type        = string
  description = <<-EOT
		The only required parameter. RFC 4343 backslash escapes are accepted.
		The name of the resource to lookup e.g. you would use "terraform.hashicorp.com" 
		for https://dns.google/resolve?name=terraform.hashicorp.com . The raw value you provide will be URL encoded by the module.
		The length (after replacing backslash escapes) must be between 1 and 253 (ignoring an optional trailing dot if present).
		All labels (parts of the name betweendots) must be 1 to 63 bytes long.
		Invalid names like .example.com, example..com or empty string get 400 Bad Request.
		Non-ASCII characters should be punycoded (xn--qxam, not ελ).
		EOT
}

variable "type" {
  default     = "A"
  type        = string
  description = <<-EOT
	RR type as a canonical string
	(case-insensitive, such as A or aaaa).
	EOT
}

variable "cd" {
  type        = bool
  default     = null
  description = <<-EOT
		The CD (Checking Disabled) flag. Use or cd=true to disable DNSSEC
		validation; use cd=false, or no cd parameter to enable DNSSEC
		validation.
		EOT
}

variable "ct" {
  default     = null
  type        = string
  description = <<-EOT
	Desired content type option. Use ct=application/dns-message to receive a
	binary DNS message in the response HTTP body instead of JSON text. Use
	ct=application/x-javascript to explicitly request JSON text. Other content
	type values are ignored and default JSON content is returned.
	EOT
}

variable "do" {
  default     = null
  type        = bool
  description = <<-EOT
		The DO (DNSSEC OK) flag. Use or do=true to include DNSSEC records
		(RRSIG, NSEC, NSEC3); use do=false, or no do parameter to omit DNSSEC
		records.

		Applications should always handle (and ignore, if necessary) any DNSSEC
		records in JSON responses as other implementations may always include them,
		and we may change the default behavior for JSON responses in the future.
		(Binary DNS message responses always respect the value of the DO flag.)
	EOT
}

variable "edns_client_subnet" {
  type        = string
  default     = null
  description = <<-EOT
		The edns0-client-subnet option. Format is an IP address with a subnet mask.
		Examples: 1.2.3.4/24, 2001:700:300::/48.

		If you are using DNS-over-HTTPS because of privacy concerns, and do not
		want any part of your IP address to be sent to authoritative name servers
		for geographic location accuracy, use edns_client_subnet=0.0.0.0/0. Google
		Public DNS normally sends approximate network information (usually zeroing
		out the last part of your IPv4 address).
	EOT
}

variable "random_padding" {
  type        = string
  default     = null
  description = <<-EOT
		The value of this parameter is ignored. Example: XmkMw~o_mgP2pf.gpw-Oi5dK.

		API clients concerned about possible side-channel privacy attacks using the
		packet sizes of HTTPS GET requests can use this to make all requests
		exactly the same size by padding requests with random data. To prevent
		misinterpretation of the URL, restrict the padding characters to the
		unreserved URL characters: upper- and lower-case letters, digits, hyphen,
		period, underscore and tilde.
	EOT
}


variable "endpoint" {
  description = <<-EOT
			The DNS-Over-HTTP provider's endpoint, including the scheme, domain and
			path, but not the query parameters e.g. https://dns.google/resolve
		EOT
  type        = string
  default     = "https://dns.google/resolve"
}

variable "query_params" {
  description = "Any additional query parameters, e.g. {\"X-Terraform-Module\":\"dns_over_http\"}"
  type        = map(string)
  default     = {}
}

variable "query_param_name" {
  description = <<-EOT
			The name of the query parameter to use in the GET request, without any
			quesion marks, ampersands or equal signs e.g. you would use \"name\" for
			https://dns.google/resolve?name=terraform.hashicorp.com .
		EOT
  type        = string
  default     = "name"
}

variable "httpmethod" {
  description = <<-EOT
			The HTTP method to use, e.g. GET, POST or HEAD. Defaults to GET. You
			normally do not need to change this.
		EOT
  type        = string
  default     = "GET"
}

variable "headers" {
  description = <<-EOT
			Any additional HTTP headers to pass to the DNS-Over-HTTP provider, e.g.
			{\"X-Terraform-Module\":\"dns_over_http\"}"
		EOT
  type        = map(string)
  default     = {}
}

variable "request_body" {
  description = <<-EOT
			Any additional request body to pass through to the DNS-Over-HTTP JSON API
			provider. You normally wouldn't need to provide this.
		EOT
  type        = string
  nullable    = true
  default     = null
}
