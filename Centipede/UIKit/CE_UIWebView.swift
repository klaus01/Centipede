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
    
    public func ce_ShouldStartLoadWithRequest(handle: (webView: UIWebView, request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool) -> Self {
        ce.ShouldStartLoadWithRequest = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidStartLoad(handle: (webView: UIWebView) -> Void) -> Self {
        ce.DidStartLoad = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidFinishLoad(handle: (webView: UIWebView) -> Void) -> Self {
        ce.DidFinishLoad = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidFailLoadWithError(handle: (webView: UIWebView, error: NSError) -> Void) -> Self {
        ce.DidFailLoadWithError = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIWebView_Delegate: NSObject, UIWebViewDelegate {
    
    var ShouldStartLoadWithRequest: ((UIWebView, NSURLRequest, UIWebViewNavigationType) -> Bool)?
    var DidStartLoad: ((UIWebView) -> Void)?
    var DidFinishLoad: ((UIWebView) -> Void)?
    var DidFailLoadWithError: ((UIWebView, NSError) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "webView:shouldStartLoadWithRequest:navigationType:" : ShouldStartLoadWithRequest,
            "webViewDidStartLoad:" : DidStartLoad,
            "webViewDidFinishLoad:" : DidFinishLoad,
            "webView:didFailLoadWithError:" : DidFailLoadWithError,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return ShouldStartLoadWithRequest!(webView, request, navigationType)
    }
    @objc func webViewDidStartLoad(webView: UIWebView) {
        DidStartLoad!(webView)
    }
    @objc func webViewDidFinishLoad(webView: UIWebView) {
        DidFinishLoad!(webView)
    }
    @objc func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        DidFailLoadWithError!(webView, error)
    }
}
