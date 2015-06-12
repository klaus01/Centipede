//
//  CE_PKPushRegistry.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import PushKit

public extension PKPushRegistry {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: PKPushRegistry_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? PKPushRegistry_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
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
    
    public func ce_didUpdatePushCredentials(handle: (registry: PKPushRegistry, credentials: PKPushCredentials!, type: String!) -> Void) -> Self {
        ce._didUpdatePushCredentials = handle
        rebindingDelegate()
        return self
    }
    public func ce_didReceiveIncomingPushWithPayload(handle: (registry: PKPushRegistry, payload: PKPushPayload!, type: String!) -> Void) -> Self {
        ce._didReceiveIncomingPushWithPayload = handle
        rebindingDelegate()
        return self
    }
    public func ce_didInvalidatePushTokenForType(handle: (registry: PKPushRegistry, type: String!) -> Void) -> Self {
        ce._didInvalidatePushTokenForType = handle
        rebindingDelegate()
        return self
    }
    
}

internal class PKPushRegistry_Delegate: NSObject, PKPushRegistryDelegate {
    
    var _didUpdatePushCredentials: ((PKPushRegistry, PKPushCredentials!, String!) -> Void)?
    var _didReceiveIncomingPushWithPayload: ((PKPushRegistry, PKPushPayload!, String!) -> Void)?
    var _didInvalidatePushTokenForType: ((PKPushRegistry, String!) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "pushRegistry:didUpdatePushCredentials:forType:" : _didUpdatePushCredentials,
            "pushRegistry:didReceiveIncomingPushWithPayload:forType:" : _didReceiveIncomingPushWithPayload,
            "pushRegistry:didInvalidatePushTokenForType:" : _didInvalidatePushTokenForType,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func pushRegistry(registry: PKPushRegistry, didUpdatePushCredentials credentials: PKPushCredentials!, forType type: String!) {
        _didUpdatePushCredentials!(registry, credentials, type)
    }
    @objc func pushRegistry(registry: PKPushRegistry, didReceiveIncomingPushWithPayload payload: PKPushPayload!, forType type: String!) {
        _didReceiveIncomingPushWithPayload!(registry, payload, type)
    }
    @objc func pushRegistry(registry: PKPushRegistry, didInvalidatePushTokenForType type: String!) {
        _didInvalidatePushTokenForType!(registry, type)
    }
}
