//
//  CE_HMAccessory.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
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
    
    public func ce_didUpdateName(handle: (accessory: HMAccessory) -> Void) -> Self {
        ce._didUpdateName = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateNameForService(handle: (accessory: HMAccessory, service: HMService) -> Void) -> Self {
        ce._didUpdateNameForService = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateAssociatedServiceTypeForService(handle: (accessory: HMAccessory, service: HMService) -> Void) -> Self {
        ce._didUpdateAssociatedServiceTypeForService = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateServices(handle: (accessory: HMAccessory) -> Void) -> Self {
        ce._didUpdateServices = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateReachability(handle: (accessory: HMAccessory) -> Void) -> Self {
        ce._didUpdateReachability = handle
        rebindingDelegate()
        return self
    }
    public func ce_serviceDidUpdateValueForCharacteristic(handle: (accessory: HMAccessory, service: HMService, characteristic: HMCharacteristic) -> Void) -> Self {
        ce._serviceDidUpdateValueForCharacteristic = handle
        rebindingDelegate()
        return self
    }
    
}

internal class HMAccessory_Delegate: NSObject, HMAccessoryDelegate {
    
    var _didUpdateName: ((HMAccessory) -> Void)?
    var _didUpdateNameForService: ((HMAccessory, HMService) -> Void)?
    var _didUpdateAssociatedServiceTypeForService: ((HMAccessory, HMService) -> Void)?
    var _didUpdateServices: ((HMAccessory) -> Void)?
    var _didUpdateReachability: ((HMAccessory) -> Void)?
    var _serviceDidUpdateValueForCharacteristic: ((HMAccessory, HMService, HMCharacteristic) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "accessoryDidUpdateName:" : _didUpdateName,
            "accessory:didUpdateNameForService:" : _didUpdateNameForService,
            "accessory:didUpdateAssociatedServiceTypeForService:" : _didUpdateAssociatedServiceTypeForService,
            "accessoryDidUpdateServices:" : _didUpdateServices,
            "accessoryDidUpdateReachability:" : _didUpdateReachability,
            "accessory:service:didUpdateValueForCharacteristic:" : _serviceDidUpdateValueForCharacteristic,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func accessoryDidUpdateName(accessory: HMAccessory) {
        _didUpdateName!(accessory)
    }
    @objc func accessory(accessory: HMAccessory, didUpdateNameForService service: HMService) {
        _didUpdateNameForService!(accessory, service)
    }
    @objc func accessory(accessory: HMAccessory, didUpdateAssociatedServiceTypeForService service: HMService) {
        _didUpdateAssociatedServiceTypeForService!(accessory, service)
    }
    @objc func accessoryDidUpdateServices(accessory: HMAccessory) {
        _didUpdateServices!(accessory)
    }
    @objc func accessoryDidUpdateReachability(accessory: HMAccessory) {
        _didUpdateReachability!(accessory)
    }
    @objc func accessory(accessory: HMAccessory, service: HMService, didUpdateValueForCharacteristic characteristic: HMCharacteristic) {
        _serviceDidUpdateValueForCharacteristic!(accessory, service, characteristic)
    }
}
