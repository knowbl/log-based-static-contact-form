# Log based static contact form
---

This is a light weight contact form for self hosted static sites.

## Prerequisites

- NGINX (Apache coming soon).
- Read/write access to the server.

## Caveats

- Will not work with hosted solutions, like Github Pages.
- Target directory (`/submit/` in this example) must be an empty folder.
- One potential limitation can be charater limit. [See here for more information](http://stackoverflow.com/questions/2659952/maximum-length-of-http-get-request)

## Installation

### Step one: Log format

Within the http block of your nginx server, insert the log format for your specific configuration. Less is recommended.

```nginx
log_format contactstatic '$time_local | $request';
```

See `nginx-exmaple.conf` placement location.

### Step two: Capture request

In the server block of your nginx server, insert the location of your action within the form.

```nginx
location ~* /submit/(.*)$ {

	access_log /home/example/logs/static-contact-access.log contactstatic;
	error_log /home/example/logs/static-contact-error.log;

	return https://example.com/;
}
```

See `nginx-exmaple.conf` placement location.

### Step three: Form

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
