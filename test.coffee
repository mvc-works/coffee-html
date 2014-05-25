
{html} = require './coffee/html'
{tidy} = require 'htmltidy'

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

tidy page, indent: yes, (err, new_page) ->
  console.log new_page