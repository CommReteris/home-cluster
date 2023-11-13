// Configure the matchbox provider

data "sops_file" "matchbox_secrets" {
  source_file = "secret.sops.yaml"
}

provider "matchbox" {
  endpoint    = data.sops_file.matchbox_secrets.data["matchbox_rpc_endpoint"]
  client_cert = file("~/.config/matchbox/client.crt")
  client_key  = file("~/.config/matchbox/client.key")
  ca          = file("~/.config/matchbox/ca.crt")
}

terraform {
  required_providers {
    ct = {
      source  = "poseidon/ct"
      version = "0.13.0"
    }
    matchbox = {
      source  = "poseidon/matchbox"
      version = "0.5.2"
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }
  }
}
