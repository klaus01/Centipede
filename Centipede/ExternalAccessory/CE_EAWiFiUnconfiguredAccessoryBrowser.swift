//
//  CE_EAWiFiUnconfiguredAccessoryBrowser.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import ExternalAccessory

public extension EAWiFiUnconfiguredAccessoryBrowser {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: EAWiFiUnconfiguredAccessoryBrowser_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? EAWiFiUnconfiguredAccessoryBrowser_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
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
    
    public func ce_accessoryBrowser(handle: (browser: EAWiFiUnconfiguredAccessoryBrowser, state: EAWiFiUnconfiguredAccessoryBrowserState) -> Void) -> Self {
        ce._accessoryBrowser = handle
        rebindingDelegate()
        return self
    }
    public func ce_accessoryBrowserAndDidFindUnconfiguredAccessories(handle: (browser: EAWiFiUnconfiguredAccessoryBrowser, accessories: Set<NSObject>!) -> Void) -> Self {
        ce._accessoryBrowserAndDidFindUnconfiguredAccessories = handle
        rebindingDelegate()
        return self
    }
    public func ce_accessoryBrowserAndDidRemoveUnconfiguredAccessories(handle: (browser: EAWiFiUnconfiguredAccessoryBrowser, accessories: Set<NSObject>!) -> Void) -> Self {
        ce._accessoryBrowserAndDidRemoveUnconfiguredAccessories = handle
        rebindingDelegate()
        return self
    }
    public func ce_accessoryBrowserAndDidFinishConfiguringAccessory(handle: (browser: EAWiFiUnconfiguredAccessoryBrowser, accessory: EAWiFiUnconfiguredAccessory!, status: EAWiFiUnconfiguredAccessoryConfigurationStatus) -> Void) -> Self {
        ce._accessoryBrowserAndDidFinishConfiguringAccessory = handle
        rebindingDelegate()
        return self
    }
    
}

internal class EAWiFiUnconfiguredAccessoryBrowser_Delegate: NSObject, EAWiFiUnconfiguredAccessoryBrowserDelegate {
    
    var _accessoryBrowser: ((EAWiFiUnconfiguredAccessoryBrowser, EAWiFiUnconfiguredAccessoryBrowserState) -> Void)?
    var _accessoryBrowserAndDidFindUnconfiguredAccessories: ((EAWiFiUnconfiguredAccessoryBrowser, Set<NSObject>!) -> Void)?
    var _accessoryBrowserAndDidRemoveUnconfiguredAccessories: ((EAWiFiUnconfiguredAccessoryBrowser, Set<NSObject>!) -> Void)?
    var _accessoryBrowserAndDidFinishConfiguringAccessory: ((EAWiFiUnconfiguredAccessoryBrowser, EAWiFiUnconfiguredAccessory!, EAWiFiUnconfiguredAccessoryConfigurationStatus) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "accessoryBrowser:didUpdateState:" : _accessoryBrowser,
            "accessoryBrowser:didFindUnconfiguredAccessories:" : _accessoryBrowserAndDidFindUnconfiguredAccessories,
            "accessoryBrowser:didRemoveUnconfiguredAccessories:" : _accessoryBrowserAndDidRemoveUnconfiguredAccessories,
            "accessoryBrowser:didFinishConfiguringAccessory:withStatus:" : _accessoryBrowserAndDidFinishConfiguringAccessory,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func accessoryBrowser(browser: EAWiFiUnconfiguredAccessoryBrowser, didUpdateState state: EAWiFiUnconfiguredAccessoryBrowserState) {
        _accessoryBrowser!(browser, state)
    }
    @objc func accessoryBrowser(browser: EAWiFiUnconfiguredAccessoryBrowser, didFindUnconfiguredAccessories accessories: Set<NSObject>!) {
        _accessoryBrowserAndDidFindUnconfiguredAccessories!(browser, accessories)
    }
    @objc func accessoryBrowser(browser: EAWiFiUnconfiguredAccessoryBrowser, didRemoveUnconfiguredAccessories accessories: Set<NSObject>!) {
        _accessoryBrowserAndDidRemoveUnconfiguredAccessories!(browser, accessories)
    }
    @objc func accessoryBrowser(browser: EAWiFiUnconfiguredAccessoryBrowser, didFinishConfiguringAccessory accessory: EAWiFiUnconfiguredAccessory!, withStatus status: EAWiFiUnconfiguredAccessoryConfigurationStatus) {
        _accessoryBrowserAndDidFinishConfiguringAccessory!(browser, accessory, status)
    }
}
