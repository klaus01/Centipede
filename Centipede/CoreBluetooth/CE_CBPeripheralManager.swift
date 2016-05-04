//
//  CE_CBPeripheralManager.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
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
    
    public func ce_didUpdateState(handle: (peripheral: CBPeripheralManager) -> Void) -> Self {
        ce._didUpdateState = handle
        rebindingDelegate()
        return self
    }
    public func ce_willRestoreState(handle: (peripheral: CBPeripheralManager, dict: [String : AnyObject]) -> Void) -> Self {
        ce._willRestoreState = handle
        rebindingDelegate()
        return self
    }
    public func ce_didStartAdvertising(handle: (peripheral: CBPeripheralManager, error: NSError?) -> Void) -> Self {
        ce._didStartAdvertising = handle
        rebindingDelegate()
        return self
    }
    public func ce_didAddService(handle: (peripheral: CBPeripheralManager, service: CBService, error: NSError?) -> Void) -> Self {
        ce._didAddService = handle
        rebindingDelegate()
        return self
    }
    public func ce_centralDidSubscribeToCharacteristic(handle: (peripheral: CBPeripheralManager, central: CBCentral, characteristic: CBCharacteristic) -> Void) -> Self {
        ce._centralDidSubscribeToCharacteristic = handle
        rebindingDelegate()
        return self
    }
    public func ce_centralDidUnsubscribeFromCharacteristic(handle: (peripheral: CBPeripheralManager, central: CBCentral, characteristic: CBCharacteristic) -> Void) -> Self {
        ce._centralDidUnsubscribeFromCharacteristic = handle
        rebindingDelegate()
        return self
    }
    public func ce_didReceiveReadRequest(handle: (peripheral: CBPeripheralManager, request: CBATTRequest) -> Void) -> Self {
        ce._didReceiveReadRequest = handle
        rebindingDelegate()
        return self
    }
    public func ce_didReceiveWriteRequests(handle: (peripheral: CBPeripheralManager, requests: [CBATTRequest]) -> Void) -> Self {
        ce._didReceiveWriteRequests = handle
        rebindingDelegate()
        return self
    }
    public func ce_isReadyToUpdateSubscribers(handle: (peripheral: CBPeripheralManager) -> Void) -> Self {
        ce._isReadyToUpdateSubscribers = handle
        rebindingDelegate()
        return self
    }
    
}

internal class CBPeripheralManager_Delegate: NSObject, CBPeripheralManagerDelegate {
    
    var _didUpdateState: ((CBPeripheralManager) -> Void)?
    var _willRestoreState: ((CBPeripheralManager, [String : AnyObject]) -> Void)?
    var _didStartAdvertising: ((CBPeripheralManager, NSError?) -> Void)?
    var _didAddService: ((CBPeripheralManager, CBService, NSError?) -> Void)?
    var _centralDidSubscribeToCharacteristic: ((CBPeripheralManager, CBCentral, CBCharacteristic) -> Void)?
    var _centralDidUnsubscribeFromCharacteristic: ((CBPeripheralManager, CBCentral, CBCharacteristic) -> Void)?
    var _didReceiveReadRequest: ((CBPeripheralManager, CBATTRequest) -> Void)?
    var _didReceiveWriteRequests: ((CBPeripheralManager, [CBATTRequest]) -> Void)?
    var _isReadyToUpdateSubscribers: ((CBPeripheralManager) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(peripheralManagerDidUpdateState(_:)) : _didUpdateState,
            #selector(peripheralManager(_:willRestoreState:)) : _willRestoreState,
            #selector(peripheralManagerDidStartAdvertising(_:error:)) : _didStartAdvertising,
            #selector(peripheralManager(_:didAddService:error:)) : _didAddService,
            #selector(peripheralManager(_:central:didSubscribeToCharacteristic:)) : _centralDidSubscribeToCharacteristic,
            #selector(peripheralManager(_:central:didUnsubscribeFromCharacteristic:)) : _centralDidUnsubscribeFromCharacteristic,
            #selector(peripheralManager(_:didReceiveReadRequest:)) : _didReceiveReadRequest,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(peripheralManager(_:didReceiveWriteRequests:)) : _didReceiveWriteRequests,
            #selector(peripheralManagerIsReadyToUpdateSubscribers(_:)) : _isReadyToUpdateSubscribers,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        _didUpdateState!(peripheral)
    }
    @objc func peripheralManager(peripheral: CBPeripheralManager, willRestoreState dict: [String : AnyObject]) {
        _willRestoreState!(peripheral, dict)
    }
    @objc func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        _didStartAdvertising!(peripheral, error)
    }
    @objc func peripheralManager(peripheral: CBPeripheralManager, didAddService service: CBService, error: NSError?) {
        _didAddService!(peripheral, service, error)
    }
    @objc func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didSubscribeToCharacteristic characteristic: CBCharacteristic) {
        _centralDidSubscribeToCharacteristic!(peripheral, central, characteristic)
    }
    @objc func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFromCharacteristic characteristic: CBCharacteristic) {
        _centralDidUnsubscribeFromCharacteristic!(peripheral, central, characteristic)
    }
    @objc func peripheralManager(peripheral: CBPeripheralManager, didReceiveReadRequest request: CBATTRequest) {
        _didReceiveReadRequest!(peripheral, request)
    }
    @objc func peripheralManager(peripheral: CBPeripheralManager, didReceiveWriteRequests requests: [CBATTRequest]) {
        _didReceiveWriteRequests!(peripheral, requests)
    }
    @objc func peripheralManagerIsReadyToUpdateSubscribers(peripheral: CBPeripheralManager) {
        _isReadyToUpdateSubscribers!(peripheral)
    }
}
