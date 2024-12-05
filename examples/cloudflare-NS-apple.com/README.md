# Use Cloudflare to lookup the NS records for Apple

```hcl
module "http-json" {
  source   = "cunneen/http-json/dns"
  name     = "apple.com"
  type     = "NS"
  endpoint = "https://cloudflare-dns.com/dns-query"
  headers = {
    accept = "application/dns-json"
  }
}

output "apple_NS_records" {
  description = "NS Records for apple.com"
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