# PopStatusItem
Shows an NSPopover from the status bar. Works with Mission Control and Spaces. Supports dark mode.

![Screenshot](https://camo.githubusercontent.com/812fd5bf4fce9d0a8507d502b47c6185ee41a638/68747470733a2f2f7261772e6769746875622e636f6d2f6164616d68617274666f72642f4153485374617475734974656d506f706f7665722f6d61737465722f73637265656e73686f742e706e67)

## Installation
[CocoaPods](https://cocoapods.org):
``` ruby
platform :osx, '10.10'
use_frameworks!

pod 'PopStatusItem'
```

[Carthage](https://github.com/Carthage/Carthage):
```
github 'adamhartford/PopStatusItem'
```

## Usage
```swift
let popStatusItem = PopStatusItem(image: NSImage(named: "buttonImage")!)

func applicationDidFinishLaunching(aNotification: NSNotification) {
    let storyboard = NSStoryboard(name: "Main", bundle: nil)
    popStatusItem.windowController = storyboard.instantiateControllerWithIdentifier("PopStatusItem") as? NSWindowController
}

// Manual actions
popStatusItem.togglePopover()
popStatusItem.showPopover()
popStatusItem.hidePopover()
```

## Options
```swift
popStatusItem.highlight = true // Highlights status bar icon. Default is false.
popStatusItem.activate = true // Makes popover window active. Default is false.
```

Usage, or to recreate the demo application:

1. Add `LSUIElement` = `YES` to Info.plist.
2. Uncheck "Is Initial Controller" in Main.storyboard window controller.

### License
PopDatePicker is released under the MIT license. See LICENSE for details.
