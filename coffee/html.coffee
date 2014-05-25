
htmlScope = {}

pairElements = "head title body script
  div nav header footer section article
  p span textarea br pre code a address b backquote
  button font frame form hr i
  ul li ol table tr td th title
  canvas audio video select style".split(/\s+/)

singleElements = "img meta input link iframe audio video".split(/\s+/)

htmlUtil =
  attrs: (obj) ->
    attrs = ""
    for key, value of obj
      attrs += " #{key}=\"#{value}\""
    attrs

  text: (text) ->
    unless text?
      return ''

    text
    .replace(/&/g,"&amp;")
    .replace(/</g,"&lt;")
    .replace(/>/g,"&gt;")
    .replace(/\s/g,"&nbsp;")

resolve = (list) ->
  obj = {}
  childNodes = []
  for item in list
    unless item?
      continue
    if Array.isArray item
      for x in item
        childNodes.push x
    else if typeof item is 'object'
      obj = item
    else if typeof item is 'string'
      childNodes.push item
  [obj, childNodes]

pairElements.map (tag) ->
  htmlScope[tag] = (args...) ->
    [obj, childNodes] = resolve args
    "<#{tag}#{htmlUtil.attrs obj}>#{childNodes.join("")}</#{tag}>"

singleElements.map (tag) ->
  htmlScope[tag] = (obj={}) ->
    "<#{tag}#{htmlUtil.attrs obj}/>"

htmlScope.html = (x) -> x
htmlScope.text = htmlUtil.text

exports.html = (generator) ->
  generator.call htmlScope