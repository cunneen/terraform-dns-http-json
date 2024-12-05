# Use NextDNS to lookup the CNAME records for www.taobao.com

Using NextDNS' nameservers to lookup the `"CNAME"` record for `"www.taobao.com"`

```hcl
module "http-json" {
  source = "cunneen/http-json/dns"
  type   = "CNAME"
  endpoint = "https://dns.nextdns.io/resolve"
  name   = "taobao.com"
}

output "taobao_CNAME" {
  description = "CNAME Records for taobao.com"
  value       = module.http-json
}
```

Output:

```hcl
taobao_CNAME = {
  "dns_response" = {
    "AD" = false
    "Additional" = [
      {
        "TTL" = 0
        "data" = <<-EOT
        
        ;; OPT PSEUDOSECTION:
        ; EDNS: version 0; flags:; udp: 1232
        EOT
        "name" = "."
        "type" = 41
      },
    ]
    "Answer" = [
      {
        "TTL" = 600
        "data" = "www.taobao.com.danuoyi.tbcache.com."
        "name" = "www.taobao.com."
        "type" = 5
      },
    ]
    "CD" = false
    "Question" = [
      {
        "name" = "www.taobao.com."
        "type" = 5
      },
    ]
    "RA" = true
    "RD" = true
    "Status" = 0
    "TC" = false
  }
}

```
