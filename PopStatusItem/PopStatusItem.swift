//
//  PopStatusItem.swift
//  PopStatusItem
//
//  Created by Adam Hartford on 4/24/15.
//  Copyright (c) 2015 Adam Hartford. All rights reserved.
//

import Cocoa

open class PopStatusItem: NSObject {
    
    open var windowController: NSWindowController?
    
    open let popover = NSPopover()
    
    open var highlight = false
    open var activate = false
    
    let dummyMenu = NSMenu()
    let statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
    
    var active = false
    var popoverTransiencyMonitor: AnyObject?
    
    open var missionControlRunning: Bool {
        let info = CGWindowListCopyWindowInfo(.optionOnScreenOnly, CGWindowID(0))
        if let windows = info as? [[String: Any]] {
            let count = windows.filter { $0["kCGWindowOwnerName"] as? String == "Dock" }.count
            
            return count > 3 // TODO Better way?
        }
        return false
    }
    
    open var buttonTitle: String? {
        get {
            return statusItem.button?.title
        }
        set {
            statusItem.button?.title = newValue ?? ""
        }
    }

    public init(image: NSImage) {
        super.init()
        
        if let button = statusItem.button {
            image.isTemplate = true
            button.image = image
            button.appearsDisabled = false
            button.target = self
            button.action = #selector(PopStatusItem.togglePopover)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(NSApplicationDelegate.applicationWillResignActive(_:)), name: NSNotification.Name.NSApplicationWillResignActive, object: nil)
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            while true {
                if self?.active == true && self?.missionControlRunning == true {
                    DispatchQueue.main.async {
                        self?.hidePopover()
                    }
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open func togglePopover() {
        if active {
            hidePopover()
        } else {
            if highlight {
                let delayTime = DispatchTime.now() + Double(0) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: delayTime) { [weak self] in
                    self?.statusItem.button?.isHighlighted = true
                }
            }
            
            if activate {
                NSApp.activate(ignoringOtherApps: true)
            }
            
            showPopover()
        }
    }
    
    open func showPopover() {
        if !active {
            active = true
            statusItem.popUpMenu(dummyMenu)
            
            if let _ = windowController?.window {
                popover.contentViewController = windowController?.contentViewController
                popover.show(relativeTo: NSZeroRect, of: statusItem.button!, preferredEdge: .minY)
                popoverTransiencyMonitor = NSEvent.addGlobalMonitorForEvents(matching: [NSEventMask.leftMouseDown, NSEventMask.rightMouseDown], handler: { [weak self] event in
                    self?.hidePopover()
                }) as AnyObject?
            }
        }
    }
    
    open func hidePopover() {
        if active {
            active = false
            statusItem.button!.isHighlighted = false
            popover.close()
            if let monitor: AnyObject = popoverTransiencyMonitor {
                NSEvent.removeMonitor(monitor)
            }
        }
    }
    
    open func applicationWillResignActive(_ notification: Notification) {
        if active {
            hidePopover()
        }
    }
}
