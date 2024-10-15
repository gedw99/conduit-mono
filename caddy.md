### Caddy 

https://github.com/caddyserver

cheatsheet is OK. https://webinstall.dev/caddy/


## Defaults

It will load the CaddyFile. The defaul one is a Reverse proxy with File Browsing enabled.

http://localhost
https://localhost

## Hosting

Fly scales to none, and if we can have MANY Domains in 1 fly app then its useful.
https://fly.io/docs/networking/custom-domains-with-fly/


## Generators

When we host a ton of Domains we will need to generate the Caddy

Its good quality and reflects off Docker to gen the Caddy. 
https://github.com/wemake-services/caddy-gen 

This is a Web GUI that we dont really need.
https://caddy.community/t/i-made-my-first-service-caddy-gen-a-web-gui-to-help-create-caddyfile/24703/8
https://caddy-gen.vercel.app
## API

The Caddy Admin API we can dynamically program Caddy with any configuration we want on the fly, without downtime.

http://localhost:2019

## Admin GUI

https://github.com/Gjergj/proxy_gui 

Seems to work but is closed.



## File Server Browse

Customsie the Default File Server Browser with extra stuff. 

Usage:

```sh
http:// {
    file_server {
        root /path/to/my/server/root
        browse /path/to/folder/caddy/templates/browse.html
    }
}
```

Code:

https://github.com/glowinthedark/caddy-file-server-browse-extension
https://github.com/glowinthedark/caddy-file-server-browse-extension/blob/master/browse.html

## Modules

XCaddy sucks. Its easier to just import them and then build like normal golang.


```go
package main

import (
	caddycmd "github.com/caddyserver/caddy/v2/cmd"

	// plug in Caddy modules here
	_ "github.com/caddyserver/caddy/v2/modules/standard"
	_ "github.com/KvalitetsIT/kitcaddy/modules/saml"
	_ "github.com/KvalitetsIT/kitcaddy/modules/prometheus"
	_ "github.com/KvalitetsIT/kitcaddy/modules/oioidwsrest"
)

func main() {
	caddycmd.Main()
}
```

## Load balancing per Data Center

https://www.linuxtrainingacademy.com/caddy-load-balancing-tutorial/


road robin
```sh
80 {   
     reverse_proxy 192.168.56.51 192.168.56.52 {
           lb_policy round_robin
     }
}
```sh

Sticky

```sh

80 {
     reverse_proxy 192.168.56.51 192.168.56.52 {
       lb_policy ip_hash
     }
}
```

## Load balancing globally with Cloudflare

The easiest is to host your Domains at Cloudflare and lets its AnyCast network it will automatically direct requeests to your Caddy Load Balander in each Data Center.

https://github.com/WeidiDeng/caddy-cloudflare-ip is needed

```sh
trusted_proxies cloudflare {
    interval 12h
    timeout 15s
}
```

## HTTPS automatically with Cloudflare

https://github.com/caddy-dns/cloudflare

```sh
tls {
	dns cloudflare {
		zone_token {env.CF_ZONE_TOKEN}
		api_token {env.CF_API_TOKEN}
	}
}
```
or

```sh
tls {
	dns cloudflare {env.CF_API_TOKEN}
}
```

Use Cloudflare for DNS resolution, so you see the HTTPS working immediately when you ad a new Site to your Caddy system.

```sh
tls {
  dns cloudflare {env.CF_API_TOKEN}
  resolvers 1.1.1.1
}
```

## Auth

Forward proxy is one way because you can forward auth requests to it.


Hanko or Authelia if uses should use Forward Auth as its a decoupled way to do it.
https://github.com/caddyserver/forwardproxy
egrated to Caddy.


## Authelia
Authelia uses this forward auth technoque with Caddy
https://www.authelia.com/reference/guides/proxy-authorization/#forwardauth

### AuthCrunch


AuthCrunch is directly integrated to Caddy

product: 	https://authcrunch.com
docs: 		https://docs.authcrunch.com
Videos:		https://www.youtube.com/@AuthCrunch

Not sure
https://github.com/greenpau/caddy-security

CTL / CLI
https://github.com/greenpau/go-authcrunch

Server

https://github.com/authcrunch
code for docs:		https://github.com/authcrunch/authcrunch.github.io
- its react 
code for server:	https://github.com/authcrunch/authcrunch
- imports everything.

```sh
module github.com/authcrunch/authcrunch

go 1.21

require (
	github.com/caddyserver/caddy/v2 v2.7.6
	github.com/greenpau/caddy-security v1.1.28
	github.com/greenpau/caddy-security-secrets-aws-secrets-manager v1.0.1
	github.com/greenpau/caddy-trace v1.1.13
)
```


## NATS Integation

Caddy GUI that uses NATS for
- Caddy V are sariables aved in NATS KV 
- Binaries are saved in NATS Object store.
- Now Backend and FrontEnd devs have a System for running all their stack locally and on Cloud.

Multi Server
- Devs can have many servers in many data centers

Git Ops
- Listend to Git Hooks
- Caddyfile and NATS KV from Git hooks go into NATS KV and so update all their Servers.
- Binaries from Git hooks go into NATS Obejct STore and so update all their Severs.

## Testing

Chapar for Testing them
- Just extend Chapar with have Caddy config editing

## GIO Webview Integration

Froent End devs need an easy way to have a Secure system for Web, Desktop and Mobile apps.

They can then just concenr themselves with Web GUI.

## Image Transform

https://github.com/PixyBlue/caddy-pixbooster
- On-the-fly image conversion for maximal network performances
- Does niot do video, only images. 
  - Video is long running, so need nats.


## OTHERS

https://github.com/Sjord/caddy-modules

https://github.com/RussellLuo
- https://github.com/protogodev
- Uses Annotations and then code gen. Really nice way to build things.

https://github.com/darkweak/souin
- Cache that caches localyl and works with Upstream CDNS at the smae time.
- Can offload a ton of things off oyur server.

https://github.com/sandstorm/caddy-nats-bridge
- Routes http to nats.
- puts lohs into NATS




