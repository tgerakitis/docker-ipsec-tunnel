# docker-ipsec-tunnel
Docker container that supports IPsec (ikev2) VPN tunnels using a strongswan client with traefik as reverse proxy to forward the ports.

## How to use
Clone this repository and then edit `./strongswan/ipsec.conf` & `./strongswan/ipsec.secrets` according to your tunnel configuration.

Configure your target IP and port in `./traefik-conf/dynamic/dynamic.yml`.

In my example I build up a tunnel and connect to the SMTP port `25` on the tunneled IP `10.0.0.1` and expose it internally as `vpn-tunnel:1025`

    version: '2.4'
    services:
    vpn-tunnel:
        build:
        context: .
        # volumes:
        #   - "./traefik-conf/dynamic:/traefik-conf/dynamic/" # use your traefik configuration
        #   - "./strongswan:/conf" # use your strongswan ipsec files
        cap_add: # necessary for strongswan
        - NET_ADMIN
        ports:
        - "1025:1025" # where the example smtp port is forwarded
        - "8080:8080" # to visit traefik-dashboard: http://localhost:8080
        expose:
          - 1025
