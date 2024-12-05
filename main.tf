# Copyright (c) Mike Cunneen
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "3.4.5"
    }
  }
  required_version = "~> 1.2"
}

# ==== Reformats the provided variable values into a query string ====
locals {
  # Merge all the query parameters
  nameParam = {
    (var.query_param_name) : var.name
  }
  other_query_params = {
    type               = var.type
    do                 = var.do
    ct                 = var.ct
    cd                 = var.cd
    edns_client_subnet = var.edns_client_subnet
    random_padding     = var.random_padding
  }

  all_query_params = merge(local.nameParam, local.other_query_params, var.query_params)
  querystring = join("&", [
    for k, v in local.all_query_params : "${k}=${urlencode(v)}" if v != null && v != ""
  ])
}

data "http" "dns_response" {
  url             = "${var.endpoint}?${local.querystring}"
  method          = "GET"
  request_headers = var.headers
  request_body    = var.request_body
  lifecycle {
    postcondition {
      condition     = self.status_code >= 200 && self.status_code < 300
      error_message = "${var.endpoint}?${local.querystring} returned an unhealthy status code"
    }
  }
}

