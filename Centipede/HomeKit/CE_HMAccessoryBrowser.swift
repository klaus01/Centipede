//
//  CE_HMAccessoryBrowser.swift
//  Centipede
//
//  Created by kelei on 2015/6/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import HomeKit

public extension HMAccessoryBrowser {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: HMAccessoryBrowser_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? HMAccessoryBrowser_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: HMAccessoryBrowser_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
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
    
    public func ce_didFindNewAccessory(handle: (browser: HMAccessoryBrowser, accessory: HMAccessory!) -> Void) -> Self {
        ce._didFindNewAccessory = handle
        rebindingDelegate()
        return self
    }
    public func ce_didRemoveNewAccessory(handle: (browser: HMAccessoryBrowser, accessory: HMAccessory!) -> Void) -> Self {
        ce._didRemoveNewAccessory = handle
        rebindingDelegate()
        return self
    }
    
}

internal class HMAccessoryBrowser_Delegate: NSObject, HMAccessoryBrowserDelegate {
    
    var _didFindNewAccessory: ((HMAccessoryBrowser, HMAccessory!) -> Void)?
    var _didRemoveNewAccessory: ((HMAccessoryBrowser, HMAccessory!) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "accessoryBrowser:didFindNewAccessory:" : _didFindNewAccessory,
            "accessoryBrowser:didRemoveNewAccessory:" : _didRemoveNewAccessory,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func accessoryBrowser(browser: HMAccessoryBrowser, didFindNewAccessory accessory: HMAccessory!) {
        _didFindNewAccessory!(browser, accessory)
    }
    @objc func accessoryBrowser(browser: HMAccessoryBrowser, didRemoveNewAccessory accessory: HMAccessory!) {
        _didRemoveNewAccessory!(browser, accessory)
    }
}
