# PopStatusItem
Shows an NSPopover from the status bar. Works with Mission Control. Supports dark mode on Yosemite.

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
func applicationDidFinishLaunching(aNotification: NSNotification) {
    let popStatusItem = PopStatusItem.new()
    let storyboard = NSStoryboard(name: "Main", bundle: nil)
    popStatusItem.windowController = storyboard!.instantiateControllerWithIdentifier("PopStatusItem") as? NSWindowController
    popStatusItem.image = NSImage(named: "statusImage")
    popStatusItem.alternateImage = NSImage(named: "alternateImage")
}
```

Usage, or to recreate the demo application:

1. Add LSUIElement=YES to Info.plist.
2. Uncheck "Is Initial Controller" in Main.storyboard window controller.

### License
PopDatePicker is released under the MIT license. See LICENSE for details.
