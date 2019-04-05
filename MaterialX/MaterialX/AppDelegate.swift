//
//  AppDelegate.swift
//  MaterialX
//
//  Created by xaoxuu on 2019/4/5.
//  Copyright © 2019 xaoxuu. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        if let rootVC = NSStoryboard.init(name: NSStoryboard.Name.init("Main"), bundle: .main).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier.init("MainVC")) as? NSViewController, let win = NSApp.mainWindow {
            win.contentViewController = rootVC
            win.contentView = rootVC.view
            print(rootVC.view.frame)
            NotificationCenter.default.post(name: currentTitle, object: "\(rootVC.view.frame)")
        }
        
        
        NotificationCenter.default.addObserver(forName: NSWindow.willCloseNotification, object: nil, queue: .main) { (note) in
            NSApp.terminate(self)
        }
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

