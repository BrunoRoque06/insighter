//
//  AppDelegate.swift
//  insighter
//
//  Created by Bruno Roque on 18.10.19.
//  Copyright © 2019 brunoroque06. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

//    var window: NSWindow!
    var statusBarItem: NSStatusItem!
    var increment: Int = 1
//    let conn = _CGSDefaultConnection()
    
    func getCurrentDesktop() -> Int {
        return 1;
    }
    
    func getDesktopTotalCount() -> Int {
        return 4;
    }
    
    @objc private func updateDesktopsInfo(_ notification: Notification) {
        increment = increment + 1
//        let current = getCurrentDesktop()
        let total = getDesktopTotalCount()
        statusBarItem.button?.title = "\(String(increment))|\(String(total))"
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
//        let contentView = ContentView()

        // Create the window and set the content view. 
//        window = NSWindow(
//            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
//            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
//            backing: .buffered, defer: false)
//        window.center()
//        window.setFrameAutosaveName("Main Window")
//        window.contentView = NSHostingView(rootView: contentView)
//        window.makeKeyAndOrderFront(nil)
        
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        let value = updateActiveSpaceNumber()
        statusBarItem.button?.title = String(value)
        let statusBarMenu = NSMenu(title: "Cap Status Bar Menu")
        statusBarItem.menu = statusBarMenu
        
        NSWorkspace.shared.notificationCenter.addObserver(
            self,
            selector: #selector(updateDesktopsInfo),
            name: NSWorkspace.activeSpaceDidChangeNotification,
            object: nil
           )
    }
        
    func updateActiveSpaceNumber() -> Int {
        return 1
//        let info = CGSCopyManagedDisplaySpaces(conn) as! [NSDictionary]
//        let displayInfo = info[0]
//        let activeSpaceID = (displayInfo["Current Space"]! as! NSDictionary)["ManagedSpaceID"] as! Int
//        let spaces = displayInfo["Spaces"] as! NSArray
//        return activeSpaceID
//        for (index, space) in spaces.enumerated() {
//            let spaceID = (space as! NSDictionary)["ManagedSpaceID"] as! Int
//            let spaceNumber = index + 1
//            if spaceID == activeSpaceID {
//                statusBarItem.button?.title = String("\(spaceNumber)")
//                return
//            }
//        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
