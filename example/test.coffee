
{html, css} = require "../lilyturf.coffee"

# page = html ->
#   @div class: "new",
#     @span id: "none", "x"

style = css ->
  "html":
    "css": "red"
    head:
      fontSize: 10

console.log "load", style