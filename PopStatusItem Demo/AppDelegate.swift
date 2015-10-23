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

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        popStatusItem.windowController = storyboard.instantiateControllerWithIdentifier("PopStatusItem") as? NSWindowController
        
        popStatusItem.highlight = true // Default is false
        popStatusItem.activate = true // Default is false
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

}

