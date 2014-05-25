
Coffee-HTML: generate HTML in CoffeeScript
------

### Usage

You can install Coffee-HTML with NPM:

```bash
npm install coffee-html
```

Its syntax looks like:

```coffee
{html} = require 'coffee-html'

data =
  rose: 'flower'
  lilyturf: 'plant'

page = html ->
  @div class: 'demo',
    @div id: 'demo',
      for name, type of data
        @div class: 'content',
          @text "#{name}: #{type}"
    if data.others?
      @div class: 'more', (@text data.others)

page # => generated HTML here
```

This package only supports tags that defined in the source code.
Customized tags are not supported.

### Changelog

* `0.4.2`
  * Refactor code from my early years
  * Remove `__proto__`

* `0.4.0`
  * Previously named Liliturf, renamed to Coffee-HTML

### Early ideas:

A Gist: https://gist.github.com/2498711

### License

MIT