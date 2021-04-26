//
//  EBWebView.swift
//  TestWebViewInterface
//
//  Created by admin on 2021/4/24.
//

import UIKit
import WebKit
import JavaScriptCore

class EBWebView: UIView {

    var _uiwebView:UIWebView!

    var _wkWebView:WKWebView!
    
    var _useWkWebView:Bool = false
    
    var _webInterface:EBWebInterface!
    
    func load(url:String) -> Void {
        
        let request = URLRequest(url: URL(string: url)!)
        
        if _useWkWebView {
            
            _wkWebView.load(request)
        }
        else {
            
            _uiwebView.loadRequest(request)
        }
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        _webInterface = EBWebInterface()
        
        _webInterface.webView = self
        
        if _useWkWebView {
            
            _wkWebView = createWKWebView(self.bounds)
        }
        else {
            
            _uiwebView = createUIWebView(self.bounds)
        }
        
        let view = _useWkWebView ? _wkWebView : _uiwebView;
        
        self.addSubview(view!)
    }
    
    func createWKWebView(_ frame:CGRect) -> WKWebView {
        
        let webConfig = WKWebViewConfiguration()
        
        let userController = WKUserContentController()
        
        userController.add(self, name: "ebWebInterface")
        
        webConfig.userContentController = userController
        
        let webview = WKWebView(frame: frame, configuration: webConfig)
        
        return webview
    }
    
    func createUIWebView(_ frame:CGRect) -> UIWebView {
        
        let webview = UIWebView(frame: frame)
        
        webview.delegate = self
        
        return webview
    }
    
    @objc func evaluateJs(_ js:String) -> Void {
        
        if _useWkWebView {
            
            _wkWebView.evaluateJavaScript(js, completionHandler: nil)
        }
        else {
            
            _uiwebView.stringByEvaluatingJavaScript(from: js)
        }
    }
}


extension EBWebView: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        guard let context = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext else {
            
            return
        }
        
        context.setObject(_webInterface, forKeyedSubscript: "ebWebInterface" as (NSCopying & NSObjectProtocol))
    }
}

extension EBWebView: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if message.name != "ebWebInterface" {
            
            return
        }
        
        guard let data = message.body as? [AnyHashable : Any] else {
            
            return
        }
        
        guard let functionId = data["functionId"] as? String else {
            
            return
        }
        
        let params = data["params"] as? [AnyHashable : Any]
        
        let callbackId = data["callbackId"] as? String
                
        _webInterface.excute(functionId, params: params, callbackId: callbackId)
    }
}
