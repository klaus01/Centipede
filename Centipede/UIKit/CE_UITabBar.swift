//
//  CE_UITabBar.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UITabBar {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UITabBar_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UITabBar_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UITabBar_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is UITabBar_Delegate {
                return obj as! UITabBar_Delegate
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
    
    internal func getDelegateInstance() -> UITabBar_Delegate {
        return UITabBar_Delegate()
    }
    
    public func ce_didSelectItem(handle: (tabBar: UITabBar, item: UITabBarItem) -> Void) -> Self {
        ce._didSelectItem = handle
        rebindingDelegate()
        return self
    }
    public func ce_willBeginCustomizingItems(handle: (tabBar: UITabBar, items: [UITabBarItem]) -> Void) -> Self {
        ce._willBeginCustomizingItems = handle
        rebindingDelegate()
        return self
    }
    public func ce_didBeginCustomizingItems(handle: (tabBar: UITabBar, items: [UITabBarItem]) -> Void) -> Self {
        ce._didBeginCustomizingItems = handle
        rebindingDelegate()
        return self
    }
    public func ce_willEndCustomizingItems(handle: (tabBar: UITabBar, items: [UITabBarItem], changed: Bool) -> Void) -> Self {
        ce._willEndCustomizingItems = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndCustomizingItems(handle: (tabBar: UITabBar, items: [UITabBarItem], changed: Bool) -> Void) -> Self {
        ce._didEndCustomizingItems = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UITabBar_Delegate: NSObject, UITabBarDelegate {
    
    var _didSelectItem: ((UITabBar, UITabBarItem) -> Void)?
    var _willBeginCustomizingItems: ((UITabBar, [UITabBarItem]) -> Void)?
    var _didBeginCustomizingItems: ((UITabBar, [UITabBarItem]) -> Void)?
    var _willEndCustomizingItems: ((UITabBar, [UITabBarItem], Bool) -> Void)?
    var _didEndCustomizingItems: ((UITabBar, [UITabBarItem], Bool) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "tabBar:didSelectItem:" : _didSelectItem,
            "tabBar:willBeginCustomizingItems:" : _willBeginCustomizingItems,
            "tabBar:didBeginCustomizingItems:" : _didBeginCustomizingItems,
            "tabBar:willEndCustomizingItems:changed:" : _willEndCustomizingItems,
            "tabBar:didEndCustomizingItems:changed:" : _didEndCustomizingItems,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        _didSelectItem!(tabBar, item)
    }
    @objc func tabBar(tabBar: UITabBar, willBeginCustomizingItems items: [UITabBarItem]) {
        _willBeginCustomizingItems!(tabBar, items)
    }
    @objc func tabBar(tabBar: UITabBar, didBeginCustomizingItems items: [UITabBarItem]) {
        _didBeginCustomizingItems!(tabBar, items)
    }
    @objc func tabBar(tabBar: UITabBar, willEndCustomizingItems items: [UITabBarItem], changed: Bool) {
        _willEndCustomizingItems!(tabBar, items, changed)
    }
    @objc func tabBar(tabBar: UITabBar, didEndCustomizingItems items: [UITabBarItem], changed: Bool) {
        _didEndCustomizingItems!(tabBar, items, changed)
    }
}
