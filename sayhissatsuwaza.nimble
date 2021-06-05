# Package

version       = "0.6.0"
author        = "jiro4989"
description   = "Say hissatsuwaza (special attack) on your terminal."
license       = "MIT"
srcDir        = "src"
bin           = @["sayhissatsuwaza"]
binDir        = "bin"

# Dependencies

requires "nim >= 1.4.8"
requires "cligen >= 1.5.4"

task buildjs, "Build js library":
  exec "nimble js src/sayhissatsuwaza.nim -o:public/js/lib.js"
