
# Lilyturf is a simple template engine for CoffeeScript

### Install

You can install Lilyturf with NPM:

```bash
npm install lilyturf
```

### Usage

Its syntax looks like:

```coffee
{html} = require './lilyturf'
{tidy} = require 'htmltidy'

data =
  lily: 'flower'
  lilyturf: 'plant'

page = html ->
  @div class: 'demo',
    @div id: 'demo',
      for name, type of data
        @div class: 'content',
          @text "#{name}: #{type}"
    if data.others?
      @div class: 'more', (@text data.others)

tidy page, indent: yes, (err, new_page) ->
  console.log new_page
```

In `.html()`, `@` contains tag names as methods.

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