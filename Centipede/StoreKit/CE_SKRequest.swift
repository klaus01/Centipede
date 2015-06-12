//
//  CE_SKRequest.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import StoreKit

public extension SKRequest {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: SKRequest_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? SKRequest_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: SKRequest_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is SKRequest_Delegate {
                return obj as! SKRequest_Delegate
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
    
    internal func getDelegateInstance() -> SKRequest_Delegate {
        return SKRequest_Delegate()
    }
    
    public func ce_didFinish(handle: (request: SKRequest) -> Void) -> Self {
        ce._didFinish = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFailWithError(handle: (request: SKRequest, error: NSError!) -> Void) -> Self {
        ce._didFailWithError = handle
        rebindingDelegate()
        return self
    }
    
}

internal class SKRequest_Delegate: NSObject, SKRequestDelegate {
    
    var _didFinish: ((SKRequest) -> Void)?
    var _didFailWithError: ((SKRequest, NSError!) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "requestDidFinish:" : _didFinish,
            "request:didFailWithError:" : _didFailWithError,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func requestDidFinish(request: SKRequest) {
        _didFinish!(request)
    }
    @objc func request(request: SKRequest, didFailWithError error: NSError!) {
        _didFailWithError!(request, error)
    }
}
