
# Lilyturf is a simple template engine for CoffeeScript

### Install

You can install Lilyturf with NPM:

```bash
npm install lilyturf
```

### Usage

Its syntax looks like:

```coffee
{html, css} = require "lilyturf"

page = html ->
  @div class: "new",
    @span id: "none", "x"

style = css ->
  "html":
    "css": "red"
    head:
      fontSize: 10
      color: @hsl 10, 20, 30
```

In `.html()`, `@` contains tag names as methods,  
In `.css()`, `@` contains functions like `hsl` for convenience.  

### Goal

I hate crazy brackets, I hate enormous closing tags.  
Let it be simple to template HTML in CoffeeScript!  
JS is invented to handle web pages, why is templating so ugly in JS?!  

Early prototype on Gist: https://gist.github.com/2498711  
After a long time, I found it was almost what I was looking for.  
Then I rewrite it and name it lilyturf.  

### Referece and Thanks

`Browserify` and `Coffeeify` are great tools!  
https://github.com/substack/node-browserify  
https://github.com/substack/coffeeify  

### License

BSD