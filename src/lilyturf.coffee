
do ->
  
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

    html: (generator) ->
      @html_way.generator = generator
      @html_way.generator()

    dom: (generator) ->
      @dom_way.generator = generator
      @dom_way.generator()

    css_way:
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

    css: (generator) ->
      self = @css_way
      style = ""
      self.utils.generator = generator
      data = self.utils.generator()

      write_rule = (base, data) ->
        nested = {}

        for selector, declaration of data
          plain = []
          for attribute, value of declaration
            if (self.type value) is "object"
              nest_selector = "#{base} #{selector}"
              nested[nest_selector] = {} unless nested[nest_selector]?
              nested[nest_selector][attribute] = value
            else
              attribute = attribute.split("").map(self.pretty).join("")
              value = "#{value}px" if (self.type value) is "number"
              if (self.type value) is "array"
                values = value
                for value in values
                  plain.push "  #{attribute}: #{value};"
              else plain.push "  #{attribute}: #{value};"
          if plain.length > 0
            declaration = plain.join "\n"
            rule = self.template base, selector, declaration
            style += rule.trimLeft()
        if (Object.keys nested).length > 0
          write_rule base, data for base, data of nested

      write_rule "", data
      style

  lilyturf.prepare_html()
  if window?.document? then lilyturf.prepare_dom()

  if exports? then exports.lilyturf = lilyturf
  else window.lilyturf = lilyturf