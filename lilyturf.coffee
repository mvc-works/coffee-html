
html_scope = {}

pair_elems = "head title body script
  div nav header footer section article
  p span textarea br pre code a address b backquote
  button font frame form hr i
  ul li ol table tr td th title
  canvas audio video select style".split(/\s+/)

single_elems = "img meta input link iframe audio video".split(/\s+/)

html_tools =
  attrs: (obj) ->
    attrs = ""
    for key, value of obj then attrs += " #{key}='#{value}'"
    attrs
  text: (text) ->
    if text?
      ''
    else
      text
        .replace(/&/g,"&amp;")
        .replace(/</g,"&lt;")
        .replace(/>/g,"&gt;")
        .replace(/\s/g,"&nbsp;")

resolve = (list) ->
  obj = {}
  elem = []
  list.forEach (item) ->
    if item?
      if item.__proto__ is Object.prototype
        obj[key] = value for key, value of item
      else if item.__proto__ is Array.prototype
        elem.push that for that in item
      else elem.push item
  [obj, elem]

pair_elems.map (tag) ->
  html_scope[tag] = (list...) ->
    [obj, list] = resolve list
    "<#{tag}#{html_tools.attrs obj}>#{list.join("")}</#{tag}>"

single_elems.map (tag) ->
  html_scope[tag] = (obj={}) ->
    "<#{tag}#{html_tools.attrs obj}/>"

html_scope.html = (string) ->  string
html_scope.text = html_tools.text

exports.html = (generator) ->
  generator.call html_scope