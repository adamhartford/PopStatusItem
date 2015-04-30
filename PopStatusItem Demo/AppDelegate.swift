//
//  AppDelegate.swift
//  PopStatusItem Demo
//
//  Created by Adam Hartford on 4/22/15.
//  Copyright (c) 2015 Adam Hartford. All rights reserved.
//

import Cocoa
import PopStatusItem

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        let popStatusItem = PopStatusItem.new()
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        popStatusItem.windowController = storyboard!.instantiateControllerWithIdentifier("PopStatusItem") as? NSWindowController
        popStatusItem.image = NSImage(named: "statusImage")
        popStatusItem.alternateImage = NSImage(named: "alternateImage")
        
        // This corresponds to LSUIElement=1 in the Info.plist
        //NSApp.setActivationPolicy(.Accessory)
        
        // If you're not using NSTextFields...
        //NSApp.setActivationPolicy(.Prohibited)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

