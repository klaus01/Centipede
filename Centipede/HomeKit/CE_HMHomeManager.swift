//
//  CE_HMHomeManager.swift
//  Centipede
//
//  Created by kelei on 2015/6/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import HomeKit

public extension HMHomeManager {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: HMHomeManager_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? HMHomeManager_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: HMHomeManager_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is HMHomeManager_Delegate {
                return obj as! HMHomeManager_Delegate
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
    
    internal func getDelegateInstance() -> HMHomeManager_Delegate {
        return HMHomeManager_Delegate()
    }
    
    public func ce_didUpdateHomes(handle: (manager: HMHomeManager) -> Void) -> Self {
        ce._didUpdateHomes = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdatePrimaryHome(handle: (manager: HMHomeManager) -> Void) -> Self {
        ce._didUpdatePrimaryHome = handle
        rebindingDelegate()
        return self
    }
    public func ce_didAddHome(handle: (manager: HMHomeManager, home: HMHome!) -> Void) -> Self {
        ce._didAddHome = handle
        rebindingDelegate()
        return self
    }
    public func ce_didRemoveHome(handle: (manager: HMHomeManager, home: HMHome!) -> Void) -> Self {
        ce._didRemoveHome = handle
        rebindingDelegate()
        return self
    }
    
}

internal class HMHomeManager_Delegate: NSObject, HMHomeManagerDelegate {
    
    var _didUpdateHomes: ((HMHomeManager) -> Void)?
    var _didUpdatePrimaryHome: ((HMHomeManager) -> Void)?
    var _didAddHome: ((HMHomeManager, HMHome!) -> Void)?
    var _didRemoveHome: ((HMHomeManager, HMHome!) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "homeManagerDidUpdateHomes:" : _didUpdateHomes,
            "homeManagerDidUpdatePrimaryHome:" : _didUpdatePrimaryHome,
            "homeManager:didAddHome:" : _didAddHome,
            "homeManager:didRemoveHome:" : _didRemoveHome,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func homeManagerDidUpdateHomes(manager: HMHomeManager) {
        _didUpdateHomes!(manager)
    }
    @objc func homeManagerDidUpdatePrimaryHome(manager: HMHomeManager) {
        _didUpdatePrimaryHome!(manager)
    }
    @objc func homeManager(manager: HMHomeManager, didAddHome home: HMHome!) {
        _didAddHome!(manager, home)
    }
    @objc func homeManager(manager: HMHomeManager, didRemoveHome home: HMHome!) {
        _didRemoveHome!(manager, home)
    }
}
