//
//  AppDelegate.swift
//  insighter
//
//  Created by Bruno Roque on 18.10.19.
//  Copyright © 2019 brunoroque06. All rights reserved.
//

import Cocoa
import SwiftUI

struct Spaces: Codable {
    let spansDisplays: Bool
    
    init(spansDisplay: Bool) {
        self.spansDisplays = spansDisplay
    }
}

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
    
    func getPlist(withName name: String) -> [String]?
    {
        if  let path = Bundle.main.path(forResource: name, ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path)
        {
            return (try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil)) as? [String]
        }

        return nil
    }
    
    @objc private func updateDesktopsInfo() {
        increment = increment + 1
//        let current = getCurrentDesktop()
        let total = getDesktopTotalCount()
        statusBarItem.button?.title = "\(String(increment))|\(String(total))"
        
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "com.apple.spaces", ofType: "plist", inDirectory: "~/Library/Preferences/") {
           nsDictionary = NSDictionary(contentsOfFile: path)
        }
        let value = nsDictionary?.value(forKey: "spans-displays")
        let file = getPlist(withName: "~/Library/Preferences/com.apple.spaces")
        let anotherTry = Bundle.main.path(forResource: "com.apple.spaces", ofType: "plist", inDirectory: "/Library/Preferences/")
        let fullPath = ("~/Library/Preferences/com.apple.spaces.plist" as NSString).expandingTildeInPath
        let fm = FileManager.default
//        let applicationSupportFolderURL = try! FileManager.default.URLForDirectory(.preferencePanesDirectory, inDomain: .LocalDomainMask, appropriateForURL: nil, create: false)
//        let jsonDataURL = applicationSupportFolderURL.URLByAppendingPathComponent("AppFolder/data.json")
        let caminho = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Library").appendingPathComponent("Preferences").appendingPathComponent("com.apple.spaces").appendingPathExtension("plist")
        NSLog(FileManager.default.homeDirectoryForCurrentUser.path)
        NSLog(caminho.path)
        caminho.path
        let fileManager = FileManager.default
        let resultado = fileManager.fileExists(atPath: caminho.path)
//        FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Library").appendingPathComponent("Preferences").appendingPathComponent("com.apple.spaces").appendingPathExtension("plist")
        let fds = URL(fileURLWithPath: "/Users/brunoroque/Library/Preferences/com.apple.spaces.plist")
        let agora = fileManager.fileExists(atPath: fds.path)
        let merda = NSDictionary(contentsOfFile: fullPath)
//        let content = NSString(contentsOf: fds)
        var string: NSString?
        let plistDecoder = PropertyListDecoder()
        let spaces: Spaces?
        do {
            let data = try Data.init(contentsOf: fds)
            spaces = try plistDecoder.decode(Spaces.self, from: data)
            string = try NSString(contentsOf: fds, encoding: String.Encoding.utf8.rawValue)
        } catch {
            print("Unexpected error: \(error).")
        }
//        let string = try? NSString(contentsOf: fds, encoding: String.Encoding.utf8.rawValue)
        let mapa = NSDictionary(contentsOf: fds)
        let something = 1
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
        
        updateDesktopsInfo()
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
