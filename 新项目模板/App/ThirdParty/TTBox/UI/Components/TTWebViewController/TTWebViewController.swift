//
//  TTWebViewController.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/3/12.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import UIKit
import WebKit
class TTWebViewController: TTViewController,WKNavigationDelegate {
    
    var currentUrl: URL!
    var webView = WKWebView()
    
    init(_ url: String) {
        super.init()
        
        webView.navigationDelegate = self
        
        print(url)
        if let url = URL.init(string: url) {
            currentUrl = url
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeUI() {
        super.makeUI()
        addSubviews([webView])
        
        
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        

    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        // 加载网页
        webView.load(URLRequest.init(url: currentUrl))
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // 赋值标题
        self.title = webView.title
    }
}
