# Package

version       = "0.1.0"
author        = "jjv360"
description   = "A simple calculator app made with Nim Reactive"
license       = "MIT"
srcDir        = "src"


# For our examples only: check if we are within the main Reactive dev environment
import os
template reactiveDevEnvironment(): bool = fileExists(thisDir() / ".." / ".." / "reactive.nimble")

# Dependencies
requires "nim >= 1.6.2"

# For our examples only: Only import Reactive via git when running as a standalone project
if not reactiveDevEnvironment: 
    requires "https://github.com/jjv360/nim-reactive >= 0.1.2"

# Reactive task
task reactive, "Build the app":

    # For our examples only: if inside the dev environment, reinstall Reactive from local files
    if reactiveDevEnvironment:
        echo "Installing Reactive from local source..."
        withDir thisDir() / ".." / "..":
            exec "nimble install -y"

    # Rest of the normal task
    var params = @[gorge("nimble path reactive").strip() & "/reactive"]; var foundSeparator = false
    for param in commandLineParams():
        if foundSeparator: params.add(param)
        if param == "reactive": foundSeparator = true
    exec "nimble install -y"; exec params.quoteShellCommand