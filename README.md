# Dynamic statusbar for Framer

This module automatically adds the emulated device's statusbar & changes depending on the device you are viewing on.

## Install

<!-- <a href='https://open.framermodules.com/Dynamic Statusbar'>
    <img alt='Install with Framer Modules'
    src='https://www.framermodules.com/assets/badge@2x.png' width='160' height='40' /></a>

or -->

- Copy the `framer-statusbar.coffee` file to your prototype's `modules` folder.
- Call `{StatusBar} = require "framer-statusbar"` in your Framer prototype.
- Create a statusbar layer by writting `yourLayer = new StatusBar`

## Events
- **.style** (String) Define statusbar style (dark/light)
- **.backgroundColor** (String) Select background color. Default is transparent.
- **.device** (String) Force device statusbar (classic-iphone/iphone-x/android)
- **.height** (Read only) Get the statusbar height value

### Contact
[Twitter](https://twitter.com/revealparis)
[Instagram](https://www.instagram.com/revealparis)
[Dribbble](https://dribbble.com/revealstudio)
