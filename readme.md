
# Lilyturf is a simple template engine for CoffeeScript

### Install

You can install Lilyturf with Bower:

```bash
bower install lilyturf
```

The main file is `page/lilyturf.js`.

### Usage

Include `page/lilyturf.js` in your HTML with `<script>` to start.  
Here's a demo for Chrome users: http://jiyinyiyong.github.com/lilyturf/page  
I've only tested it in Chrome. Be careful in other browers.  

After the script loaded, you will get a `lilyturf` Object with two methods:

```coffee
lilyturf.html
lilyturf.dom
```

Each one takes a function and returns HTML in string or DOM in DOM Object.

```coffeescript
lilyturf.html ->
  @div {class: "demo", id: "unique"},
    @div {class: "a"},
      @text: "string has no attributes"
    @div {class: "b"},
      @html: "html is string but not being escaped"
# above returns an HTML string
      
lilyturf.dom ->
  @div {class: "demo", id: "unique"},
    @div {class: "a"},
      @text: "string has no attributes"
    @div {class: "b"},
      @html: "html is string but not being escaped"
# this one returns a `<div>` DOM element.
```

And a exprimental CSS template:

```coffee
lilyturf.css ->
  body:
    padding: 0
    color: @hsl 10, 10, 80

    p:
      display: ["-webkit-box", "-moz-box"]

      a:
        color: "hsl(0,0%,80%)"
  pre:
    display: "none"
```

I added some syntax sugars which you may read them in the tests:  

```coffee
do test = ->
  lily = lilyturf
  log = -> console.log arguments...
  data =
    1: -> @div "test"
    2: -> "string"
    3: -> @div {}, "code"
    4: -> @div {id: "name"}, "code"
    5: -> @div {},
      if yes then @div "yes"
      if no then @div "no"
    6: -> @div {},
      @div "item #{i}" for i in [1,2,3,4]
      {class: "for loop"}
      undefined
    7: -> @div {},
      @div i for i in [1,2,3,4]

  for key, item of data
    log (lily.dom item)
    log (lily.html item)
```

Notice that it's different for them to deal with events.  
In the latter version, attributes matches `/^on/` will become real events.  
I'm afraid you should read my code to see how to use it.  

### Goal

I hate crazy brackets, I hate enormous closing tags.  
Let it be simple to template HTML in CoffeeScript!  
JS is invented to handle web pages, why is templating so ugly in JS?!  

Early prototype on Gist: https://gist.github.com/2498711  
After a long time, I found it was almost what I was looking for.  
Then I rewrite it and name it lilyturf.  

### Referece and Thanks

I used `highlight.js` to highlight my CoffeeScript source code:  
https://github.com/isagalaev/highlight.js

And `marked` to render `readme.md` into HTML:  
https://github.com/chjj/marked

The CSS template is inspired by `ccss` and `coffee-css`:  
https://github.com/khoomeister/coffee-css/blob/master/src/coffee-css.coffee  
https://github.com/aeosynth/ccss/blob/master/src/ccss.coffee

### License

BSD