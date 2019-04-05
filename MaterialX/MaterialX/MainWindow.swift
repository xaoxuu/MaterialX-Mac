//
//  MainWindow.swift
//  MaterialX
//
//  Created by xaoxuu on 2019/4/5.
//  Copyright © 2019 xaoxuu. All rights reserved.
//

import Cocoa

let didTapped = Notification.Name.init("didTapped")

let canGoBack = Notification.Name.init("canGoBack")
let canGoForword = Notification.Name.init("canGoForword")

let currentTitle = Notification.Name.init("currentTitle")


class MainWindow: NSWindowController {

    @IBOutlet weak var win: NSWindow!
    @IBOutlet weak var goBackItem: NSToolbarItem!
    @IBOutlet weak var goForwardItem: NSToolbarItem!
    
    @IBAction func didTappedToolbarItem(_ sender: NSToolbarItem) {
        
        NotificationCenter.default.post(name: didTapped, object: sender.tag)
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        NotificationCenter.default.addObserver(forName: currentTitle, object: nil, queue: .main) { (note) in
            if let str = note.object as? String {
                if str.count > 0 {
                    self.win.title = str
                } else {
                   self.win.title = "Material X"
                }
            }
        }
        
        NotificationCenter.default.addObserver(forName: canGoBack, object: nil, queue: .main) { (note) in
            if let can = note.object as? Bool {
                self.goBackItem.isEnabled = can
            }
        }
        
        NotificationCenter.default.addObserver(forName: canGoForword, object: nil, queue: .main) { (note) in
            if let can = note.object as? Bool {
                self.goForwardItem.isEnabled = can
            }
        }
    }

}
