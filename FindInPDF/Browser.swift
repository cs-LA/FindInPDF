import Foundation
import SwiftUI
import WebKit


struct Browser: UIViewRepresentable {
  
  func makeUIView(context: Context) -> WebView {
    return webView
  }
  
  func updateUIView(_ uiView: WebView, context: Context) {
  }
  
}


class WebView: WKWebView, WKNavigationDelegate {
  
  static let shared: WebView = {
    let configuration = WKWebViewConfiguration()
    let webView = WebView(frame: .zero, configuration: configuration)
    webView.navigationDelegate = webView
    return webView
  }()
  
  
  private init() {
    fatalError("You are not allowed to use this (private) initializer!")
  }
  
  override init(frame: CGRect, configuration: WKWebViewConfiguration) {
    super.init(frame: frame, configuration: configuration)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
    preferences.allowsContentJavaScript = true
    decisionHandler(.allow, preferences)
  }
  
  func webView(_ webView: WKWebView,
               didStartProvisionalNavigation navigation: WKNavigation!) {
  }
  
  func webView(_ webView: WKWebView,
               didFailProvisionalNavigation navigation: WKNavigation!,
               withError error: Error) {
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
  }
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
  }
  
}
