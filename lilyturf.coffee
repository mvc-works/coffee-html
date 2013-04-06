
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

css_tools =
  template: (base, selector, declaration) ->
    "#{base} #{selector}{\n#{declaration}\n}\n"
  utils:
    hsl: (h, s, l) -> "hsl(#{h}, #{s}%, #{l}%)"
    hsla: (h, s, l, a) -> "hsl(#{h}, #{s}%, #{l}%, #{a})"
  type: (value) ->
    match = Object::toString.call(value).match(/\s\w+/)
    string = match[0][1..]
    string.toLowerCase()
  pretty: (char) ->
    if char.match(/^[A-Z]$/)? then "-" + char.toLowerCase()
    else char

css = (generator) ->
  style = ""
  css_tools.utils.generator = generator
  data = css_tools.utils.generator()

  write_rule = (base, data) ->
    nested = {}

    for selector, declaration of data
      plain = []
      for attribute, value of declaration
        if (css_tools.type value) is "object"
          nest_selector = "#{base} #{selector}"
          nested[nest_selector] = {} unless nested[nest_selector]?
          nested[nest_selector][attribute] = value
        else
          attribute = attribute.split("").map(css_tools.pretty).join("")
          value = "#{value}px" if (css_tools.type value) is "number"
          if (css_tools.type value) is "array"
            values = value
            for value in values
              plain.push "  #{attribute}: #{value};"
          else plain.push "  #{attribute}: #{value};"
      if plain.length > 0
        declaration = plain.join "\n"
        rule = css_tools.template base, selector, declaration
        style += rule.trimLeft()
    if (Object.keys nested).length > 0
      write_rule base, data for base, data of nested

  write_rule "", data
  style

exports.html = (generator) ->
  generator.call html_scope
exports.css = (data) -> css data