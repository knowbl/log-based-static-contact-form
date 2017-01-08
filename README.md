# Log based static contact form
---

This is a tiny contact form for static sites.

## Prerequisites

- NGINX (Apache coming soon).
- Read/write access to the server.

## How to use

### Step one

Within the http block of your nginx server, insert the log format for your specific configuration. Less is recommended.

```nginx
log_format contactstatic '$time_local | $request';
```

See `nginx-exmaple.conf` placement location.

### Step two

In the server block of your nginx server, insert the location of your action within the form.

```nginx
location ~* /submit/(.*)$ {

	access_log /var/logs/static-contact-access.log contactstatic;
	error_log /var/logs/static-contact-error.log;

	return https://example.com/;
}
```
