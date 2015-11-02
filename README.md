# HTTP Yeah You Know Me

## Project Overview

In this project we'll begin to introduce HTTP, the protocol that runs the web, and build a functioning web server to put that understanding into action.

### Learning Goals

* Practice breaking a workflow into a system of coordinating components
* Practice using TDD at the unit, integration, and acceptance levels
* Understand how the HTTP request/response cycle works
* Practice implementing basic HTTP requests and responses

## The Project

You're going to build a web application capable of:

* Receiving a request from a user
* Comprehending the request's intent and source
* Generating a response
* Sending the response to the user

### Iteration 0 - Hello, World

Build a web application/server that:

* listens on port 9292
* responds to HTTP requests
* responds with a valid HTML response that displays the words `Hello, World! (0)` where the `0` increments each request until the server is restarted

### Iteration 1 - Outputting Diagnostics

Let's start to rip apart that request and output it in your response. In the body of your response, include a block of HTML like this including the actual information from the request:

```html
<pre>
Verb: POST
Path: /
Protocol: HTTP/1.1
Host: 127.0.0.1
Port: 9292
Origin: 127.0.0.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
</pre>
```

Keep the code that outputs this block at the bottom of all your future outputs to help with your debugging.

### Iteration 2 - Supporting Paths

Now let's react to the `path` that the user specifies:

* If they request the root, aka `/`, respond with just the debug info from V1.
* If they request `/hello`, respond with "Hello, World! (0)" where the `0` increments each time the path is requested, but not when any other path is requested.
* If they request `/datetime`, respond with today's date and time in this format: `11:07AM on Sunday, October November 1, 2015`.
* If they request `/shutdown`, respond with "Total Requests: 12" where `12` is the aggregate of all requests. It also causes the server to exit / stop serving requests.

### Iteration 3 - Supporting Parameters

Often we want to supply some data with a request. For instance, if you were submitting a search, that'd typically be a `GET` request that has a parameter. When we use parameters in `GET` requests they are embedded in the URL like this:

```
http://host:port/path?param=value&param2=value2
```

You know your computer has a dictionary built in, right? Write an "endpoint" that works like this:

* The path is `/word_search`
* The verb will always be a `GET`
* The parameter will be named `word`
* The value will be a possible word fragment

In your HTML response page, output one of these:

* `WORD is a known word`
* `WORD is not a known word`

Where `WORD` is the parameter from the URL.

### Iteration 4 - Verbs & Parameters

The *path* is the main way that the user specifies what they're requesting, but the secondary tool is the *verb*. There are several official verbs, but the only two typical servers use are `GET` and `POST`.

We use `GET` to fetch information. We typically use `POST` to send information to the server. When we submit parameters in a `POST` they're in the body of the request rather than in the URL.

Let's write a simple guessing game that works like this:

#### `POST` to `/start_game`

This request begins a game. The response says `Good luck!` and starts a game.

#### `GET` to `/game`

A request to this verb/path combo tells us:

* a) how many guesses have been taken.
* b) if a guess has been made, it tells what the guess was and whether it was too high, too low, or correct

#### `POST` to `/game`

This is how we make a guess. The request includes a parameter named `guess`. The server stores the guess and sends the user a redirect response, causing the client to make a `GET` to `/game`.

### Iteration 5 - Response Codes

We use the HTTP response code as a short hand way to explain the result of the request. Here are the most common HTTP status codes:

* `200 OK`
* `301 Moved Permanently`
* `401 Unauthorized`
* `403 Forbidden`
* `404 Not Found`
* `500 Internal Server Error`

Let's modify your game from Iteration 4 to use status codes:

* Most requests, unless listed below, should respond with a `200`.
* When you submit the `POST` to `/new_game` and there is no game in progress, it should start one and respond with a `301` redirect.
* When you submit the `POST` to `/new_game` but there is already a game in progress, it should respond with `403`.
* If an unknown path is requested, like `/fofamalou`, the server responds with a `404`.
* If the server generates an error, then it responds with a `500`. Within the response let's present the whole stack trace. Since you don't write bugs, create an `/force_error` endpoint which just raises a `SystemError` exception.

## Extensions

### 1. HTTP-Accept

The `HTTP-Accept` parameter is used to specify what kind of data the client wants in response. Modify your `/word_search` path so that if the `HTTP-Accept` starts with `application/json` then they are sent a JSON body like the following.

A search for `pizza` returns this JSON:

```
{"word":"pizza","is_word":true}
```

A search for `pizz` returns JSON with possible matches like this:

```
{"word":"pizza","is_word":true,"possible_matches":["pizza","pizzeria","pizzicato"]}
```

### 2. Threading

What happens if your web server gets more than one request at a time? Let's experiment with Threads. *to be continued*
