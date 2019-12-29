DNServer (edited)
===

DNS Server written in Python, with some edits (and default responses)
This is written in order to make Avahi/mDNS records available via DNS, but can be used to expose other records too.

## Behaviour

- Script uses the `gethostbyname` function for DNS lookup
	- If records are found, return 
	- If none are found it proxies the request to an upstream DNS server, eg. CloudFlare at `1.1.1.1`.
		- If no results are found, return a **hardcoded IP address** (instead of a `NXDOMAIN` response), i.e: `127.0.0.1` / `::1`

To change the hardcoded IP address, remember to `export` the following variables before running the installation script:
- `FALLBACK_IPV4`
- `FALLBACK_IPV6`

## Installation

```
wget https://raw.githubusercontent.com/theroyalstudent/dnserver/master/scripts/setup.sh -O setup-dnserver.sh && bash setup-dnserver.sh
```

Example with the IP addresses hardcoded:
```
export FALLBACK_IPV4=1.2.3.4
export FALLBACK_IPV6=2000:1234:5678:dead:beef

wget https://raw.githubusercontent.com/theroyalstudent/dnserver/master/scripts/setup.sh -O setup-dnserver.sh && bash setup-dnserver.sh
````

### Copyright

Copyright &copy; 2019 [Edwin A.](https://theroyalstudent.com).

Special thanks to Samuel Colvin for the initial codebase.