# Log based static contact form
---

This is a tiny contact form for static sites.
## How to use

### Step one

Within the http block of your nginx server, insert the log format for your specific configuration. Less is recommended.

```nginx
log_format contactstatic '$time_local | $request';
```
