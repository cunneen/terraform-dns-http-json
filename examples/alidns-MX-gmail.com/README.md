# Use Alibaba Cloud to lookup the MX records for gmail.com

```hcl
module "http-json" {
  source   = "cunneen/http-json/dns"
  name     = "gmail.com"
  type     = "MX"
  endpoint = "https://dns.alidns.com/resolve"
}

output "gmail_MX_records" {
  description = "MX Records for gmail.com"
  value       = module.http-json
}

```

Output:

```hcl
gmail_MX_records = {
  "dns_response" = {
    "AD" = false
    "Answer" = [
      {
        "TTL" = 1
        "data" = "5 gmail-smtp-in.l.google.com."
        "name" = "gmail.com."
        "type" = 15
      },
      {
        "TTL" = 1
        "data" = "40 alt4.gmail-smtp-in.l.google.com."
        "name" = "gmail.com."
        "type" = 15
      },
      {
        "TTL" = 1
        "data" = "20 alt2.gmail-smtp-in.l.google.com."
        "name" = "gmail.com."
        "type" = 15
      },
      {
        "TTL" = 1
        "data" = "10 alt1.gmail-smtp-in.l.google.com."
        "name" = "gmail.com."
        "type" = 15
      },
      {
        "TTL" = 1
        "data" = "30 alt3.gmail-smtp-in.l.google.com."
        "name" = "gmail.com."
        "type" = 15
      },
    ]
    "CD" = false
    "Question" = {
      "name" = "gmail.com."
      "type" = 15
    }
    "RA" = false
    "RD" = true
    "Status" = 0
    "TC" = false
  }
}
```
