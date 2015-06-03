//
//  CE_UINavigationBar.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    private var ce: UINavigationBar_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UINavigationBar_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UINavigationBar_Delegate {
                return delegate as! UINavigationBar_Delegate
            }
        }
        let delegate = getDelegateInstance()
        objc_setAssociatedObject(self, &Static.AssociationKey, delegate, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        return delegate
    }
    
    private func rebindingDelegate() {
        let delegate = ce
        self.delegate = nil
        self.delegate = delegate
    }
    
    internal func getDelegateInstance() -> UINavigationBar_Delegate {
        return UINavigationBar_Delegate()
    }
    
    public func ce_ShouldPushItem(handle: (navigationBar: UINavigationBar, item: UINavigationItem) -> Bool) -> Self {
        ce.ShouldPushItem = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidPushItem(handle: (navigationBar: UINavigationBar, item: UINavigationItem) -> Void) -> Self {
        ce.DidPushItem = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldPopItem(handle: (navigationBar: UINavigationBar, item: UINavigationItem) -> Bool) -> Self {
        ce.ShouldPopItem = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidPopItem(handle: (navigationBar: UINavigationBar, item: UINavigationItem) -> Void) -> Self {
        ce.DidPopItem = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UINavigationBar_Delegate: NSObject, UINavigationBarDelegate {
    
    var ShouldPushItem: ((UINavigationBar, UINavigationItem) -> Bool)?
    var DidPushItem: ((UINavigationBar, UINavigationItem) -> Void)?
    var ShouldPopItem: ((UINavigationBar, UINavigationItem) -> Bool)?
    var DidPopItem: ((UINavigationBar, UINavigationItem) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "navigationBar:shouldPushItem:" : ShouldPushItem,
            "navigationBar:didPushItem:" : DidPushItem,
            "navigationBar:shouldPopItem:" : ShouldPopItem,
            "navigationBar:didPopItem:" : DidPopItem,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func navigationBar(navigationBar: UINavigationBar, shouldPushItem item: UINavigationItem) -> Bool {
        return ShouldPushItem!(navigationBar, item)
    }
    @objc func navigationBar(navigationBar: UINavigationBar, didPushItem item: UINavigationItem) {
        DidPushItem!(navigationBar, item)
    }
    @objc func navigationBar(navigationBar: UINavigationBar, shouldPopItem item: UINavigationItem) -> Bool {
        return ShouldPopItem!(navigationBar, item)
    }
    @objc func navigationBar(navigationBar: UINavigationBar, didPopItem item: UINavigationItem) {
        DidPopItem!(navigationBar, item)
    }
}
