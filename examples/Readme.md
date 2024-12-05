# Examples

## Example usage of the `terraform-dns-http-json` module

| Folder | Description |
|---|---|
| [Simple](./default-A-example.com/) | Using the default (Google) nameserver to lookup the `"A"` record for `"example.com"` |
| [OpenDNS](./openDNS-A-myipv4/) | Using [OpenDNS](https://www.opendns.com/) to lookup your own terraform client's IP address (i.e. the IP address of the computer upon which `terraform plan` or `terraform apply` is being run) |
| [Cloudflare](./cloudflare-NS-apple.com/) | Using [Cloudflare](https://www.cloudflare.com/) to lookup the `"NS"` records for `apple.com` |
