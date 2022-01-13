//
//  WebViewContainerViewController.swift
//  UIComponents
//
//  Created by Semih Emre ÜNLÜ on 9.01.2022.
//

import UIKit
import WebKit

class WebViewContainerViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureWebView()
        configureActivityIndicator()
    }

    var urlString = "https://www.google.com"

    func configureWebView() {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)

        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false

        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
//        webView.configuration = configuration
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.isLoading),
                            options: .new,
                            context: nil)
        webView.load(urlRequest)
    }

    func configureActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.color = .red
        activityIndicator.hidesWhenStopped = true
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {

        if keyPath == "loading" {
            webView.isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }

    }

    @IBAction func reloadButtonTapped(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    // MARK: - HOMEWORK PART 1
    
    @IBAction func openWithSafari(_ sender: UIBarButtonItem) {
        UIApplication.shared.open(webView.url!, options: [:], completionHandler: nil)
    }
    
    @IBAction func goBackward(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    let htmlString = """
    <!doctype html>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <html>
        <head>
            <style>
                body {
                    font-size: 36px;
                    font-family: "AmericanTypewriter";
                    
                    text-align: center;
                    height: 100vh;
                    display:flex;
                }
                
                .container{
                    display: grid;
                    align-items: center;
                    justify-content: center;
                    
                    width:90vw;
                    height: 90vh;
                    margin: auto;
                }
                
                .element{
                    margin: auto;
                }
            </style>
        </head>
        <body>
            <div class="container">
                <div class="element">
                    Hello, <span class="custom">WKWebView!</span>

                </div>
            </div>
            
        </body>
    </html>
    """
    
    @IBAction func loadHtml(_ sender: UIBarButtonItem) {
        
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
}

extension WebViewContainerViewController: WKNavigationDelegate {

}

extension WebViewContainerViewController: WKUIDelegate {

}
