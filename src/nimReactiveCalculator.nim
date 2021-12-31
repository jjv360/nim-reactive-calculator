
import reactive
import classes
import strutils

# Setup main window
component MainWindow of Window:

    # Register as main entry point
    registerAs "main"

    ## Input
    var input = ""

    ## Mode
    var inputMode = false

    # Calculator output
    var memory: float = 0

    # Current operation
    var nextOperation = "+"

    # Render UI
    render:

        # Buttons
        Button(layout: AbsoluteLayout(x: "0%",  y: "20%", width: "20%", height: "20%"), title: "1", onClick: proc()=this.addInput("1"), backgroundColor: "purple")
        Button(layout: AbsoluteLayout(x: "20%", y: "20%", width: "20%", height: "20%"), title: "2", onClick: proc()=this.addInput("2"))
        Button(layout: AbsoluteLayout(x: "40%", y: "20%", width: "20%", height: "20%"), title: "3", onClick: proc()=this.addInput("3"))
        Button(layout: AbsoluteLayout(x: "60%", y: "20%", width: "20%", height: "20%"), title: "/", onClick: proc()=this.setNextOperation("/"))
        Button(layout: AbsoluteLayout(x: "80%", y: "20%", width: "20%", height: "20%"), title: "Clear", onClick: proc()=this.memory=0;this.input="";this.nextOperation="+";this.updateUi())
        Button(layout: AbsoluteLayout(x: "0%",  y: "40%", width: "20%", height: "20%"), title: "4", onClick: proc()=this.addInput("4"))
        Button(layout: AbsoluteLayout(x: "20%", y: "40%", width: "20%", height: "20%"), title: "5", onClick: proc()=this.addInput("5"))
        Button(layout: AbsoluteLayout(x: "40%", y: "40%", width: "20%", height: "20%"), title: "6", onClick: proc()=this.addInput("6"))
        Button(layout: AbsoluteLayout(x: "60%", y: "40%", width: "20%", height: "20%"), title: "*", onClick: proc()=this.setNextOperation("*"))
        Button(layout: AbsoluteLayout(x: "0%",  y: "60%", width: "20%", height: "20%"), title: "7", onClick: proc()=this.addInput("7"))
        Button(layout: AbsoluteLayout(x: "20%", y: "60%", width: "20%", height: "20%"), title: "8", onClick: proc()=this.addInput("8"))
        Button(layout: AbsoluteLayout(x: "40%", y: "60%", width: "20%", height: "20%"), title: "9", onClick: proc()=this.addInput("9"))
        Button(layout: AbsoluteLayout(x: "60%", y: "60%", width: "20%", height: "20%"), title: "-", onClick: proc()=this.setNextOperation("-"))
        Button(layout: AbsoluteLayout(x: "0%",  y: "80%", width: "20%", height: "20%"), title: "=", onClick: proc()=this.setNextOperation("="))
        Button(layout: AbsoluteLayout(x: "20%", y: "80%", width: "20%", height: "20%"), title: "0", onClick: proc()=this.addInput("0"))
        Button(layout: AbsoluteLayout(x: "40%", y: "80%", width: "20%", height: "20%"), title: ".", onClick: proc()=this.addInput("."))
        Button(layout= AbsoluteLayout(x: "60%", y: "80%", width: "20%", height: "20%"), title= "+", onClick= proc()=this.setNextOperation("+"))
        # Button(title="Clear", onClick=proc()=this.memory=0;this.input="";this.nextOperation="+";this.updateUi())

        # Output screen
        Label(layout: AbsoluteLayout(x: "0%", y: "0%", width: "100%", height: "20%"), textColor: "green", text: if this.inputMode: this.input else: $this.memory)


    # Add a number input
    method addInput(str: string) =

        # Switch to input mode
        this.inputMode = true

        # Special case: If adding a decimal and the input already has a decimal, ignore this
        if str == "." and str in this.input:
            return

        # Update input
        this.input &= str
        this.updateUi()


    # Set the next operation
    method setNextOperation(op: string) =

        # Perform the last pending operation
        if this.nextOperation == "+":
            this.memory += parseFloat(this.input)
        elif this.nextOperation == "*":
            this.memory *= parseFloat(this.input)
        elif this.nextOperation == "-":
            this.memory -= parseFloat(this.input)
        elif this.nextOperation == "/":
            this.memory /= parseFloat(this.input)
        elif this.nextOperation == "=":
            discard#this.memory = parseFloat(this.input)

        # Reset input
        this.input = ""
        this.inputMode = false
        this.updateUi()

        # Store next operation
        this.nextOperation = op



# Start the app
startReactiveApp:

    echo "Calculator starting!"
    # alert("Hello world! The calculator app is starting now.", title="App starting!", icon=information)