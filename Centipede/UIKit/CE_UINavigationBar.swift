//
//  CE_UINavigationBar.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UINavigationBar {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UINavigationBar_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UINavigationBar_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: UINavigationBar_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is UINavigationBar_Delegate {
                return obj as! UINavigationBar_Delegate
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
    
    internal func getDelegateInstance() -> UINavigationBar_Delegate {
        return UINavigationBar_Delegate()
    }
    
    public func ce_shouldPushItem(handle: (navigationBar: UINavigationBar, item: UINavigationItem) -> Bool) -> Self {
        ce._shouldPushItem = handle
        rebindingDelegate()
        return self
    }
    public func ce_didPushItem(handle: (navigationBar: UINavigationBar, item: UINavigationItem) -> Void) -> Self {
        ce._didPushItem = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldPopItem(handle: (navigationBar: UINavigationBar, item: UINavigationItem) -> Bool) -> Self {
        ce._shouldPopItem = handle
        rebindingDelegate()
        return self
    }
    public func ce_didPopItem(handle: (navigationBar: UINavigationBar, item: UINavigationItem) -> Void) -> Self {
        ce._didPopItem = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UINavigationBar_Delegate: NSObject, UINavigationBarDelegate {
    
    var _shouldPushItem: ((UINavigationBar, UINavigationItem) -> Bool)?
    var _didPushItem: ((UINavigationBar, UINavigationItem) -> Void)?
    var _shouldPopItem: ((UINavigationBar, UINavigationItem) -> Bool)?
    var _didPopItem: ((UINavigationBar, UINavigationItem) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "navigationBar:shouldPushItem:" : _shouldPushItem,
            "navigationBar:didPushItem:" : _didPushItem,
            "navigationBar:shouldPopItem:" : _shouldPopItem,
            "navigationBar:didPopItem:" : _didPopItem,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func navigationBar(navigationBar: UINavigationBar, shouldPushItem item: UINavigationItem) -> Bool {
        return _shouldPushItem!(navigationBar, item)
    }
    @objc func navigationBar(navigationBar: UINavigationBar, didPushItem item: UINavigationItem) {
        _didPushItem!(navigationBar, item)
    }
    @objc func navigationBar(navigationBar: UINavigationBar, shouldPopItem item: UINavigationItem) -> Bool {
        return _shouldPopItem!(navigationBar, item)
    }
    @objc func navigationBar(navigationBar: UINavigationBar, didPopItem item: UINavigationItem) {
        _didPopItem!(navigationBar, item)
    }
}
