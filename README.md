# PopStatusItem
Shows an NSPopover from the status bar. Works with Mission Control and Spaces. Supports dark mode.

![Screenshot](https://db.tt/3onYeACR)

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
```

## Options
```swift
popStatusItem.highlight = true // Highlights status bar icon. Default is false.
popStatusItem.activate = true // Makes popover window active. Default is false.
        
popStatusItem.togglePopover()
popStatusItem.showPopover()
popStatusItem.hidePopover()
```

Usage, or to recreate the demo application:

1. Add LSUIElement=YES to Info.plist.
2. Uncheck "Is Initial Controller" in Main.storyboard window controller.

### License
PopDatePicker is released under the MIT license. See LICENSE for details.
