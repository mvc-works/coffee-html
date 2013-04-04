
require "./test"

{spawn} = require "child_process"

compile = spawn "browserify", ["-dt", "coffeeify", "test.coffee", "-o", "build.js"]
compile.stdout.pipe process.stdout
compile.stderr.pipe process.stderr