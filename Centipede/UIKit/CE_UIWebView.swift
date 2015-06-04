//
//  CE_UIWebView.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UIWebView {
    
    private var ce: UIWebView_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIWebView_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UIWebView_Delegate {
                return delegate as! UIWebView_Delegate
            }
        }
        let delegate = getDelegateInstance()
        objc_setAssociatedObject(self, &Static.AssociationKey, delegate, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        return delegate
    }
    
    private func rebindingDelegate() {
        let delegate = ce
        self.delegate = nil
        self.delegate = delegate
    }
    
    internal func getDelegateInstance() -> UIWebView_Delegate {
        return UIWebView_Delegate()
    }
    
    public func ce_shouldStartLoadWithRequest(handle: (webView: UIWebView, request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool) -> Self {
        ce._shouldStartLoadWithRequest = handle
        rebindingDelegate()
        return self
    }
    public func ce_didStartLoad(handle: (webView: UIWebView) -> Void) -> Self {
        ce._didStartLoad = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFinishLoad(handle: (webView: UIWebView) -> Void) -> Self {
        ce._didFinishLoad = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFailLoadWithError(handle: (webView: UIWebView, error: NSError) -> Void) -> Self {
        ce._didFailLoadWithError = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIWebView_Delegate: NSObject, UIWebViewDelegate {
    
    var _shouldStartLoadWithRequest: ((UIWebView, NSURLRequest, UIWebViewNavigationType) -> Bool)?
    var _didStartLoad: ((UIWebView) -> Void)?
    var _didFinishLoad: ((UIWebView) -> Void)?
    var _didFailLoadWithError: ((UIWebView, NSError) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "webView:shouldStartLoadWithRequest:navigationType:" : _shouldStartLoadWithRequest,
            "webViewDidStartLoad:" : _didStartLoad,
            "webViewDidFinishLoad:" : _didFinishLoad,
            "webView:didFailLoadWithError:" : _didFailLoadWithError,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return _shouldStartLoadWithRequest!(webView, request, navigationType)
    }
    @objc func webViewDidStartLoad(webView: UIWebView) {
        _didStartLoad!(webView)
    }
    @objc func webViewDidFinishLoad(webView: UIWebView) {
        _didFinishLoad!(webView)
    }
    @objc func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        _didFailLoadWithError!(webView, error)
    }
}
