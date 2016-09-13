//
//  CE_EAAccessory.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import ExternalAccessory

public extension EAAccessory {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: EAAccessory_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? EAAccessory_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: EAAccessory_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is EAAccessory_Delegate {
                return obj as! EAAccessory_Delegate
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
    
    internal func getDelegateInstance() -> EAAccessory_Delegate {
        return EAAccessory_Delegate()
    }
    
    public func ce_accessoryDidDisconnect(handle: ((EAAccessory) -> Void)) -> Self {
        ce._accessoryDidDisconnect = handle
        rebindingDelegate()
        return self
    }
    
}

internal class EAAccessory_Delegate: NSObject, EAAccessoryDelegate {
    
    var _accessoryDidDisconnect: ((EAAccessory) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(accessoryDidDisconnect(_:)) : _accessoryDidDisconnect,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func accessoryDidDisconnect(_ accessory: EAAccessory) {
        _accessoryDidDisconnect!(accessory)
    }
}
