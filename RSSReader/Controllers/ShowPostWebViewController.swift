//
//  ShowWebPostViewController.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 11.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit
import WebKit


class ShowPostWebViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingPageIndicator: UIActivityIndicatorView!
    
    
    var urlString: String!
    
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        if !urlString.isEmpty {
            let url = URL(string: urlString)
            let request = URLRequest(url: url!)
            loadingPageIndicator.startAnimating()
            webView.load(request)
        }
    }

}

extension ShowPostWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        loadingPageIndicator.stopAnimating()
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loadingPageIndicator.stopAnimating()
    }
}
