# Package

version       = "0.1.5"
author        = "jjv360"
description   = "A simple calculator app made with Nim Reactive"
license       = "MIT"
srcDir        = "src"

# Dependencies
requires "nim >= 1.6.2"
requires "https://github.com/jjv360/nim-reactive >= 0.1.5"
requires "https://github.com/jjv360/nim-reactive-web >= 0.1.5"

# Reactive task
import os, sequtils
task reactive, "Reactive action":
    template reactiveExe(): string = (gorge("nimble path reactive").strip() & "/reactive_task").toExe()
    if not fileExists(reactiveExe): exec "nimble install --depsOnly -y"
    if not fileExists(reactiveExe): raiseAssert("Unable to find the Reactive binary!")
    exec @[reactiveExe, "--reactive-project-root:" & thisDir()].concat(commandLineParams()).quoteShellCommand()