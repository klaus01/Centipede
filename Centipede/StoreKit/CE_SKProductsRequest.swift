//
//  CE_SKProductsRequest.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import StoreKit

public extension SKProductsRequest {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: SKProductsRequest_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? SKProductsRequest_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
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
    
    public func ce_productsRequest_didReceive(handle: ((SKProductsRequest, SKProductsResponse) -> Void)) -> Self {
        ce._productsRequest_didReceive = handle
        rebindingDelegate()
        return self
    }
    
}

internal class SKProductsRequest_Delegate: SKRequest_Delegate, SKProductsRequestDelegate {
    
    var _productsRequest_didReceive: ((SKProductsRequest, SKProductsResponse) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(productsRequest(_:didReceive:)) : _productsRequest_didReceive,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        _productsRequest_didReceive!(request, response)
    }
}
