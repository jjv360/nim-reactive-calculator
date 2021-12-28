# Package

version       = "0.1.0"
author        = "jjv360"
description   = "A simple calculator app made with Nim Reactive"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.2"
requires "https://github.com/jjv360/nim-reactive >= 0.1.2"

# Reactive task
import os
task reactive, "Build the app":
    var params = @[gorge("nimble path reactive").strip() & "/reactive"]; var foundSeparator = false
    for param in commandLineParams():
        if foundSeparator: params.add(param)
        if param == "reactive": foundSeparator = true
    exec "nimble install -y"; exec params.quoteShellCommand