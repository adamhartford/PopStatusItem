//
//  PopStatusItem.swift
//  PopStatusItem
//
//  Created by Adam Hartford on 4/24/15.
//  Copyright (c) 2015 Adam Hartford. All rights reserved.
//

import Cocoa

public class PopStatusItem: NSImageView {
    
    struct Constants {
        static let kAppleInterfaceStyle = "AppleInterfaceStyle"
        static let kAppleInterfaceStyleDark = "Dark"
        static let kAppleInterfaceThemeChangedNotification = "AppleInterfaceThemeChangedNotification"
    }
    
    public var windowController: NSWindowController?
    
    public override var image: NSImage? {
        didSet {
            image?.setTemplate(isDarkMode)
        }
    }
    
    public var alternateImage: NSImage? {
        didSet {
            alternateImage?.setTemplate(isDarkMode)
        }
    }
    
    public let popover = NSPopover()
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    let dummyMenu = NSMenu()
    
    var myWindow: NSWindow!
    var active = false
    var popoverTransiencyMonitor: AnyObject?
    var interfaceThemeObserver: AnyObject?
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    init() {
        let thickness = NSStatusBar.systemStatusBar().thickness
        let frame = CGRectMake(0, 0, thickness, thickness)
        
        super.init(frame: frame)
        
        statusItem.view = self
        
        let rect = statusItem.view!.window!.frame
        myWindow = NSWindow(contentRect: rect, styleMask: NSBorderlessWindowMask, backing: .Buffered, defer: false)
        myWindow.opaque = false
        myWindow.backgroundColor = .clearColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: NSApplicationWillResignActiveNotification, object: nil)
        
        interfaceThemeObserver = NSDistributedNotificationCenter.defaultCenter().addObserverForName(Constants.kAppleInterfaceThemeChangedNotification, object: nil, queue: NSOperationQueue.mainQueue()) { [weak self] (notification) in
            if let isTemplate = self?.isDarkMode {
                self?.image?.setTemplate(isTemplate)
                self?.alternateImage?.setTemplate(isTemplate)
                self?.setNeedsDisplay()
            }
        }
    }
    
    deinit {
        if let observer: AnyObject = interfaceThemeObserver {
            NSDistributedNotificationCenter.defaultCenter().removeObserver(observer)
        }
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    public override func drawRect(dirtyRect: NSRect) {
        let color: NSColor = active ? .selectedMenuItemColor() : .clearColor()
        color.setFill()
        NSRectFill(dirtyRect)
        super.drawRect(dirtyRect)
    }
    
    public override func mouseDown(theEvent: NSEvent) {
        if !active {
            showPopover()
        } else {
            hidePopover()
        }
        setNeedsDisplay()
    }
    
    func showPopover() {
        NSApp.activateIgnoringOtherApps(true)
        myWindow.makeKeyAndOrderFront(nil)
        
        active = true
        toggleImage()
        statusItem.popUpStatusItemMenu(dummyMenu)
        
        if let window = windowController?.window {
            popover.contentViewController = windowController?.contentViewController
            
            let frame = myWindow.contentView.frame!
            let rect = NSMakeRect(frame.origin.x, frame.origin.y + frame.size.height - 1, frame.size.width, frame.size.height)
            popover.showRelativeToRect(rect, ofView: myWindow.contentView as! NSView, preferredEdge: NSMaxYEdge)
            
            popoverTransiencyMonitor = NSEvent.addGlobalMonitorForEventsMatchingMask(NSEventMask.LeftMouseDownMask|NSEventMask.RightMouseDownMask, handler: { [weak self] event in
                self?.hidePopover()
            })
        }
    }
    
    func hidePopover() {
        active = false
        self.toggleImage()
        popover.close()
        if let monitor: AnyObject = popoverTransiencyMonitor {
            NSEvent.removeMonitor(monitor)
        }
    }
    
    func toggleImage() {
        let img = image
        image = alternateImage
        alternateImage = img
    }
    
    var isDarkMode: Bool {
        if let style = NSUserDefaults.standardUserDefaults().objectForKey(Constants.kAppleInterfaceStyle) as? String {
            return style == Constants.kAppleInterfaceStyleDark
        }
        return false
    }
    
    public func applicationWillResignActive(notification: NSNotification) {
        if active {
            hidePopover()
        }
    }
    
}
