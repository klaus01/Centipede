//
//  CE_CBCentralManager.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import CoreBluetooth

public extension CBCentralManager {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: CBCentralManager_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? CBCentralManager_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: CBCentralManager_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
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
    
    public func ce_centralManagerDidUpdateState(handle: ((CBCentralManager) -> Void)) -> Self {
        ce._centralManagerDidUpdateState = handle
        rebindingDelegate()
        return self
    }
    public func ce_centralManager(handle: ((CBCentralManager, [String : Any]) -> Void)) -> Self {
        ce._centralManager = handle
        rebindingDelegate()
        return self
    }
    public func ce_centralManager_didDiscover(handle: ((CBCentralManager, CBPeripheral, [String : Any], NSNumber) -> Void)) -> Self {
        ce._centralManager_didDiscover = handle
        rebindingDelegate()
        return self
    }
    public func ce_centralManager_didConnect(handle: ((CBCentralManager, CBPeripheral) -> Void)) -> Self {
        ce._centralManager_didConnect = handle
        rebindingDelegate()
        return self
    }
    public func ce_centralManager_didFailToConnect(handle: ((CBCentralManager, CBPeripheral, Error?) -> Void)) -> Self {
        ce._centralManager_didFailToConnect = handle
        rebindingDelegate()
        return self
    }
    public func ce_centralManager_didDisconnectPeripheral(handle: ((CBCentralManager, CBPeripheral, Error?) -> Void)) -> Self {
        ce._centralManager_didDisconnectPeripheral = handle
        rebindingDelegate()
        return self
    }
    
}

internal class CBCentralManager_Delegate: NSObject, CBCentralManagerDelegate {
    
    var _centralManagerDidUpdateState: ((CBCentralManager) -> Void)?
    var _centralManager: ((CBCentralManager, [String : Any]) -> Void)?
    var _centralManager_didDiscover: ((CBCentralManager, CBPeripheral, [String : Any], NSNumber) -> Void)?
    var _centralManager_didConnect: ((CBCentralManager, CBPeripheral) -> Void)?
    var _centralManager_didFailToConnect: ((CBCentralManager, CBPeripheral, Error?) -> Void)?
    var _centralManager_didDisconnectPeripheral: ((CBCentralManager, CBPeripheral, Error?) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(centralManagerDidUpdateState(_:)) : _centralManagerDidUpdateState,
            #selector(centralManager(_:willRestoreState:)) : _centralManager,
            #selector(centralManager(_:didDiscover:advertisementData:rssi:)) : _centralManager_didDiscover,
            #selector(centralManager(_:didConnect:)) : _centralManager_didConnect,
            #selector(centralManager(_:didFailToConnect:error:)) : _centralManager_didFailToConnect,
            #selector(centralManager(_:didDisconnectPeripheral:error:)) : _centralManager_didDisconnectPeripheral,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func centralManagerDidUpdateState(_ central: CBCentralManager) {
        _centralManagerDidUpdateState!(central)
    }
    @objc func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        _centralManager!(central, dict)
    }
    @objc func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        _centralManager_didDiscover!(central, peripheral, advertisementData, RSSI)
    }
    @objc func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        _centralManager_didConnect!(central, peripheral)
    }
    @objc func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        _centralManager_didFailToConnect!(central, peripheral, error)
    }
    @objc func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        _centralManager_didDisconnectPeripheral!(central, peripheral, error)
    }
}
