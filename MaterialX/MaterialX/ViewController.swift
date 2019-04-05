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

class ViewController: NSViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupFrame()
        
        webView.navigationDelegate = self
        
        
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
            view.frame.size.width = 0.7*fr.width
            view.frame.size.height = 0.7*fr.height
            // 最小值
            view.frame.size.width = max(view.frame.size.width, 1280)
            view.frame.size.height = max(view.frame.size.height, 768)
            // 最大值
            view.frame.size.width = min(view.frame.size.width, 1500)
            view.frame.size.height = min(view.frame.size.height, 900)
            debugPrint(view.frame)
        }
    }
    
    func loadURL(urlStr: String){
        if let url = URL.init(string: urlStr) {
            let req = URLRequest.init(url: url)
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
    
}

