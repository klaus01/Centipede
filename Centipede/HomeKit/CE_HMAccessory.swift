//
//  CE_HMAccessory.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import HomeKit

public extension HMAccessory {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: HMAccessory_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? HMAccessory_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: HMAccessory_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is HMAccessory_Delegate {
                return obj as! HMAccessory_Delegate
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
    
    internal func getDelegateInstance() -> HMAccessory_Delegate {
        return HMAccessory_Delegate()
    }
    
    public func ce_accessoryDidUpdateName(handle: ((HMAccessory) -> Void)) -> Self {
        ce._accessoryDidUpdateName = handle
        rebindingDelegate()
        return self
    }
    public func ce_accessory_didUpdateNameFor(handle: ((HMAccessory, HMService) -> Void)) -> Self {
        ce._accessory_didUpdateNameFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_accessory_didUpdateAssociatedServiceTypeFor(handle: ((HMAccessory, HMService) -> Void)) -> Self {
        ce._accessory_didUpdateAssociatedServiceTypeFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_accessoryDidUpdateServices(handle: ((HMAccessory) -> Void)) -> Self {
        ce._accessoryDidUpdateServices = handle
        rebindingDelegate()
        return self
    }
    public func ce_accessoryDidUpdateReachability(handle: ((HMAccessory) -> Void)) -> Self {
        ce._accessoryDidUpdateReachability = handle
        rebindingDelegate()
        return self
    }
    public func ce_accessory_service(handle: ((HMAccessory, HMService, HMCharacteristic) -> Void)) -> Self {
        ce._accessory_service = handle
        rebindingDelegate()
        return self
    }
    
}

internal class HMAccessory_Delegate: NSObject, HMAccessoryDelegate {
    
    var _accessoryDidUpdateName: ((HMAccessory) -> Void)?
    var _accessory_didUpdateNameFor: ((HMAccessory, HMService) -> Void)?
    var _accessory_didUpdateAssociatedServiceTypeFor: ((HMAccessory, HMService) -> Void)?
    var _accessoryDidUpdateServices: ((HMAccessory) -> Void)?
    var _accessoryDidUpdateReachability: ((HMAccessory) -> Void)?
    var _accessory_service: ((HMAccessory, HMService, HMCharacteristic) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(accessoryDidUpdateName(_:)) : _accessoryDidUpdateName,
            #selector(accessory(_:didUpdateNameFor:)) : _accessory_didUpdateNameFor,
            #selector(accessory(_:didUpdateAssociatedServiceTypeFor:)) : _accessory_didUpdateAssociatedServiceTypeFor,
            #selector(accessoryDidUpdateServices(_:)) : _accessoryDidUpdateServices,
            #selector(accessoryDidUpdateReachability(_:)) : _accessoryDidUpdateReachability,
            #selector(accessory(_:service:didUpdateValueFor:)) : _accessory_service,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func accessoryDidUpdateName(_ accessory: HMAccessory) {
        _accessoryDidUpdateName!(accessory)
    }
    @objc func accessory(_ accessory: HMAccessory, didUpdateNameFor service: HMService) {
        _accessory_didUpdateNameFor!(accessory, service)
    }
    @objc func accessory(_ accessory: HMAccessory, didUpdateAssociatedServiceTypeFor service: HMService) {
        _accessory_didUpdateAssociatedServiceTypeFor!(accessory, service)
    }
    @objc func accessoryDidUpdateServices(_ accessory: HMAccessory) {
        _accessoryDidUpdateServices!(accessory)
    }
    @objc func accessoryDidUpdateReachability(_ accessory: HMAccessory) {
        _accessoryDidUpdateReachability!(accessory)
    }
    @objc func accessory(_ accessory: HMAccessory, service: HMService, didUpdateValueFor characteristic: HMCharacteristic) {
        _accessory_service!(accessory, service, characteristic)
    }
}
