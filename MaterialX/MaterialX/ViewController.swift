//
//  ViewController.swift
//  MaterialX
//
//  Created by xaoxuu on 2019/4/5.
//  Copyright © 2019 xaoxuu. All rights reserved.
//

import Cocoa
import WebKit

let docsURL = "https://xaoxuu.com/wiki/material-x/"
let codeURL = "https://github.com/xaoxuu/hexo-theme-material-x/"
let helpURL = "https://xaoxuu.com/wiki/material-x/help/"
let hexoURL = "https://hexo.io"

class ViewController: NSViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.post(name: currentTitle, object: "Welcome!")
        
        setupFrame()
        
        webView.navigationDelegate = self
        
        
        loadURL(urlStr: docsURL)
        
        NotificationCenter.default.addObserver(forName: didTapped, object: nil, queue: .main) { (note) in
            if let tag = note.object as? Int {
                switch tag {
                case 1:
                    self.loadURL(urlStr: codeURL)
                case 2:
                    self.webView.goBack()
                case 3:
                    self.webView.goForward()
                case 4:
                    self.loadURL(urlStr: "https://xaoxuu.com")
                case 9:
                    self.loadURL(urlStr: helpURL)
                case 99:
                    self.loadURL(urlStr: hexoURL)
                default:
                    self.loadURL(urlStr: docsURL)
                    break
                }
            }
            
        }
        
    }
    @IBAction func didTappedHomeBtn(_ sender: NSButton) {
        loadURL(urlStr: docsURL)
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func setupFrame(){
        if let fr = NSScreen.main?.visibleFrame {
            debugPrint(fr)
            var width = 0.6*fr.width
            var height = 0.6*fr.height
            if width > 1500 {
                width = 1500
                height = 900
            } else if width < 1024 {
                width = 1024
                height = 640
            }
            view.frame.size.width = width
            view.frame.size.height = height
            debugPrint(view.frame)
        }
    }
    
    func loadURL(urlStr: String){
        if let url = URL.init(string: urlStr) {
            let req = URLRequest.init(url: url)
            if let cur = webView.url {
                if cur == url {
                    debugPrint("reload")
                    webView.reloadFromOrigin()
                    return
                }
            }
            webView.load(req)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let frameInfo = navigationAction.targetFrame
        let isMainFr = frameInfo?.isMainFrame
        if let isMain = isMainFr {
            if isMain == true {
                decisionHandler(.allow)
                return
            }
        }
        webView.load(navigationAction.request)
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if let url = webView.url {
            NotificationCenter.default.post(name: currentTitle, object: url.description)
        }
        NotificationCenter.default.post(name: canGoBack, object: webView.canGoBack)
        NotificationCenter.default.post(name: canGoForword, object: webView.canGoForward)
    }
    
    
}

