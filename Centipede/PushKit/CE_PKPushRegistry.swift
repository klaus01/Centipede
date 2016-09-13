//
//  CE_PKPushRegistry.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import PushKit

public extension PKPushRegistry {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: PKPushRegistry_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? PKPushRegistry_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: PKPushRegistry_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is PKPushRegistry_Delegate {
                return obj as! PKPushRegistry_Delegate
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
    
    internal func getDelegateInstance() -> PKPushRegistry_Delegate {
        return PKPushRegistry_Delegate()
    }
    
    public func ce_pushRegistry_didUpdate(handle: ((PKPushRegistry, PKPushCredentials, PKPushType) -> Void)) -> Self {
        ce._pushRegistry_didUpdate = handle
        rebindingDelegate()
        return self
    }
    public func ce_pushRegistry_didReceiveIncomingPushWith(handle: ((PKPushRegistry, PKPushPayload, PKPushType) -> Void)) -> Self {
        ce._pushRegistry_didReceiveIncomingPushWith = handle
        rebindingDelegate()
        return self
    }
    public func ce_pushRegistry_didInvalidatePushTokenForType(handle: ((PKPushRegistry, PKPushType) -> Void)) -> Self {
        ce._pushRegistry_didInvalidatePushTokenForType = handle
        rebindingDelegate()
        return self
    }
    
}

internal class PKPushRegistry_Delegate: NSObject, PKPushRegistryDelegate {
    
    var _pushRegistry_didUpdate: ((PKPushRegistry, PKPushCredentials, PKPushType) -> Void)?
    var _pushRegistry_didReceiveIncomingPushWith: ((PKPushRegistry, PKPushPayload, PKPushType) -> Void)?
    var _pushRegistry_didInvalidatePushTokenForType: ((PKPushRegistry, PKPushType) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(pushRegistry(_:didUpdate:forType:)) : _pushRegistry_didUpdate,
            #selector(pushRegistry(_:didReceiveIncomingPushWith:forType:)) : _pushRegistry_didReceiveIncomingPushWith,
            #selector(pushRegistry(_:didInvalidatePushTokenForType:)) : _pushRegistry_didInvalidatePushTokenForType,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func pushRegistry(_ registry: PKPushRegistry, didUpdate credentials: PKPushCredentials, forType type: PKPushType) {
        _pushRegistry_didUpdate!(registry, credentials, type)
    }
    @objc func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, forType type: PKPushType) {
        _pushRegistry_didReceiveIncomingPushWith!(registry, payload, type)
    }
    @objc func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenForType type: PKPushType) {
        _pushRegistry_didInvalidatePushTokenForType!(registry, type)
    }
}
