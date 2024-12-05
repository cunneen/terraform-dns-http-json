# Get the A record for example.com
module "dns_http_json" {
  source = "../.."
  name   = "example.com"
}

output "example_com_A" {
  description = "A record for example.com"
  value       = module.dns_http_json
}
