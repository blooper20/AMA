//
//  CPRWebViewController.swift
//  AMA
//
//  Created by DwaeWoo on 2024/05/14.
//

import UIKit
import SnapKit
import WebKit

final class AEDWebViewController: UIViewController, WKUIDelegate {
    
    //MARK: - Declaration
    var webView: WKWebView!
    private let url = "https://www.kacpr.org/page/page.php?category_idx=3&category1_code=1247206302&category2_code=1527742406&page_idx=1119"
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    
    
    //MARK: - View Cycle
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWebView()
    }
}

extension AEDWebViewController {
    
    //MARK: - Function
    private func setWebView() {
        guard let myURL = URL(string: url) else { return }
        webView.load(URLRequest(url: myURL))
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .systemGreen
        
        webView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

//MARK: - Delegate
extension AEDWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
