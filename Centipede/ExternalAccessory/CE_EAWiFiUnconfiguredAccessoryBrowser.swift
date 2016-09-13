//
//  CE_EAWiFiUnconfiguredAccessoryBrowser.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import ExternalAccessory

public extension EAWiFiUnconfiguredAccessoryBrowser {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: EAWiFiUnconfiguredAccessoryBrowser_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? EAWiFiUnconfiguredAccessoryBrowser_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: EAWiFiUnconfiguredAccessoryBrowser_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is EAWiFiUnconfiguredAccessoryBrowser_Delegate {
                return obj as! EAWiFiUnconfiguredAccessoryBrowser_Delegate
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
    
    internal func getDelegateInstance() -> EAWiFiUnconfiguredAccessoryBrowser_Delegate {
        return EAWiFiUnconfiguredAccessoryBrowser_Delegate()
    }
    
    public func ce_accessoryBrowser(handle: ((EAWiFiUnconfiguredAccessoryBrowser, EAWiFiUnconfiguredAccessoryBrowserState) -> Void)) -> Self {
        ce._accessoryBrowser = handle
        rebindingDelegate()
        return self
    }
    public func ce_accessoryBrowser_didFindUnconfiguredAccessories(handle: ((EAWiFiUnconfiguredAccessoryBrowser, Set<EAWiFiUnconfiguredAccessory>) -> Void)) -> Self {
        ce._accessoryBrowser_didFindUnconfiguredAccessories = handle
        rebindingDelegate()
        return self
    }
    public func ce_accessoryBrowser_didRemoveUnconfiguredAccessories(handle: ((EAWiFiUnconfiguredAccessoryBrowser, Set<EAWiFiUnconfiguredAccessory>) -> Void)) -> Self {
        ce._accessoryBrowser_didRemoveUnconfiguredAccessories = handle
        rebindingDelegate()
        return self
    }
    public func ce_accessoryBrowser_didFinishConfiguringAccessory(handle: ((EAWiFiUnconfiguredAccessoryBrowser, EAWiFiUnconfiguredAccessory, EAWiFiUnconfiguredAccessoryConfigurationStatus) -> Void)) -> Self {
        ce._accessoryBrowser_didFinishConfiguringAccessory = handle
        rebindingDelegate()
        return self
    }
    
}

internal class EAWiFiUnconfiguredAccessoryBrowser_Delegate: NSObject, EAWiFiUnconfiguredAccessoryBrowserDelegate {
    
    var _accessoryBrowser: ((EAWiFiUnconfiguredAccessoryBrowser, EAWiFiUnconfiguredAccessoryBrowserState) -> Void)?
    var _accessoryBrowser_didFindUnconfiguredAccessories: ((EAWiFiUnconfiguredAccessoryBrowser, Set<EAWiFiUnconfiguredAccessory>) -> Void)?
    var _accessoryBrowser_didRemoveUnconfiguredAccessories: ((EAWiFiUnconfiguredAccessoryBrowser, Set<EAWiFiUnconfiguredAccessory>) -> Void)?
    var _accessoryBrowser_didFinishConfiguringAccessory: ((EAWiFiUnconfiguredAccessoryBrowser, EAWiFiUnconfiguredAccessory, EAWiFiUnconfiguredAccessoryConfigurationStatus) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(accessoryBrowser(_:didUpdate:)) : _accessoryBrowser,
            #selector(accessoryBrowser(_:didFindUnconfiguredAccessories:)) : _accessoryBrowser_didFindUnconfiguredAccessories,
            #selector(accessoryBrowser(_:didRemoveUnconfiguredAccessories:)) : _accessoryBrowser_didRemoveUnconfiguredAccessories,
            #selector(accessoryBrowser(_:didFinishConfiguringAccessory:with:)) : _accessoryBrowser_didFinishConfiguringAccessory,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func accessoryBrowser(_ browser: EAWiFiUnconfiguredAccessoryBrowser, didUpdate state: EAWiFiUnconfiguredAccessoryBrowserState) {
        _accessoryBrowser!(browser, state)
    }
    @objc func accessoryBrowser(_ browser: EAWiFiUnconfiguredAccessoryBrowser, didFindUnconfiguredAccessories accessories: Set<EAWiFiUnconfiguredAccessory>) {
        _accessoryBrowser_didFindUnconfiguredAccessories!(browser, accessories)
    }
    @objc func accessoryBrowser(_ browser: EAWiFiUnconfiguredAccessoryBrowser, didRemoveUnconfiguredAccessories accessories: Set<EAWiFiUnconfiguredAccessory>) {
        _accessoryBrowser_didRemoveUnconfiguredAccessories!(browser, accessories)
    }
    @objc func accessoryBrowser(_ browser: EAWiFiUnconfiguredAccessoryBrowser, didFinishConfiguringAccessory accessory: EAWiFiUnconfiguredAccessory, with status: EAWiFiUnconfiguredAccessoryConfigurationStatus) {
        _accessoryBrowser_didFinishConfiguringAccessory!(browser, accessory, status)
    }
}
