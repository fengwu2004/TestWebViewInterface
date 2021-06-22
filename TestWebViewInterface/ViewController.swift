//
//  ViewController.swift
//  TestWebViewInterface
//
//  Created by admin on 2021/4/24.
//

import UIKit

class ViewController: UIViewController {

    var _webViw:EBWebView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        _webViw = EBWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        self.view.addSubview(_webViw)
        
        _webViw.load(url: "http://10.90.25.46:8087/")
    }
}

