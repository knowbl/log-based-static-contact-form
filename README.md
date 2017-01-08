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

### Step three

Add the form on your site. Style as needed.

```html
<form action="/submit/" method="GET">

	<label for="name">Name:</label>
	<input type="text" name="name" required="yes" placeholder="What can I call you?">

	<label for="email">Email:</label>
	<input type="email" name="email" required="yes" placeholder="your@email.com">

	<label for="message">Short message:</label>
	<textarea type="message" name="message" required="yes" placeholder="What do you want to say (in 140 characters)?" maxlength="140"></textarea>

	<input type="submit" value="Send a message">
</form>
```
GET is required, as we'll need that whilst parsing logs

### Step four

There are several ways of monitoring your incoming form posts.

#### Tailing log files directly

```bash
tail /path/to/log/access.log
```

## TODO

- [ ] Apache config
- [ ] Add option in step four to open socket for direct access
- [ ]
