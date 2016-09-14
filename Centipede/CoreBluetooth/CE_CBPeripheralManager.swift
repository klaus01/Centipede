//
//  CE_CBPeripheralManager.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import CoreBluetooth

public extension CBPeripheralManager {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: CBPeripheralManager_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? CBPeripheralManager_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: CBPeripheralManager_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is CBPeripheralManager_Delegate {
                return obj as! CBPeripheralManager_Delegate
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
    
    internal func getDelegateInstance() -> CBPeripheralManager_Delegate {
        return CBPeripheralManager_Delegate()
    }
    
    @discardableResult
    public func ce_peripheralManagerDidUpdateState(handle: @escaping (CBPeripheralManager) -> Void) -> Self {
        ce._peripheralManagerDidUpdateState = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_peripheralManager_willRestoreState(handle: @escaping (CBPeripheralManager, [String : Any]) -> Void) -> Self {
        ce._peripheralManager_willRestoreState = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_peripheralManagerDidStartAdvertising_error(handle: @escaping (CBPeripheralManager, Error?) -> Void) -> Self {
        ce._peripheralManagerDidStartAdvertising_error = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_peripheralManager_didAdd(handle: @escaping (CBPeripheralManager, CBService, Error?) -> Void) -> Self {
        ce._peripheralManager_didAdd = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_peripheralManager_central(handle: @escaping (CBPeripheralManager, CBCentral, CBCharacteristic) -> Void) -> Self {
        ce._peripheralManager_central = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_peripheralManager_central_central(handle: @escaping (CBPeripheralManager, CBCentral, CBCharacteristic) -> Void) -> Self {
        ce._peripheralManager_central_central = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_peripheralManager_didReceiveRead(handle: @escaping (CBPeripheralManager, CBATTRequest) -> Void) -> Self {
        ce._peripheralManager_didReceiveRead = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_peripheralManager_didReceiveWrite(handle: @escaping (CBPeripheralManager, [CBATTRequest]) -> Void) -> Self {
        ce._peripheralManager_didReceiveWrite = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_peripheralManagerIsReady_toUpdateSubscribers(handle: @escaping (CBPeripheralManager) -> Void) -> Self {
        ce._peripheralManagerIsReady_toUpdateSubscribers = handle
        rebindingDelegate()
        return self
    }
    
}

internal class CBPeripheralManager_Delegate: NSObject, CBPeripheralManagerDelegate {
    
    var _peripheralManagerDidUpdateState: ((CBPeripheralManager) -> Void)?
    var _peripheralManager_willRestoreState: ((CBPeripheralManager, [String : Any]) -> Void)?
    var _peripheralManagerDidStartAdvertising_error: ((CBPeripheralManager, Error?) -> Void)?
    var _peripheralManager_didAdd: ((CBPeripheralManager, CBService, Error?) -> Void)?
    var _peripheralManager_central: ((CBPeripheralManager, CBCentral, CBCharacteristic) -> Void)?
    var _peripheralManager_central_central: ((CBPeripheralManager, CBCentral, CBCharacteristic) -> Void)?
    var _peripheralManager_didReceiveRead: ((CBPeripheralManager, CBATTRequest) -> Void)?
    var _peripheralManager_didReceiveWrite: ((CBPeripheralManager, [CBATTRequest]) -> Void)?
    var _peripheralManagerIsReady_toUpdateSubscribers: ((CBPeripheralManager) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(peripheralManagerDidUpdateState(_:)) : _peripheralManagerDidUpdateState,
            #selector(peripheralManager(_:willRestoreState:)) : _peripheralManager_willRestoreState,
            #selector(peripheralManagerDidStartAdvertising(_:error:)) : _peripheralManagerDidStartAdvertising_error,
            #selector(peripheralManager(_:didAdd:error:)) : _peripheralManager_didAdd,
            #selector(peripheralManager(_:central:didSubscribeTo:)) : _peripheralManager_central,
            #selector(peripheralManager(_:central:didUnsubscribeFrom:)) : _peripheralManager_central_central,
            #selector(peripheralManager(_:didReceiveRead:)) : _peripheralManager_didReceiveRead,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(peripheralManager(_:didReceiveWrite:)) : _peripheralManager_didReceiveWrite,
            #selector(peripheralManagerIsReady(toUpdateSubscribers:)) : _peripheralManagerIsReady_toUpdateSubscribers,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        _peripheralManagerDidUpdateState!(peripheral)
    }
    @objc func peripheralManager(_ peripheral: CBPeripheralManager, willRestoreState dict: [String : Any]) {
        _peripheralManager_willRestoreState!(peripheral, dict)
    }
    @objc func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        _peripheralManagerDidStartAdvertising_error!(peripheral, error)
    }
    @objc func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        _peripheralManager_didAdd!(peripheral, service, error)
    }
    @objc func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        _peripheralManager_central!(peripheral, central, characteristic)
    }
    @objc func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        _peripheralManager_central_central!(peripheral, central, characteristic)
    }
    @objc func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        _peripheralManager_didReceiveRead!(peripheral, request)
    }
    @objc func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        _peripheralManager_didReceiveWrite!(peripheral, requests)
    }
    @objc func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
        _peripheralManagerIsReady_toUpdateSubscribers!(peripheral)
    }
}
