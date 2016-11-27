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

    let popStatusItem = PopStatusItem(image: NSImage(named: "buttonImage")!)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        popStatusItem.windowController = storyboard.instantiateController(withIdentifier: "PopStatusItem") as? NSWindowController
        
        popStatusItem.highlight = true // Default is false
        popStatusItem.activate = true // Default is false
        
        popStatusItem.showPopover() // Show popover on startup
        
        // Force Aqua appearance, even in dark mode
        //popStatusItem.popover.appearance = NSAppearance(named: NSAppearanceNameAqua)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

