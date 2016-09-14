//
//  CE_SKRequest.swift
//  Centipede
//
//  Created by kelei on 2016/9/14.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import StoreKit

public extension SKRequest {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: SKRequest_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? SKRequest_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
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
    
    public func ce_requestDidFinish(handle: @escaping (SKRequest) -> Void) -> Self {
        ce._requestDidFinish = handle
        rebindingDelegate()
        return self
    }
    public func ce_request_didFailWithError(handle: @escaping (SKRequest, Error) -> Void) -> Self {
        ce._request_didFailWithError = handle
        rebindingDelegate()
        return self
    }
    
}

internal class SKRequest_Delegate: NSObject, SKRequestDelegate {
    
    var _requestDidFinish: ((SKRequest) -> Void)?
    var _request_didFailWithError: ((SKRequest, Error) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(requestDidFinish(_:)) : _requestDidFinish,
            #selector(request(_:didFailWithError:)) : _request_didFailWithError,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func requestDidFinish(_ request: SKRequest) {
        _requestDidFinish!(request)
    }
    @objc func request(_ request: SKRequest, didFailWithError error: Error) {
        _request_didFailWithError!(request, error)
    }
}
