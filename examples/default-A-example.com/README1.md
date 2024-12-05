# Simple Example

Using the default (Google) nameserver to lookup the `"A"` record for `"example.com"`

```hcl
module "dns_http_json" {
  source = "github.com/cunneen/terraform-dns-http-json"
  name   = "example.com"
}

output "example_com_A" {
  description = "A record for example.com"
  value       = module.dns_http_json
}
```

Output:

```hcl
example_com_A = {
  "dns_response" = {
    "AD" = true
    "Answer" = [
      {
        "TTL" = 2545
        "data" = "93.184.215.14"
        "name" = "example.com."
        "type" = 1
      },
    ]
    "CD" = false
    "Question" = [
      {
        "name" = "example.com."
        "type" = 1
      },
    ]
    "RA" = true
    "RD" = true
    "Status" = 0
    "TC" = false
  }
}

```
