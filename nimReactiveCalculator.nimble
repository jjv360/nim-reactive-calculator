# Package

version       = "0.1.7"
author        = "jjv360"
description   = "A simple calculator app made with Nim Reactive"
license       = "MIT"
srcDir        = "src"

# Dependencies
requires "nim >= 1.6.2"
requires "https://github.com/jjv360/nim-reactive >= 0.1.7"
requires "https://github.com/jjv360/nim-reactive-web >= 0.1.7"
requires "https://github.com/jjv360/nim-reactive-win32 >= 0.1.7"

# Reactive task
import os, sequtils, json
task reactive, "Reactive action":

    # Your app configuration
    var reactiveParams = %* {
        "appID": "org.jjv360.reactive.calculator",
        "title": "Reactive Example - Calculator"
    }

    # Task runner, don't change this
    template reactiveExe(): string = (gorge("nimble path reactive").strip() & "/reactive_task").toExe()
    if not fileExists(reactiveExe): exec "nimble install --depsOnly -y"
    if not fileExists(reactiveExe): raiseAssert("Unable to find the Reactive binary!")
    withDir(thisDir()): exec @[reactiveExe].concat(commandLineParams()).concat(@["--reactive-params:" & $reactiveParams]).quoteShellCommand()