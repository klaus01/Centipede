//
//  CE_CBPeripheral.swift
//  Centipede
//
//  Created by kelei on 2015/6/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import CoreBluetooth

public extension CBPeripheral {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: CBPeripheral_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? CBPeripheral_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: CBPeripheral_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is CBPeripheral_Delegate {
                return obj as! CBPeripheral_Delegate
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
    
    internal func getDelegateInstance() -> CBPeripheral_Delegate {
        return CBPeripheral_Delegate()
    }
    
    public func ce_didUpdateName(handle: (peripheral: CBPeripheral) -> Void) -> Self {
        ce._didUpdateName = handle
        rebindingDelegate()
        return self
    }
    public func ce_didModifyServices(handle: (peripheral: CBPeripheral, invalidatedServices: [AnyObject]!) -> Void) -> Self {
        ce._didModifyServices = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateRSSI(handle: (peripheral: CBPeripheral, error: NSError!) -> Void) -> Self {
        ce._didUpdateRSSI = handle
        rebindingDelegate()
        return self
    }
    public func ce_didReadRSSI(handle: (peripheral: CBPeripheral, RSSI: NSNumber!, error: NSError!) -> Void) -> Self {
        ce._didReadRSSI = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDiscoverServices(handle: (peripheral: CBPeripheral, error: NSError!) -> Void) -> Self {
        ce._didDiscoverServices = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDiscoverIncludedServicesForService(handle: (peripheral: CBPeripheral, service: CBService!, error: NSError!) -> Void) -> Self {
        ce._didDiscoverIncludedServicesForService = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDiscoverCharacteristicsForService(handle: (peripheral: CBPeripheral, service: CBService!, error: NSError!) -> Void) -> Self {
        ce._didDiscoverCharacteristicsForService = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateValueForCharacteristic(handle: (peripheral: CBPeripheral, characteristic: CBCharacteristic!, error: NSError!) -> Void) -> Self {
        ce._didUpdateValueForCharacteristic = handle
        rebindingDelegate()
        return self
    }
    public func ce_didWriteValueForCharacteristic(handle: (peripheral: CBPeripheral, characteristic: CBCharacteristic!, error: NSError!) -> Void) -> Self {
        ce._didWriteValueForCharacteristic = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateNotificationStateForCharacteristic(handle: (peripheral: CBPeripheral, characteristic: CBCharacteristic!, error: NSError!) -> Void) -> Self {
        ce._didUpdateNotificationStateForCharacteristic = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDiscoverDescriptorsForCharacteristic(handle: (peripheral: CBPeripheral, characteristic: CBCharacteristic!, error: NSError!) -> Void) -> Self {
        ce._didDiscoverDescriptorsForCharacteristic = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateValueForDescriptor(handle: (peripheral: CBPeripheral, descriptor: CBDescriptor!, error: NSError!) -> Void) -> Self {
        ce._didUpdateValueForDescriptor = handle
        rebindingDelegate()
        return self
    }
    public func ce_didWriteValueForDescriptor(handle: (peripheral: CBPeripheral, descriptor: CBDescriptor!, error: NSError!) -> Void) -> Self {
        ce._didWriteValueForDescriptor = handle
        rebindingDelegate()
        return self
    }
    
}

internal class CBPeripheral_Delegate: NSObject, CBPeripheralDelegate {
    
    var _didUpdateName: ((CBPeripheral) -> Void)?
    var _didModifyServices: ((CBPeripheral, [AnyObject]!) -> Void)?
    var _didUpdateRSSI: ((CBPeripheral, NSError!) -> Void)?
    var _didReadRSSI: ((CBPeripheral, NSNumber!, NSError!) -> Void)?
    var _didDiscoverServices: ((CBPeripheral, NSError!) -> Void)?
    var _didDiscoverIncludedServicesForService: ((CBPeripheral, CBService!, NSError!) -> Void)?
    var _didDiscoverCharacteristicsForService: ((CBPeripheral, CBService!, NSError!) -> Void)?
    var _didUpdateValueForCharacteristic: ((CBPeripheral, CBCharacteristic!, NSError!) -> Void)?
    var _didWriteValueForCharacteristic: ((CBPeripheral, CBCharacteristic!, NSError!) -> Void)?
    var _didUpdateNotificationStateForCharacteristic: ((CBPeripheral, CBCharacteristic!, NSError!) -> Void)?
    var _didDiscoverDescriptorsForCharacteristic: ((CBPeripheral, CBCharacteristic!, NSError!) -> Void)?
    var _didUpdateValueForDescriptor: ((CBPeripheral, CBDescriptor!, NSError!) -> Void)?
    var _didWriteValueForDescriptor: ((CBPeripheral, CBDescriptor!, NSError!) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "peripheralDidUpdateName:" : _didUpdateName,
            "peripheral:didModifyServices:" : _didModifyServices,
            "peripheralDidUpdateRSSI:error:" : _didUpdateRSSI,
            "peripheral:didReadRSSI:error:" : _didReadRSSI,
            "peripheral:didDiscoverServices:" : _didDiscoverServices,
            "peripheral:didDiscoverIncludedServicesForService:error:" : _didDiscoverIncludedServicesForService,
            "peripheral:didDiscoverCharacteristicsForService:error:" : _didDiscoverCharacteristicsForService,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "peripheral:didUpdateValueForCharacteristic:error:" : _didUpdateValueForCharacteristic,
            "peripheral:didWriteValueForCharacteristic:error:" : _didWriteValueForCharacteristic,
            "peripheral:didUpdateNotificationStateForCharacteristic:error:" : _didUpdateNotificationStateForCharacteristic,
            "peripheral:didDiscoverDescriptorsForCharacteristic:error:" : _didDiscoverDescriptorsForCharacteristic,
            "peripheral:didUpdateValueForDescriptor:error:" : _didUpdateValueForDescriptor,
            "peripheral:didWriteValueForDescriptor:error:" : _didWriteValueForDescriptor,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func peripheralDidUpdateName(peripheral: CBPeripheral) {
        _didUpdateName!(peripheral)
    }
    @objc func peripheral(peripheral: CBPeripheral, didModifyServices invalidatedServices: [AnyObject]!) {
        _didModifyServices!(peripheral, invalidatedServices)
    }
    @objc func peripheralDidUpdateRSSI(peripheral: CBPeripheral, error: NSError!) {
        _didUpdateRSSI!(peripheral, error)
    }
    @objc func peripheral(peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber!, error: NSError!) {
        _didReadRSSI!(peripheral, RSSI, error)
    }
    @objc func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError!) {
        _didDiscoverServices!(peripheral, error)
    }
    @objc func peripheral(peripheral: CBPeripheral, didDiscoverIncludedServicesForService service: CBService!, error: NSError!) {
        _didDiscoverIncludedServicesForService!(peripheral, service, error)
    }
    @objc func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService!, error: NSError!) {
        _didDiscoverCharacteristicsForService!(peripheral, service, error)
    }
    @objc func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        _didUpdateValueForCharacteristic!(peripheral, characteristic, error)
    }
    @objc func peripheral(peripheral: CBPeripheral, didWriteValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        _didWriteValueForCharacteristic!(peripheral, characteristic, error)
    }
    @objc func peripheral(peripheral: CBPeripheral, didUpdateNotificationStateForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        _didUpdateNotificationStateForCharacteristic!(peripheral, characteristic, error)
    }
    @objc func peripheral(peripheral: CBPeripheral, didDiscoverDescriptorsForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        _didDiscoverDescriptorsForCharacteristic!(peripheral, characteristic, error)
    }
    @objc func peripheral(peripheral: CBPeripheral, didUpdateValueForDescriptor descriptor: CBDescriptor!, error: NSError!) {
        _didUpdateValueForDescriptor!(peripheral, descriptor, error)
    }
    @objc func peripheral(peripheral: CBPeripheral, didWriteValueForDescriptor descriptor: CBDescriptor!, error: NSError!) {
        _didWriteValueForDescriptor!(peripheral, descriptor, error)
    }
}
