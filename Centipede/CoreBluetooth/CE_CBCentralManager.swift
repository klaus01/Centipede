//
//  CE_CBCentralManager.swift
//  Centipede
//
//  Created by kelei on 2015/6/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import CoreBluetooth

public extension CBCentralManager {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: CBCentralManager_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? CBCentralManager_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: CBCentralManager_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is CBCentralManager_Delegate {
                return obj as! CBCentralManager_Delegate
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
    
    internal func getDelegateInstance() -> CBCentralManager_Delegate {
        return CBCentralManager_Delegate()
    }
    
    public func ce_didUpdateState(handle: (central: CBCentralManager) -> Void) -> Self {
        ce._didUpdateState = handle
        rebindingDelegate()
        return self
    }
    public func ce_willRestoreState(handle: (central: CBCentralManager, dict: [NSObject : AnyObject]!) -> Void) -> Self {
        ce._willRestoreState = handle
        rebindingDelegate()
        return self
    }
    public func ce_didRetrievePeripherals(handle: (central: CBCentralManager, peripherals: [AnyObject]!) -> Void) -> Self {
        ce._didRetrievePeripherals = handle
        rebindingDelegate()
        return self
    }
    public func ce_didRetrieveConnectedPeripherals(handle: (central: CBCentralManager, peripherals: [AnyObject]!) -> Void) -> Self {
        ce._didRetrieveConnectedPeripherals = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDiscoverPeripheral(handle: (central: CBCentralManager, peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) -> Void) -> Self {
        ce._didDiscoverPeripheral = handle
        rebindingDelegate()
        return self
    }
    public func ce_didConnectPeripheral(handle: (central: CBCentralManager, peripheral: CBPeripheral!) -> Void) -> Self {
        ce._didConnectPeripheral = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFailToConnectPeripheral(handle: (central: CBCentralManager, peripheral: CBPeripheral!, error: NSError!) -> Void) -> Self {
        ce._didFailToConnectPeripheral = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDisconnectPeripheral(handle: (central: CBCentralManager, peripheral: CBPeripheral!, error: NSError!) -> Void) -> Self {
        ce._didDisconnectPeripheral = handle
        rebindingDelegate()
        return self
    }
    
}

internal class CBCentralManager_Delegate: NSObject, CBCentralManagerDelegate {
    
    var _didUpdateState: ((CBCentralManager) -> Void)?
    var _willRestoreState: ((CBCentralManager, [NSObject : AnyObject]!) -> Void)?
    var _didRetrievePeripherals: ((CBCentralManager, [AnyObject]!) -> Void)?
    var _didRetrieveConnectedPeripherals: ((CBCentralManager, [AnyObject]!) -> Void)?
    var _didDiscoverPeripheral: ((CBCentralManager, CBPeripheral!, [NSObject : AnyObject]!, NSNumber!) -> Void)?
    var _didConnectPeripheral: ((CBCentralManager, CBPeripheral!) -> Void)?
    var _didFailToConnectPeripheral: ((CBCentralManager, CBPeripheral!, NSError!) -> Void)?
    var _didDisconnectPeripheral: ((CBCentralManager, CBPeripheral!, NSError!) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "centralManagerDidUpdateState:" : _didUpdateState,
            "centralManager:willRestoreState:" : _willRestoreState,
            "centralManager:didRetrievePeripherals:" : _didRetrievePeripherals,
            "centralManager:didRetrieveConnectedPeripherals:" : _didRetrieveConnectedPeripherals,
            "centralManager:didDiscoverPeripheral:advertisementData:RSSI:" : _didDiscoverPeripheral,
            "centralManager:didConnectPeripheral:" : _didConnectPeripheral,
            "centralManager:didFailToConnectPeripheral:error:" : _didFailToConnectPeripheral,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "centralManager:didDisconnectPeripheral:error:" : _didDisconnectPeripheral,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func centralManagerDidUpdateState(central: CBCentralManager) {
        _didUpdateState!(central)
    }
    @objc func centralManager(central: CBCentralManager, willRestoreState dict: [NSObject : AnyObject]!) {
        _willRestoreState!(central, dict)
    }
    @objc func centralManager(central: CBCentralManager, didRetrievePeripherals peripherals: [AnyObject]!) {
        _didRetrievePeripherals!(central, peripherals)
    }
    @objc func centralManager(central: CBCentralManager, didRetrieveConnectedPeripherals peripherals: [AnyObject]!) {
        _didRetrieveConnectedPeripherals!(central, peripherals)
    }
    @objc func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        _didDiscoverPeripheral!(central, peripheral, advertisementData, RSSI)
    }
    @objc func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral!) {
        _didConnectPeripheral!(central, peripheral)
    }
    @objc func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
        _didFailToConnectPeripheral!(central, peripheral, error)
    }
    @objc func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
        _didDisconnectPeripheral!(central, peripheral, error)
    }
}
