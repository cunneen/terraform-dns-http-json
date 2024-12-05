# Getting your Client IP with OpenDNS

 Use OpenDNS to lookup the IP address of the computer upon which `terraform
  plan` or `terraform apply` is being run

```hcl
module "dns_http_json" {
  source   = "../.."
  endpoint = "https://myipv4.p1.opendns.com/get_my_ip"
  name     = "o-o.myaddr.google.com" # The OpenDNS service doesn't actually require the
  #                                    `name` parameter at all, but we *do* require it
  #                                    (as per Google's specification) and OpenDNS
  #                                    seems happy enough if we include it
}

output "my_ip" {
  description = "my_ip"
  value       = module.dns_http_json
}
```

Output:

```hcl
my_ip = {
  "dns_response" = {
    "ip" = "61.245.138.65"
  }
}
```
