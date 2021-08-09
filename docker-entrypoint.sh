#!/bin/sh -e

{
	# wait to make sure ipsec is started when upping the tunnel
	sleep 2
	ipsec up ezvpn
	traefik --configfile /traefik-conf/traefik.yml
} &

exec ipsec start --nofork "$@"
