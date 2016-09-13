//
//  CE_HMHomeManager.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import HomeKit

public extension HMHomeManager {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: HMHomeManager_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? HMHomeManager_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: HMHomeManager_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
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
    
    public func ce_homeManagerDidUpdateHomes(handle: ((HMHomeManager) -> Void)) -> Self {
        ce._homeManagerDidUpdateHomes = handle
        rebindingDelegate()
        return self
    }
    public func ce_homeManagerDidUpdatePrimaryHome(handle: ((HMHomeManager) -> Void)) -> Self {
        ce._homeManagerDidUpdatePrimaryHome = handle
        rebindingDelegate()
        return self
    }
    public func ce_homeManager(handle: ((HMHomeManager, HMHome) -> Void)) -> Self {
        ce._homeManager = handle
        rebindingDelegate()
        return self
    }
    public func ce_homeManager_didRemove(handle: ((HMHomeManager, HMHome) -> Void)) -> Self {
        ce._homeManager_didRemove = handle
        rebindingDelegate()
        return self
    }
    
}

internal class HMHomeManager_Delegate: NSObject, HMHomeManagerDelegate {
    
    var _homeManagerDidUpdateHomes: ((HMHomeManager) -> Void)?
    var _homeManagerDidUpdatePrimaryHome: ((HMHomeManager) -> Void)?
    var _homeManager: ((HMHomeManager, HMHome) -> Void)?
    var _homeManager_didRemove: ((HMHomeManager, HMHome) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(homeManagerDidUpdateHomes(_:)) : _homeManagerDidUpdateHomes,
            #selector(homeManagerDidUpdatePrimaryHome(_:)) : _homeManagerDidUpdatePrimaryHome,
            #selector(homeManager(_:didAdd:)) : _homeManager,
            #selector(homeManager(_:didRemove:)) : _homeManager_didRemove,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        _homeManagerDidUpdateHomes!(manager)
    }
    @objc func homeManagerDidUpdatePrimaryHome(_ manager: HMHomeManager) {
        _homeManagerDidUpdatePrimaryHome!(manager)
    }
    @objc func homeManager(_ manager: HMHomeManager, didAdd home: HMHome) {
        _homeManager!(manager, home)
    }
    @objc func homeManager(_ manager: HMHomeManager, didRemove home: HMHome) {
        _homeManager_didRemove!(manager, home)
    }
}
