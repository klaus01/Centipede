//
//  CE_HMAccessoryBrowser.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import HomeKit

public extension HMAccessoryBrowser {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: HMAccessoryBrowser_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? HMAccessoryBrowser_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: HMAccessoryBrowser_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is HMAccessoryBrowser_Delegate {
                return obj as! HMAccessoryBrowser_Delegate
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
    
    internal func getDelegateInstance() -> HMAccessoryBrowser_Delegate {
        return HMAccessoryBrowser_Delegate()
    }
    
    public func ce_accessoryBrowser(handle: ((HMAccessoryBrowser, HMAccessory) -> Void)) -> Self {
        ce._accessoryBrowser = handle
        rebindingDelegate()
        return self
    }
    public func ce_accessoryBrowser_didRemoveNewAccessory(handle: ((HMAccessoryBrowser, HMAccessory) -> Void)) -> Self {
        ce._accessoryBrowser_didRemoveNewAccessory = handle
        rebindingDelegate()
        return self
    }
    
}

internal class HMAccessoryBrowser_Delegate: NSObject, HMAccessoryBrowserDelegate {
    
    var _accessoryBrowser: ((HMAccessoryBrowser, HMAccessory) -> Void)?
    var _accessoryBrowser_didRemoveNewAccessory: ((HMAccessoryBrowser, HMAccessory) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(accessoryBrowser(_:didFindNewAccessory:)) : _accessoryBrowser,
            #selector(accessoryBrowser(_:didRemoveNewAccessory:)) : _accessoryBrowser_didRemoveNewAccessory,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func accessoryBrowser(_ browser: HMAccessoryBrowser, didFindNewAccessory accessory: HMAccessory) {
        _accessoryBrowser!(browser, accessory)
    }
    @objc func accessoryBrowser(_ browser: HMAccessoryBrowser, didRemoveNewAccessory accessory: HMAccessory) {
        _accessoryBrowser_didRemoveNewAccessory!(browser, accessory)
    }
}
