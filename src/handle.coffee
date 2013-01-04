
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

window.onload = ->
  converter = new Markdown.Converter()

  document.body.insertAdjacentHTML "beforeend", lilyturf.html ->
    @div class: "main-title",
      @text "Lilyturf is a template engine for CoffeeScript"

  document.body.insertAdjacentHTML "beforeend", lilyturf.html ->
    @div class: "method",
      @p class: "bold", (@text "This is generated in HTML way")
      @p {}, (@text "This is my way generating HTML in the runtime of CoffeeScript.")
      @p {}, (@text "JavaScript is a language born to deal with HTML, and it should be.")
      @p {}, (@text "So, just integrate HTML's syntax into CoffeeScript.")

  document.body.appendChild lilyturf.dom ->
    @div class: "method",
      @p class: "bold", (@text "This is generated in DOM way")
      @p id: "click", onclick: pop, (@text "The DOM version allow click events, please click!")
      @p {}, (@text "Read the files below if you cant more details.")
      @a href: "https://github.com/jiyinyiyong/lilyturf",
        @text "And here's the link to it's repo."

  document.body.appendChild lilyturf.dom ->
    @div id: "code"

  req = new XMLHttpRequest
  req.open "get", "../src/lilyturf.coffee"
  req.send()
  req.onload = (res) ->
    block = lilyturf.html ->
      @div {},
        @div class: "intro",
          @text "This is all my code for implementing Lilyturf:"
        @pre id: "source",
          @code class: "coffeescript",
            @html res.target.response
    (q "#code").insertAdjacentHTML "beforeend", block
    hljs.highlightBlock (q "#code").querySelector("pre")

  req2 = new XMLHttpRequest
  req2.open "get", "../src/handle.coffee"
  req2.send()
  req2.onload = (res) ->
    block = lilyturf.dom ->
      @div {},
        @div class: "intro:",
          @text "And my code for generating this page:"
        @pre {},
          @code class: "coffeescript",
            @text res.target.response
    (q "#code").appendChild block
    hljs.highlightBlock block.querySelector("pre")

  req3 = new XMLHttpRequest
  req3.open "get", "../src/index.jade"
  req3.send()
  req3.onload = (res) ->
    block = lilyturf.dom ->
      @div {},
        @div class: "intro:",
          @text "This is the source of HTML page in Jade:"
        @pre {},
          @code class: "jade",
            @text res.target.response
    (q "#code").appendChild block
    hljs.highlightBlock block.querySelector("pre")

  req4 = new XMLHttpRequest
  req4.open "get", "../readme.md"
  req4.send()
  req4.onload = (res) ->
    block = lilyturf.dom ->
      @div {},
        @div class: "intro",
          @text "The readme file:"
        @pre id: "readme",
          @html converter.makeHtml res.target.response
    (q "#code").appendChild block

  document.body.appendChild lilyturf.dom ->
    @div id: "disqus_thread",
      @script type: "text/javascript",
        @text disqus_js
      @a href: "http://disqus.com", class: "dsq-brlink",
        @text "comments powered by"
        @span class: "logo-disqus",
          @text "Disqus"