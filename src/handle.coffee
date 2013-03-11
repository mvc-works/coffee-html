
log = -> console?.log?.apply? console, arguments
delay = (f, t) -> setTimeout t, f
q = (query) -> document.querySelector query

disqus_js = """
/* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
var disqus_shortname = 'jiyinyiyong';
// required: replace example with your forum shortname

/* * * DON'T EDIT BELOW THIS LINE * * */
(function() {
    var dsq = document.createElement('script');
    dsq.type = 'text/javascript';
    dsq.async = true;
    dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
    if (document.getElementsByTagName('head')[0]) {
      document.getElementsByTagName('body')[0].appendChild(dsq);
    }
})();
"""

pop = -> alert "alert called by event!"
get = (path, call) ->
  req = new XMLHttpRequest
  req.open "get", path
  req.onload = call
  req.send()

window.onload2 = ->

  document.body.insertAdjacentHTML "beforeend", lilyturf.html ->
    @div class: "main-title",
      "Lilyturf is a template engine for CoffeeScript"

  document.body.insertAdjacentHTML "beforeend", lilyturf.html ->
    @div class: "method",
      @p class: "bold", (@text "This is generated in HTML way")
      # three ways below are all OK, I recommand the last one though..
      @p "This is my way generating HTML in the runtime of CoffeeScript."
      @p {}, "JavaScript is a language born to deal with HTML, and it should be."
      @p {}, (@text "So, let's generate HTML with CoffeeScript.")

  document.body.appendChild lilyturf.dom ->
    @div class: "method",
      @p class: "bold", (@text "This is generated in DOM way")
      @p id: "click", onclick: pop,
        @text "The DOM version allow click events, please click!"
      @p (@text "Read the following files for more details.")
      @a href: "https://github.com/jiyinyiyong/lilyturf",
        "And here's the link to it's repo."

  document.body.appendChild lilyturf.dom ->
    @div id: "code"

  get "../src/lilyturf.coffee", (res) ->
    (q "#code").insertAdjacentHTML "beforeend", lilyturf.html ->
      @div {},
        @div class: "intro",
          @text "This is the code implementing Lilyturf:"
        @pre id: "source",
          @code class: "coffeescript",
            @html res.target.response

  get "../src/handle.coffee", (res) ->
    (q "#code").appendChild lilyturf.dom ->
      @div {},
        @div class: "intro:",
          @text "And my code for generating this page:"
        @pre {},
          @code class: "coffeescript",
            @text res.target.response

  get "../src/index.jade", (res) ->
    (q "#code").appendChild lilyturf.dom ->
      @div {},
        @div class: "intro:", "This is the source of HTML page in Jade:"
        @pre {},
          @code class: "jade",
            @text res.target.response

  get "../readme.md", (res) ->
    (q "#code").appendChild lilyturf.dom ->
      @div {},
        @div class: "intro",
          @text "The readme file:"
        @pre {id: "readme"}, res.target.response

  document.body.appendChild lilyturf.dom ->
    @div id: "disqus_thread",
      @script type: "text/javascript", disqus_js
      @a href: "http://disqus.com", class: "dsq-brlink",
        @text "comments powered by"
        @span class: "logo-disqus", "Disqus"

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

window.onload = ->

    log "%%%%%%%%%%%%% test css %%%%%%%%%%%%"

    log lilyturf.css ->
      selector:
        attribute: "value"
        nest:
          nest_attribute: "nest_value"
          color: @hsl 1, 2, 3