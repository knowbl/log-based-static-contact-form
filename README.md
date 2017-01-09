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

#### 1) Tailing log files directly

Direct view of the live log file.

```bash
tail -f /home/example/logs/access.log
```

#### 2) Cron job

Send requests to an email address.

```bash
cd /home/example/
nano log-based-static-contact-form-emailer.sh
```

```bash
#!/bin/bash

EMAIL="hello@example.com"
EMAILSUBJECT="Contact form"
LOG="/home/example/logs/static-contact-access.log"
CRON="/home/example/logs/example-cron.log"

### DO NOT EDIT BELOW ###

NOW=$(date +"Form sent to $EMAIL -- %Y-%m-%d %H:%M:%S --");

if [ ! -f $LOG ];
then
	printf "." >> $CRON
else
	mail -s "$EMAILSUBJECT" $EMAIL < $LOG;
	printf "\n \n $NOW \n \n" >> $CRON
fi
```
>	Note: Depending on who fills out your form (bad guys?), you might want to send an alert that there's new contact form information, rather than sending the whole log in the body of an email.

```bash
chmod +x log-based-static-contact-form-emailer.sh
```

```bash
crontab -e
```
Add to the bottom of the crontab

```cron
0 9-17 * * 1-5 /var/log/log-based-form.sh
```
This cron is set for every hour, on the hour, 9am through to 5pm, Monday through to Friday. Feel free to set to something more applicable to your own setup.

#### 3) Be creative

- Parse the log file every day and send an automated reply email, if not replied to.
- Create a chat bot that logs each input for later analysis.
- Keep a list of reoccurring IP addresses, or email addresses for your own blacklist.

## TODO

- [ ] Apache config
- [ ] Add option in step four to open socket for direct access
- [ ] Form validation (client side)

## Feedback/Contributing

Any direct feedback can be given on the HackerNews post, here

[https://news.ycombinator.com/item?id=13358753](https://news.ycombinator.com/item?id=13358753)

Or raise an issue

[https://github.com/knowblcluster/log-based-static-contact-form/issues](https://github.com/knowblcluster/log-based-static-contact-form/issues)

## Donate

If this is useful to you, please donate to the EFF. I don't work there,
but they do fantastic work in the industry

[https://eff.org/donate/](https://eff.org/donate/)
