# Use Adguard's DNS to lookup the TXT records for amazon.com

```hcl
module "http-json" {
  source   = "cunneen/http-json/dns"
  name     = "amazon.com"
  type     = "TXT"
  endpoint = "https://dns.adguard-dns.com/resolve"
}

output "amazon_TXT_records" {
  description = "TXT Records for amazon.com"
  value       = module.http-json
}

```

Output:

```hcl
amazon_TXT_records = {
  "dns_response" = {
    "AD" = false
    "Answer" = [
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"sending_domain949422=43d714838567583460e7720e6049505edb8e25c1ef4321419d41bc5255db7ba5\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"sending_domain949422=99a7b44052aefc4dec2abf56189160824664d2fdac00ca962f4455be62b51d56\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"spf2.0/pra include:spf1.amazon.com include:spf2.amazon.com include:amazonses.com -all\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"sending_domain1003771=199bc63a54ace5d8d5c5d08286af86d7049b4afacb5ef7decd6b22cf9e8d5efb\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"sending_domain1003771=f1303d8ee3b86e39db2703b11feb83e1e8b712a9ffc64c3d56505192e5b3bf4f\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"sending_domain1014172=003846595520e80ec84e8cc47c07e3a71afb855fc743bb92cdec93f88c7a4029\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"box-domain-verification=ffea95cd0e0d61c302198367155b07e74fd534fa1d867662dc9bf9969b6f535d\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"cisco-ci-domain-verification=1b256bd11daa486ba2fa405d2d5de70f75feb6757dd8993ca8de685a7dfea1df\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"atlassian-domain-verification=ZT4AapXgobCpXIWoNcd7gtMjZyOUdr4EDFMnFUWrqqqgdaQVbDvoGpRaIwj/tgPH\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"wrike-verification=MzI3NzM2ODo2NDk5MjE4NjQ2MWJmOTEwMGMxM2MzNzJmNWJlY2U5ZDU4MmVlNzQ2NWU4MTY5OWJjMjlmYjQ4Mjc5M2JiMzky\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"ZOOM_verify_ARI4AiKALCcjulAUZNwR8S\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"apple-domain-verification=4wbNaeWvAH0pU1yi\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"apple-domain-verification=dVkKZnu17XS0EN2X\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"MS=4B600B22799EB2CAC0D8FF0A3A3CAECA5EE2BF3A\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"brevo-code:9be7f7c39958d253a31de6593fa831bc\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"canva-site-verification=Hksh9WEUPWP13_SEU1mPMA\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"canva-site-verification=WhUvTbfe6tUQWmIXnQifGA\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"autodesk-domain-verification=dmryiygGOGBJFJFVo5Bl\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"facebook-domain-verification=d9u57u52gylohx845ogo1axzpywpmq\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"pendo-domain-verification=ecbe1a51-954d-4202-ab86-d15e04b96769\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"google-site-verification=14WGW2MdNMxchG8PlinF7LgqqE0OwwHqOq0HKhb7rDQ\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"google-site-verification=D0RwRb_QApkpApKTFaFlRwbm_yrkey0uokKw0wQUIdk\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"google-site-verification=G_-mXb0ZYjjGkQVGjpOOB2deSOaVdxVj4i4vozJTREs\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"liveramp-site-verification=jZJKgMEQ_1mdjMhKj02iqNACZ-NJHRWhCEQdQ_OuCMo\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"pardot326621=b26a7b44d7c73d119ef9dfd1a24d93c77d583ac50ba4ecedd899a9134734403b\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"v=spf1 include:spf1.amazon.com include:spf2.amazon.com include:amazonses.com -all\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"stripe-verification=45f746e3b195198f419af3f685fdf217532ce552b4b47070b3caefe325559a67\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"stripe-verification=6a5d107aa37465eac2101bb1c725b02072689a4fa7bd38b455970baac4979a17\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"stripe-verification=B0AD8DC1918B8A717E5B6A29C2E04594A9872AB05F8DA24CB762BBA0A0487BC6\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"stripe-verification=a27edc0da55836ea6bb7eac592bf2ca8e246eb652608d54493119df7df005afc\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"stripe-verification=a5c01aa4d732f4b93154d67983d77982ef1a2db73fecfd4bcd64e224d3ab4075\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"sending_domain229492=341509a116ea4311fcb2e489303bf09a139b10ce9b90e5029d2677055cb4dc89\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"sending_domain229492=7cde83fbc5246557c64d9d9ba79f0d11f7ba9eb6127f60451a9aa6f8dead4381\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"sending_domain608861=81b0d52095dae60d604e7cbea5e58e1d842f7d950d6673a43feae339b664ca31\""
        "name" = "amazon.com."
        "type" = 16
      },
      {
        "TTL" = 900
        "class" = 1
        "data" = "\"sending_domain608861=d33a88e8540c33a1217138cf8a25879734bd35673bb7cfbd639f95c550b33ec4\""
        "name" = "amazon.com."
        "type" = 16
      },
    ]
    "CD" = false
    "Extra" = null
    "Question" = [
      {
        "name" = "amazon.com."
        "type" = 16
      },
    ]
    "RA" = true
    "RD" = true
    "Status" = 0
    "TC" = false
  }
}
```
