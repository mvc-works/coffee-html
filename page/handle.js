// Generated by CoffeeScript 1.4.0
var delay, disqus_js, log, pop, q;

log = function() {
  var _ref;
  return typeof console !== "undefined" && console !== null ? (_ref = console.log) != null ? typeof _ref.apply === "function" ? _ref.apply(console, arguments) : void 0 : void 0 : void 0;
};

delay = function(f, t) {
  return setTimeout(t, f);
};

q = function(query) {
  return document.querySelector(query);
};

disqus_js = "/* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */\n      var disqus_shortname = 'jiyinyiyong';\n      // required: replace example with your forum shortname\n\n      /* * * DON'T EDIT BELOW THIS LINE * * */\n      (function() {\n          var dsq = document.createElement('script');\n          dsq.type = 'text/javascript';\n          dsq.async = true;\n          dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';\n          if (document.getElementsByTagName('head')[0]) {\n            document.getElementsByTagName('body')[0].appendChild(dsq);\n          }\n      })();";

pop = function() {
  return alert("alert called by event!");
};

window.onload = function() {
  var req, req2, req3, req4;
  document.body.insertAdjacentHTML("beforeend", lilyturf.html(function() {
    return this.div({
      "class": "main-title"
    }, this.text("Lilyturf is a template engine for CoffeeScript"));
  }));
  document.body.insertAdjacentHTML("beforeend", lilyturf.html(function() {
    return this.div({
      "class": "method"
    }, this.p({
      "class": "bold"
    }, this.text("This is generated in HTML way")), this.p("This is my way generating HTML in the runtime of CoffeeScript."), this.p({}, "JavaScript is a language born to deal with HTML, and it should be."), this.p({}, this.text("So, let's generate HTML with CoffeeScript.")));
  }));
  document.body.appendChild(lilyturf.dom(function() {
    return this.div({
      "class": "method"
    }, this.p({
      "class": "bold"
    }, this.text("This is generated in DOM way")), this.p({
      id: "click",
      onclick: pop
    }, this.text("The DOM version allow click events, please click!")), this.p({}, this.text("Read the following files for more details.")), this.a({
      href: "https://github.com/jiyinyiyong/lilyturf"
    }, this.text("And here's the link to it's repo.")));
  }));
  document.body.appendChild(lilyturf.dom(function() {
    return this.div({
      id: "code"
    });
  }));
  req = new XMLHttpRequest;
  req.open("get", "../src/lilyturf.coffee");
  req.send();
  req.onload = function(res) {
    var block;
    block = lilyturf.html(function() {
      return this.div({}, this.div({
        "class": "intro"
      }, this.text("This is the code implementing Lilyturf:")), this.pre({
        id: "source"
      }, this.code({
        "class": "coffeescript"
      }, this.html(res.target.response))));
    });
    (q("#code")).insertAdjacentHTML("beforeend", block);
    return hljs.highlightBlock((q("#code")).querySelector("pre"));
  };
  req2 = new XMLHttpRequest;
  req2.open("get", "../src/handle.coffee");
  req2.send();
  req2.onload = function(res) {
    var block;
    block = lilyturf.dom(function() {
      return this.div({}, this.div({
        "class": "intro:"
      }, this.text("And my code for generating this page:")), this.pre({}, this.code({
        "class": "coffeescript"
      }, this.text(res.target.response))));
    });
    (q("#code")).appendChild(block);
    return hljs.highlightBlock(block.querySelector("pre"));
  };
  req3 = new XMLHttpRequest;
  req3.open("get", "../src/index.jade");
  req3.send();
  req3.onload = function(res) {
    var block;
    block = lilyturf.dom(function() {
      return this.div({}, this.div({
        "class": "intro:"
      }, this.text("This is the source of HTML page in Jade:")), this.pre({}, this.code({
        "class": "jade"
      }, this.text(res.target.response))));
    });
    (q("#code")).appendChild(block);
    return hljs.highlightBlock(block.querySelector("pre"));
  };
  req4 = new XMLHttpRequest;
  req4.open("get", "../readme.md");
  req4.send();
  req4.onload = function(res) {
    var block, one, _i, _len, _ref, _results;
    block = lilyturf.dom(function() {
      return this.div({}, this.div({
        "class": "intro"
      }, this.text("The readme file:")), this.pre({
        id: "readme"
      }, this.html(marked(res.target.response))));
    });
    (q("#code")).appendChild(block);
    _ref = block.querySelectorAll("pre pre");
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      one = _ref[_i];
      one.firstChild.className = "coffeescript";
      _results.push(hljs.highlightBlock(one));
    }
    return _results;
  };
  return document.body.appendChild(lilyturf.dom(function() {
    return this.div({
      id: "disqus_thread"
    }, this.script({
      type: "text/javascript"
    }, this.text(disqus_js)), this.a({
      href: "http://disqus.com",
      "class": "dsq-brlink"
    }, this.text("comments powered by"), this.span({
      "class": "logo-disqus"
    }, this.text("Disqus"))));
  }));
};
