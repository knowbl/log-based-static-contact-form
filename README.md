# Log based static contact form
---

This is a light weight contact form for self hosted static sites.

## Prerequisites

- NGINX (Apache coming soon).
- Read/write access to the server.
- `mail` for Debian/Ubuntu.

## Caveats

- Will not work with hosted solutions, like Github Pages.
- Target directory (`/submit/` in this example) must be an empty folder.
- One potential limitation can be charater limit. [See here for more information](http://stackoverflow.com/questions/2659952/maximum-length-of-http-get-request)

## Installation

### Step one: Log format

Within the http block of your nginx server, insert the log format for your specific configuration near the bottom of the block, but before the first server blocks. Less is recommended.

```nginx
log_format contactstatic '$time_local | $request';
```

See `nginx-exmaple.conf` placement location.

### Step two: Capture request

In the server block of your nginx server, insert the location of your action (`/submit/` in this instance) within the form.

```nginx
location ~* /submit/(.*)$ {

	access_log /home/example/logs/static-contact-access.log contactstatic;
	error_log /home/example/logs/static-contact-error.log;

	return https://example.com/;
}
```
This will return the visitor to the root directory. Tailor to your specific needs.

See `nginx-exmaple.conf` placement location.

### Step three: HTML Form

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
Add as many `<input>` as needed.

GET as the method is required, as it is need for parsing within the logs.

### Step four: Monitoring

There are several ways of monitoring your incoming form posts.

#### Tailing log files directly

```bash
tail /path/to/log/access.log
```


## TODO

- [ ] Apache config
- [ ] Add option in step four to open socket for direct access
- [ ] Form validation (client side)

## Feedback/Contributing

Any direct feedback can be given on the HackerNews post, here

[https://news.ycombinator.com/item?id=](https://news.ycombinator.com/item?id=)

Or raise an issue

[https://github.com/knowblcluster/log-based-static-contact-form/issues](https://github.com/knowblcluster/log-based-static-contact-form/issues)

## Donate

If this is useful to you, please donate to the EFF. I don't work there,
but they do fantastic work in the industry

[https://eff.org/donate/](https://eff.org/donate/)
