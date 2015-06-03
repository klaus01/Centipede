//
//  CE_UITabBar.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UITabBar {
    
    private var ce: UITabBar_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UITabBar_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UITabBar_Delegate {
                return delegate as! UITabBar_Delegate
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
    
    internal func getDelegateInstance() -> UITabBar_Delegate {
        return UITabBar_Delegate()
    }
    
    public func ce_DidSelectItem(handle: (tabBar: UITabBar, item: UITabBarItem!) -> Void) -> Self {
        ce.DidSelectItem = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillBeginCustomizingItems(handle: (tabBar: UITabBar, items: [AnyObject]) -> Void) -> Self {
        ce.WillBeginCustomizingItems = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidBeginCustomizingItems(handle: (tabBar: UITabBar, items: [AnyObject]) -> Void) -> Self {
        ce.DidBeginCustomizingItems = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillEndCustomizingItems(handle: (tabBar: UITabBar, items: [AnyObject], changed: Bool) -> Void) -> Self {
        ce.WillEndCustomizingItems = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndCustomizingItems(handle: (tabBar: UITabBar, items: [AnyObject], changed: Bool) -> Void) -> Self {
        ce.DidEndCustomizingItems = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UITabBar_Delegate: NSObject, UITabBarDelegate {
    
    var DidSelectItem: ((UITabBar, UITabBarItem!) -> Void)?
    var WillBeginCustomizingItems: ((UITabBar, [AnyObject]) -> Void)?
    var DidBeginCustomizingItems: ((UITabBar, [AnyObject]) -> Void)?
    var WillEndCustomizingItems: ((UITabBar, [AnyObject], Bool) -> Void)?
    var DidEndCustomizingItems: ((UITabBar, [AnyObject], Bool) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "tabBar:didSelectItem:" : DidSelectItem,
            "tabBar:willBeginCustomizingItems:" : WillBeginCustomizingItems,
            "tabBar:didBeginCustomizingItems:" : DidBeginCustomizingItems,
            "tabBar:willEndCustomizingItems:changed:" : WillEndCustomizingItems,
            "tabBar:didEndCustomizingItems:changed:" : DidEndCustomizingItems,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        DidSelectItem!(tabBar, item)
    }
    @objc func tabBar(tabBar: UITabBar, willBeginCustomizingItems items: [AnyObject]) {
        WillBeginCustomizingItems!(tabBar, items)
    }
    @objc func tabBar(tabBar: UITabBar, didBeginCustomizingItems items: [AnyObject]) {
        DidBeginCustomizingItems!(tabBar, items)
    }
    @objc func tabBar(tabBar: UITabBar, willEndCustomizingItems items: [AnyObject], changed: Bool) {
        WillEndCustomizingItems!(tabBar, items, changed)
    }
    @objc func tabBar(tabBar: UITabBar, didEndCustomizingItems items: [AnyObject], changed: Bool) {
        DidEndCustomizingItems!(tabBar, items, changed)
    }
}
