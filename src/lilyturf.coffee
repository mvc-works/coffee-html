
lilyturf =

  pair_elems: "head title body script
    div nav header footer section article
    p span textarea br pre code a address b backquote
    button font frame form hr i
    ul li ol table tr td th title
    canvas audio video select style".split(/\s+/)

  single_elems: "img meta input link iframe audio video".split(/\s+/)

  html_way:
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
    html: (html) -> html

  dom_way:
    attrs: (obj, elem) ->
      for key, value of obj
        if key[..1] is "on" then elem[key] = value
        else elem.setAttribute key, value
      elem
    text: (text) -> document.createTextNode text
    html: (html) ->
      div = document.createElement "div"
      div.innerHTML = html
      div

  resolve: (list) ->
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

  prepare_html: ->
    self = @html_way
    resolve = @resolve
    @pair_elems.map (tag) ->
      self[tag] = (list...) ->
        [obj, list] = resolve list
        "<#{tag}#{self.attrs obj}>#{list.join("")}</#{tag}>"
    @single_elems.map (tag) ->
      self[tag] = (obj={}) ->
        "<#{tag}#{self.attrs obj}/>"

  prepare_dom: ->
    self = @dom_way
    resolve = @resolve
    all = @pair_elems.concat @single_elems
    all.map (tag) ->
      self[tag] = (list...) ->
        [obj, list] = resolve list
        elem = document.createElement tag
        self.attrs obj, elem
        list.forEach (child) ->
          if child?
            if typeof child in ['string', "number"]
              elem.appendChild (self.text child)
            else elem.appendChild child
        elem

  html: (f) ->
    self = @html_way
    self.f = f
    self.f()

  dom: (f) ->
    self = @dom_way
    self.f = f
    self.f()

lilyturf.prepare_html()
if window?.document? then lilyturf.prepare_dom()