---
title: "Start Python Webserver from Command Line"
layout: "post"
tags: post,python,http server
---

Both Python 2 and Python 3 provide HTTP server libaries that allow you to start HTTP server directly without any programming.
This feature is very useful when workin on a web application that requires a web server.

The HTTP server modules in Python 2 and Python 3 are different.

<h2>Python 2</h2>

``` bash
# Start Python HTTP Server
$ python -m SimpleHTTPServer 80
```

This serves files relative to the current directory.

For more information check the [Python 2 `SimpleHTTPServer` documentation page](https://docs.python.org/2/library/simplehttpserver.html).

<h2>Python 3</h2>

``` bash
# Start Python 3 HTTP Server listening to all interfaces.
$ python -m http.server 80
```

Similar to the Python 2 example, this serves files relative to the current directory.

By default the server binds itself to all network interfaces. You can specify which interface to listen to using the `-b` (since Python 3.4 `--bind` option is available)  option.

``` bash
# Start Python 3 HTTP Server listening to 127.0.0.1 interaface
$ python -m http.server 80 --bind 127.0.0.1
```

For more information check the [Python 3 `http.server` documentation page](https://docs.python.org/3/library/http.server.html).


