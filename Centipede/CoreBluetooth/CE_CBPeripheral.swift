//
//  CE_CBPeripheral.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import CoreBluetooth

public extension CBPeripheral {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: CBPeripheral_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? CBPeripheral_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: CBPeripheral_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
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
    
    public func ce_peripheralDidUpdateName(handle: ((CBPeripheral) -> Void)) -> Self {
        ce._peripheralDidUpdateName = handle
        rebindingDelegate()
        return self
    }
    public func ce_peripheral_didModifyServices(handle: ((CBPeripheral, [CBService]) -> Void)) -> Self {
        ce._peripheral_didModifyServices = handle
        rebindingDelegate()
        return self
    }
    public func ce_peripheralDidUpdateRSSI_error(handle: ((CBPeripheral, Error?) -> Void)) -> Self {
        ce._peripheralDidUpdateRSSI_error = handle
        rebindingDelegate()
        return self
    }
    public func ce_peripheral_didReadRSSI(handle: ((CBPeripheral, NSNumber, Error?) -> Void)) -> Self {
        ce._peripheral_didReadRSSI = handle
        rebindingDelegate()
        return self
    }
    public func ce_peripheral_didDiscoverServices(handle: ((CBPeripheral, Error?) -> Void)) -> Self {
        ce._peripheral_didDiscoverServices = handle
        rebindingDelegate()
        return self
    }
    public func ce_peripheral_didDiscoverIncludedServicesFor(handle: ((CBPeripheral, CBService, Error?) -> Void)) -> Self {
        ce._peripheral_didDiscoverIncludedServicesFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_peripheral_didDiscoverCharacteristicsFor(handle: ((CBPeripheral, CBService, Error?) -> Void)) -> Self {
        ce._peripheral_didDiscoverCharacteristicsFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_peripheral_didUpdateValueFor(handle: ((CBPeripheral, CBCharacteristic, Error?) -> Void)) -> Self {
        ce._peripheral_didUpdateValueFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_peripheral_didWriteValueFor(handle: ((CBPeripheral, CBCharacteristic, Error?) -> Void)) -> Self {
        ce._peripheral_didWriteValueFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_peripheral_didUpdateNotificationStateFor(handle: ((CBPeripheral, CBCharacteristic, Error?) -> Void)) -> Self {
        ce._peripheral_didUpdateNotificationStateFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_peripheral_didDiscoverDescriptorsFor(handle: ((CBPeripheral, CBCharacteristic, Error?) -> Void)) -> Self {
        ce._peripheral_didDiscoverDescriptorsFor = handle
        rebindingDelegate()
        return self
    }
    
}

internal class CBPeripheral_Delegate: NSObject, CBPeripheralDelegate {
    
    var _peripheralDidUpdateName: ((CBPeripheral) -> Void)?
    var _peripheral_didModifyServices: ((CBPeripheral, [CBService]) -> Void)?
    var _peripheralDidUpdateRSSI_error: ((CBPeripheral, Error?) -> Void)?
    var _peripheral_didReadRSSI: ((CBPeripheral, NSNumber, Error?) -> Void)?
    var _peripheral_didDiscoverServices: ((CBPeripheral, Error?) -> Void)?
    var _peripheral_didDiscoverIncludedServicesFor: ((CBPeripheral, CBService, Error?) -> Void)?
    var _peripheral_didDiscoverCharacteristicsFor: ((CBPeripheral, CBService, Error?) -> Void)?
    var _peripheral_didUpdateValueFor: ((CBPeripheral, CBCharacteristic, Error?) -> Void)?
    var _peripheral_didWriteValueFor: ((CBPeripheral, CBCharacteristic, Error?) -> Void)?
    var _peripheral_didUpdateNotificationStateFor: ((CBPeripheral, CBCharacteristic, Error?) -> Void)?
    var _peripheral_didDiscoverDescriptorsFor: ((CBPeripheral, CBCharacteristic, Error?) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(peripheralDidUpdateName(_:)) : _peripheralDidUpdateName,
            #selector(peripheral(_:didModifyServices:)) : _peripheral_didModifyServices,
            #selector(peripheralDidUpdateRSSI(_:error:)) : _peripheralDidUpdateRSSI_error,
            #selector(peripheral(_:didReadRSSI:error:)) : _peripheral_didReadRSSI,
            #selector(peripheral(_:didDiscoverServices:)) : _peripheral_didDiscoverServices,
            #selector(peripheral(_:didDiscoverIncludedServicesFor:error:)) : _peripheral_didDiscoverIncludedServicesFor,
            #selector(peripheral(_:didDiscoverCharacteristicsFor:error:)) : _peripheral_didDiscoverCharacteristicsFor,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(peripheral(_:didUpdateValueFor:error:)) : _peripheral_didUpdateValueFor,
            #selector(peripheral(_:didWriteValueFor:error:)) : _peripheral_didWriteValueFor,
            #selector(peripheral(_:didUpdateNotificationStateFor:error:)) : _peripheral_didUpdateNotificationStateFor,
            #selector(peripheral(_:didDiscoverDescriptorsFor:error:)) : _peripheral_didDiscoverDescriptorsFor,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func peripheralDidUpdateName(_ peripheral: CBPeripheral) {
        _peripheralDidUpdateName!(peripheral)
    }
    @objc func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        _peripheral_didModifyServices!(peripheral, invalidatedServices)
    }
    @objc func peripheralDidUpdateRSSI(_ peripheral: CBPeripheral, error: Error?) {
        _peripheralDidUpdateRSSI_error!(peripheral, error)
    }
    @objc func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        _peripheral_didReadRSSI!(peripheral, RSSI, error)
    }
    @objc func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        _peripheral_didDiscoverServices!(peripheral, error)
    }
    @objc func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: Error?) {
        _peripheral_didDiscoverIncludedServicesFor!(peripheral, service, error)
    }
    @objc func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        _peripheral_didDiscoverCharacteristicsFor!(peripheral, service, error)
    }
    @objc func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        _peripheral_didUpdateValueFor!(peripheral, characteristic, error)
    }
    @objc func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        _peripheral_didWriteValueFor!(peripheral, characteristic, error)
    }
    @objc func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        _peripheral_didUpdateNotificationStateFor!(peripheral, characteristic, error)
    }
    @objc func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        _peripheral_didDiscoverDescriptorsFor!(peripheral, characteristic, error)
    }
}
