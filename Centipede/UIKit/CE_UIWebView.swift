//
//  CE_UIWebView.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

extension UIWebView {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIWebView_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIWebView_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIWebView_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is UIWebView_Delegate {
                return obj as! UIWebView_Delegate
            }
        }
        let obj = getDelegateInstance()
        _delegate = obj
        return obj
    }
    
    private func rebindingDelegate() {
        let delegate = ce
        self.delegate = nil
        self.delegate = delegate
    }
    
    internal func getDelegateInstance() -> UIWebView_Delegate {
        return UIWebView_Delegate()
    }
    
    @discardableResult
    public func ce_webView_shouldStartLoadWith(handle: @escaping (UIWebView, URLRequest, UIWebViewNavigationType) -> Bool) -> Self {
        ce._webView_shouldStartLoadWith = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_webViewDidStartLoad(handle: @escaping (UIWebView) -> Void) -> Self {
        ce._webViewDidStartLoad = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_webViewDidFinishLoad(handle: @escaping (UIWebView) -> Void) -> Self {
        ce._webViewDidFinishLoad = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_webView_didFailLoadWithError(handle: @escaping (UIWebView, Error) -> Void) -> Self {
        ce._webView_didFailLoadWithError = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIWebView_Delegate: NSObject, UIWebViewDelegate {
    
    var _webView_shouldStartLoadWith: ((UIWebView, URLRequest, UIWebViewNavigationType) -> Bool)?
    var _webViewDidStartLoad: ((UIWebView) -> Void)?
    var _webViewDidFinishLoad: ((UIWebView) -> Void)?
    var _webView_didFailLoadWithError: ((UIWebView, Error) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(webView(_:shouldStartLoadWith:navigationType:)) : _webView_shouldStartLoadWith,
            #selector(webViewDidStartLoad(_:)) : _webViewDidStartLoad,
            #selector(webViewDidFinishLoad(_:)) : _webViewDidFinishLoad,
            #selector(webView(_:didFailLoadWithError:)) : _webView_didFailLoadWithError,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return _webView_shouldStartLoadWith!(webView, request, navigationType)
    }
    @objc func webViewDidStartLoad(_ webView: UIWebView) {
        _webViewDidStartLoad!(webView)
    }
    @objc func webViewDidFinishLoad(_ webView: UIWebView) {
        _webViewDidFinishLoad!(webView)
    }
    @objc func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        _webView_didFailLoadWithError!(webView, error)
    }
}
