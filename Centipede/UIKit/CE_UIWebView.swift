//
//  CE_UIWebView.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UIWebView {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIWebView_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIWebView_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIWebView_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
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
    public func ce_didFailLoadWithError(handle: (webView: UIWebView, error: NSError?) -> Void) -> Self {
        ce._didFailLoadWithError = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIWebView_Delegate: NSObject, UIWebViewDelegate {
    
    var _shouldStartLoadWithRequest: ((UIWebView, NSURLRequest, UIWebViewNavigationType) -> Bool)?
    var _didStartLoad: ((UIWebView) -> Void)?
    var _didFinishLoad: ((UIWebView) -> Void)?
    var _didFailLoadWithError: ((UIWebView, NSError?) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(webView(_:shouldStartLoadWithRequest:navigationType:)) : _shouldStartLoadWithRequest,
            #selector(webViewDidStartLoad(_:)) : _didStartLoad,
            #selector(webViewDidFinishLoad(_:)) : _didFinishLoad,
            #selector(webView(_:didFailLoadWithError:)) : _didFailLoadWithError,
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
    @objc func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        _didFailLoadWithError!(webView, error)
    }
}
