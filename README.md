
Coffee-HTML is a simple template engine for CoffeeScript
------

Trying to generate HTML from CoffeeScript syntax.
Early prototype on Gist: https://gist.github.com/2498711

### Usage

You can install Coffee-HTML with NPM:

```bash
npm install coffee-html
```

Its syntax looks like:

```coffee
{html} = require './html'
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

### License

MIT