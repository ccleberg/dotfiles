# ----------------------------------------------------------------------
# | Config file for host                                   |
# ----------------------------------------------------------------------
server {
	listen [::]:443 ssl;
	listen 443 ssl;
	http2 on;

	server_name www.cleberg.io cleberg.io;

	include custom.d/tls/ssl_engine.conf;
	include custom.d/tls/policy_balanced.conf;
#	include custom.d/tls/certificate_files.conf;
	ssl_certificate         /etc/letsencrypt/live/cleberg.io/fullchain.pem;
	ssl_certificate_key     /etc/letsencrypt/live/cleberg.io/privkey.pem;
	ssl_trusted_certificate /etc/letsencrypt/live/cleberg.io/chain.pem;

	return 301 $scheme://cleberg.io$request_uri;
}


server {
	listen [::]:443 ssl;
	listen 443 ssl;
	http2 on;

	server_name cleberg.io;

	include custom.d/tls/ssl_engine.conf;
	include custom.d/tls/policy_balanced.conf;
	include custom.d/basic.conf;

#	include custom.d/tls/certificate_files.conf;
	ssl_certificate         /etc/letsencrypt/live/cleberg.io/fullchain.pem;
	ssl_certificate_key     /etc/letsencrypt/live/cleberg.io/privkey.pem;
	ssl_trusted_certificate /etc/letsencrypt/live/cleberg.io/chain.pem;

	# ----------------------------------------------------------------------
	# | Custom rules & config for specific website                     |
	# ----------------------------------------------------------------------
	return 301 https://cleberg.net;
	# ----------------------------------------------------------------------
}

# ----------------------------------------------------------------------
# | Config file for non-secure host                        |
# ----------------------------------------------------------------------
server {
	listen [::]:80;
	listen 80;
	server_name www.cleberg.io cleberg.io;

	return 301 https://cleberg.io$request_uri;
}
