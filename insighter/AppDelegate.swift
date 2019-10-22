import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!

    @objc private func updateDesktopsInfo() {
        let spacesState = getSpacesStateThroughYabai()
        statusBarItem.button?.title = "\(String(spacesState.current))|\(String(spacesState.count))"
    }

    func applicationDidFinishLaunching(_: Notification) {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        addMenu()

        NSWorkspace.shared.notificationCenter.addObserver(
            self,
            selector: #selector(updateDesktopsInfo),
            name: NSWorkspace.activeSpaceDidChangeNotification,
            object: nil
        )

        updateDesktopsInfo()
    }
    
    func addMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Quit Insight", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusBarItem.menu = menu
    }
}
