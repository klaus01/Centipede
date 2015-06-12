//
//  CE_EAAccessory.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import ExternalAccessory

public extension EAAccessory {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: EAAccessory_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? EAAccessory_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
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
    
    public func ce_didDisconnect(handle: (accessory: EAAccessory) -> Void) -> Self {
        ce._didDisconnect = handle
        rebindingDelegate()
        return self
    }
    
}

internal class EAAccessory_Delegate: NSObject, EAAccessoryDelegate {
    
    var _didDisconnect: ((EAAccessory) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "accessoryDidDisconnect:" : _didDisconnect,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func accessoryDidDisconnect(accessory: EAAccessory) {
        _didDisconnect!(accessory)
    }
}
