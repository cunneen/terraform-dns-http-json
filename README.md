# DNS over HTTP JSON

The aim of this module is to support DNS over HTTP (DoH) JSON API (as per
[Google's
specification](https://developers.google.com/speed/public-dns/docs/doh/json)) in Terraform.

## Obtaining the local client IP address

This module also provides a mechanism to retrieve the local client IP address (of the computer upon which `terraform plan` or `terraform apply` is being run).

This can be useful e.g. to automatically whitelist your Terraform client's IP address with other terraform resources. See the [Examples](#more-examples) section below.

## Motivation

Hashicorp's Terraform provider for DNS (terraform-provider-dns) is good, and
you should use that if it meets your requirements. It will be better-maintained
and better-tested than this module. However, it:

- Does not allow you to specify a nameserver for data retrieval
- Does not provide a mechanism to retrieve the local client IP address e.g. via eDNS0
  Client Subnet (ECS)

This module aims to fill those gaps.

## Usage

```hcl
# To look up the "A" record for "example.com", using the default (Google) nameserver
module "dns_http_json" {
  source = "github.com/cunneen/terraform-dns-http-json"
  name = "example.com"
}
```

### More Examples

#### Obtaining the local client IP address with OpenDNS

- Use [OpenDNS](https://www.opendns.com/) to lookup your own terraform client's IP address (i.e. the IP address of the computer upon which `terraform plan` or `terraform apply` is being run)
  - Note that the domain name we're querying is `o-o.myaddr.google.com` ; this is a convention introduced by Google to request the retrieval of the local client IP address. See [https://developers.google.com/speed/public-dns/docs/doh/json](https://developers.google.com/speed/public-dns/docs/doh/json)
  - Note also that the response format does differs from that of Google and Cloudflare.

    ```hcl
    module "dns_http_json" {
        source = "github.com/cunneen/terraform-dns-http-json"
        name               = "o-o.myaddr.google.com"
        endpoint           = "https://myipv4.p1.opendns.com/get_my_ip"
    }
    ```

    Response:

    ```hcl
    "dns_response" = {
      "ip" = "203.0.113.6" # <-- This is the local client IP address from which I ran `terraform apply`
    }
    ```

#### Obtaining the NS records for Apple using Cloudflare

- Use Cloudflare to lookup Apple's NS records

    ```hcl
    module "dns_http_json" {
      source = "github.com/cunneen/terraform-dns-http-json"

      name               = "apple.com"
      type               = "NS"
      endpoint           = "https://cloudflare-dns.com/dns-query"
      headers = {
        accept = "application/dns-json"
      }
    }
    ```

    Response:

    ```hcl
    "dns_response" = {
      "AD" = false
      "Answer" = [
        {
          "TTL" = 35116
          "data" = "a.ns.apple.com."
          "name" = "apple.com"
          "type" = 2
        },
        {
          "TTL" = 35116
          "data" = "b.ns.apple.com."
          "name" = "apple.com"
          "type" = 2
        },
        {
          "TTL" = 35116
          "data" = "c.ns.apple.com."
          "name" = "apple.com"
          "type" = 2
        },
        {
          "TTL" = 35116
          "data" = "d.ns.apple.com."
          "name" = "apple.com"
          "type" = 2
        },
      ]
      "CD" = false
      "Question" = [
        {
          "name" = "apple.com"
          "type" = 2
        },
      ]
      "RA" = true
      "RD" = true
      "Status" = 0
      "TC" = false
    }
    ```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.2 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 3.4.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [http_http.dns_response](https://registry.terraform.io/providers/hashicorp/http/3.4.5/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The only required parameter. RFC 4343 backslash escapes are accepted.<br/>The name of the resource to lookup e.g. you would use `"terraform.hashicorp.com"` <br/>for https://dns.google/resolve?name=terraform.hashicorp.com . The raw value you provide will be URL encoded by the module.<br/>The length (after replacing backslash escapes) must be between 1 and 253 (ignoring an optional trailing dot if present).<br/>All labels (parts of the name betweendots) must be 1 to 63 bytes long.<br/>Invalid names like .example.com, example..com or empty string get 400 Bad Request.<br/>Non-ASCII characters should be punycoded (xn--qxam, not ελ). | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | RR type (i.e. DNS query type) as a canonical string<br/>(case-insensitive, such as `"A"`,`"CNAME"`, or `"aaaa"`). | `string` | `"A"` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | The DNS-Over-HTTP provider's endpoint, including the scheme, domain and path, but not the query parameters e.g. https://dns.google/resolve | `string` | `"https://dns.google/resolve"` | no |
| <a name="input_cd"></a> [cd](#input\_cd) | The CD (Checking Disabled) flag. Use cd=true to disable DNSSEC<br/>validation; use cd=false, or no cd parameter to enable DNSSEC<br/>validation. | `bool` | `null` | no |
| <a name="input_ct"></a> [ct](#input\_ct) | Desired content type option. Use ct=application/dns-message to receive a<br/>binary DNS message in the response HTTP body instead of JSON text. Use<br/>ct=application/x-javascript to explicitly request JSON text. Other content<br/>type values are ignored and default JSON content is returned. | `string` | `null` | no |
| <a name="input_do"></a> [do](#input\_do) | The DO (DNSSEC OK) flag. Use do=true to include DNSSEC records<br/>(RRSIG, NSEC, NSEC3); use do=false, or no `do` parameter to omit DNSSEC<br/>records.<br/><br/>Applications should always handle (and ignore, if necessary) any DNSSEC<br/>records in JSON responses as other implementations may always include them,<br/>and we may change the default behavior for JSON responses in the future.<br/>(Binary DNS message responses always respect the value of the DO flag.) | `bool` | `null` | no |
| <a name="input_edns_client_subnet"></a> [edns\_client\_subnet](#input\_edns\_client\_subnet) | The edns0-client-subnet option. Format is an IP address with a subnet mask.<br/>Examples: 1.2.3.4/24, 2001:700:300::/48.<br/><br/>If you are using DNS-over-HTTPS because of privacy concerns, and do not<br/>want any part of your IP address to be sent to authoritative name servers<br/>for geographic location accuracy, use edns\_client\_subnet=0.0.0.0/0. Google<br/>Public DNS normally sends approximate network information (usually zeroing<br/>out the last part of your IPv4 address). | `string` | `null` | no |
| <a name="input_headers"></a> [headers](#input\_headers) | Any additional HTTP headers to pass to the DNS-Over-HTTP provider, e.g. {"X-Terraform-Module":"dns\_over\_http"} | `map(string)` | `{}` | no |
| <a name="input_httpmethod"></a> [httpmethod](#input\_httpmethod) | The HTTP method to use, e.g. GET, POST or HEAD. Defaults to GET. You normally do not need to change this. | `string` | `"GET"` | no |
| <a name="input_query_param_name"></a> [query\_param\_name](#input\_query\_param\_name) | The name of the query parameter to use in the GET request, without any quesion marks, ampersands or equal signs e.g. you would use "name" for https://dns.google/resolve?name=terraform.hashicorp.com . | `string` | `"name"` | no |
| <a name="input_query_params"></a> [query\_params](#input\_query\_params) | Any additional query parameters, e.g. {"X-Terraform-Module":"dns\_over\_http"} | `map(string)` | `{}` | no |
| <a name="input_random_padding"></a> [random\_padding](#input\_random\_padding) | The value of this parameter is ignored. Example: XmkMw~o\_mgP2pf.gpw-Oi5dK.<br/><br/>API clients concerned about possible side-channel privacy attacks using the<br/>packet sizes of HTTPS GET requests can use this to make all requests<br/>exactly the same size by padding requests with random data. To prevent<br/>misinterpretation of the URL, restrict the padding characters to the<br/>unreserved URL characters: upper- and lower-case letters, digits, hyphen,<br/>period, underscore and tilde. | `string` | `null` | no |
| <a name="input_request_body"></a> [request\_body](#input\_request\_body) | Any additional request body to pass through to the DNS-Over-HTTP JSON API provider. You normally wouldn't need to provide this. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_response"></a> [dns\_response](#output\_dns\_response) | n/a |

### dns_response Attributes

#### Successful Response

***Important***: This module expects the response to be a valid JSON response. Note, however, that there is not yet any agreed standard for the various providers, and each provider may return different responses. For example, [OpenDNS' response in the above example](#obtaining-the-ns-records-for-apple-using-cloudflare) differs from that of Google and Cloudflare (who have both adopted the same response format).

This module expects the response to be a valid JSON document.

See [Google's DNS-Over-HTTP JSON API specification](https://developers.google.com/speed/public-dns/docs/doh/json#dns_response_in_json) for more example responses.

| Field              | Description                                                                                                                                                                                                                                   |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Status`           | The Response Code of the DNS Query. These are defined here: [https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6](https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6).   |
| `TC`               | If true, it means the truncated bit was set. This happens when the DNS answer is larger than a single UDP or TCP packet. TC will almost always be false with Cloudflare DNS over HTTPS because Cloudflare supports the maximum response size. |
| `RD`               | If true, it means the Recursive Desired bit was set. This is always set to true for Cloudflare DNS over HTTPS.                                                                                                                                |
| `RA`               | If true, it means the Recursion Available bit was set. This is always set to true for Cloudflare DNS over HTTPS.                                                                                                                              |
| `AD`               | If true, it means that every record in the answer was verified with DNSSEC.                                                                                                                                                                   |
| `CD`               | If true, the client asked to disable DNSSEC validation. In this case, Cloudflare will still fetch the DNSSEC-related records, but it will not attempt to validate the records.                                                                |
| `Question: name`   | The record name requested.                                                                                                                                                                                                                    |
| `Question: type`   | The type of DNS record requested. These are defined here: [https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4](https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4).     |
| `Answer: name`     | The record owner.                                                                                                                                                                                                                             |
| `Answer: type`     | The type of DNS record. These are defined here: [https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4](https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4).               |
| `Answer: TTL`      | The number of seconds the answer can be stored in cache before it is considered stale.                                                                                                                                                        |
| `Answer: data`     | The value of the DNS record for the given name and type. The data will be in text for standardized record types and in hex for unknown types.                                                                                                 |
| `Authority: name`  | The record owner.                                                                                                                                                                                                                             |
| `Authority: type`  | The type of DNS record. These are defined here: [https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4](https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4).               |
| `Authority: TTL`   | The number of seconds the answer can be stored in cache before it is considered stale.                                                                                                                                                        |
| `Authority: data`  | The value of the DNS record for the given name and type. The data will be in text for standardized record types and in hex for unknown types.                                                                                                 |
| `Additional: name` | The record owner.                                                                                                                                                                                                                             |
| `Additional: type` | The type of DNS record. These are defined here: [https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4](https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4).               |
| `Additional: TTL`  | The number of seconds the answer can be stored in cache before it is considered stale.                                                                                                                                                        |
| `Additional: data` | The value of the DNS record for the given name and type. The data will be in text for standardized record types and in hex for unknown types.                                                                                                 |
| `Comment`          | List of EDE messages. Refer to [Extended DNS error codes](/1.1.1.1/infrastructure/extended-dns-error-codes/) for more information.                                                                                                            |

### Error response

| Field   | Description                                |
| ------- | ------------------------------------------ |
| `error` | An explanation of the error that occurred, as a string. |
| `raw_response` | The raw response body, as a string. |

<!-- END_TF_DOCS -->