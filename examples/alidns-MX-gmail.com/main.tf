# Use Alibaba Cloud's DNS-over-HTTPS provider to lookup the MX records for gmail.com

module "http-json" {
  source   = "../.."
  name     = "gmail.com"
  type     = "MX"
  endpoint = "https://dns.alidns.com/resolve"
}

output "gmail_MX_records" {
  description = "MX Records for gmail.com"
  value       = module.http-json
}
# ==== OUTPUT ====
# ```hcl
# gmail_MX_records = {
#   "dns_response" = {
#     "AD" = false
#     "Answer" = [
#       {
#         "TTL" = 1
#         "data" = "5 gmail-smtp-in.l.google.com."
#         "name" = "gmail.com."
#         "type" = 15
#       },
#       {
#         "TTL" = 1
#         "data" = "40 alt4.gmail-smtp-in.l.google.com."
#         "name" = "gmail.com."
#         "type" = 15
#       },
#       {
#         "TTL" = 1
#         "data" = "20 alt2.gmail-smtp-in.l.google.com."
#         "name" = "gmail.com."
#         "type" = 15
#       },
#       {
#         "TTL" = 1
#         "data" = "10 alt1.gmail-smtp-in.l.google.com."
#         "name" = "gmail.com."
#         "type" = 15
#       },
#       {
#         "TTL" = 1
#         "data" = "30 alt3.gmail-smtp-in.l.google.com."
#         "name" = "gmail.com."
#         "type" = 15
#       },
#     ]
#     "CD" = false
#     "Question" = {
#       "name" = "gmail.com."
#       "type" = 15
#     }
#     "RA" = false
#     "RD" = true
#     "Status" = 0
#     "TC" = false
#   }
# }
# ```