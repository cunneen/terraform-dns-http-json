# Simple Example

Using the default (Google) nameserver to lookup the `"A"` record for `"example.com"`

```hcl
module "http-json" {
  source = "cunneen/http-json/dns"
  name   = "example.com"
}

output "example_com_A" {
  description = "A record for example.com"
  value       = module.http-json
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
