//
//  CE_SKProductsRequest.swift
//  Centipede
//
//  Created by kelei on 2015/6/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import StoreKit

public extension SKProductsRequest {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: SKProductsRequest_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? SKProductsRequest_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: SKProductsRequest_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is SKProductsRequest_Delegate {
                return obj as! SKProductsRequest_Delegate
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
    
    internal override func getDelegateInstance() -> SKProductsRequest_Delegate {
        return SKProductsRequest_Delegate()
    }
    
    public func ce_didReceiveResponse(handle: (request: SKProductsRequest, response: SKProductsResponse!) -> Void) -> Self {
        ce._didReceiveResponse = handle
        rebindingDelegate()
        return self
    }
    
}

internal class SKProductsRequest_Delegate: SKRequest_Delegate, SKProductsRequestDelegate {
    
    var _didReceiveResponse: ((SKProductsRequest, SKProductsResponse!) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "productsRequest:didReceiveResponse:" : _didReceiveResponse,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse!) {
        _didReceiveResponse!(request, response)
    }
}
