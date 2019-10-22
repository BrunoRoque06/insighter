import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!

    @objc private func updateDesktopsInfo() {
        let spacesState = readSpacesState(url: spacesPlist)
        statusBarItem.button?.title = "\(String(spacesState.current))|\(String(spacesState.count))"
    }

    func applicationDidFinishLaunching(_: Notification) {
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
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

    func applicationWillTerminate(_: Notification) {
        // Insert code here to tear down your application
    }
}
