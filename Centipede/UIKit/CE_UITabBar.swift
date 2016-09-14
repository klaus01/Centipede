//
//  CE_UITabBar.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
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
        if let obj: AnyObject = self.delegate {
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
    
    @discardableResult
    public func ce_tabBar_didSelect(handle: @escaping (UITabBar, UITabBarItem) -> Void) -> Self {
        ce._tabBar_didSelect = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_tabBar_willBeginCustomizing(handle: @escaping (UITabBar, [UITabBarItem]) -> Void) -> Self {
        ce._tabBar_willBeginCustomizing = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_tabBar_didBeginCustomizing(handle: @escaping (UITabBar, [UITabBarItem]) -> Void) -> Self {
        ce._tabBar_didBeginCustomizing = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_tabBar_willEndCustomizing(handle: @escaping (UITabBar, [UITabBarItem], Bool) -> Void) -> Self {
        ce._tabBar_willEndCustomizing = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_tabBar_didEndCustomizing(handle: @escaping (UITabBar, [UITabBarItem], Bool) -> Void) -> Self {
        ce._tabBar_didEndCustomizing = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UITabBar_Delegate: NSObject, UITabBarDelegate {
    
    var _tabBar_didSelect: ((UITabBar, UITabBarItem) -> Void)?
    var _tabBar_willBeginCustomizing: ((UITabBar, [UITabBarItem]) -> Void)?
    var _tabBar_didBeginCustomizing: ((UITabBar, [UITabBarItem]) -> Void)?
    var _tabBar_willEndCustomizing: ((UITabBar, [UITabBarItem], Bool) -> Void)?
    var _tabBar_didEndCustomizing: ((UITabBar, [UITabBarItem], Bool) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(tabBar(_:didSelect:)) : _tabBar_didSelect,
            #selector(tabBar(_:willBeginCustomizing:)) : _tabBar_willBeginCustomizing,
            #selector(tabBar(_:didBeginCustomizing:)) : _tabBar_didBeginCustomizing,
            #selector(tabBar(_:willEndCustomizing:changed:)) : _tabBar_willEndCustomizing,
            #selector(tabBar(_:didEndCustomizing:changed:)) : _tabBar_didEndCustomizing,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        _tabBar_didSelect!(tabBar, item)
    }
    @objc func tabBar(_ tabBar: UITabBar, willBeginCustomizing items: [UITabBarItem]) {
        _tabBar_willBeginCustomizing!(tabBar, items)
    }
    @objc func tabBar(_ tabBar: UITabBar, didBeginCustomizing items: [UITabBarItem]) {
        _tabBar_didBeginCustomizing!(tabBar, items)
    }
    @objc func tabBar(_ tabBar: UITabBar, willEndCustomizing items: [UITabBarItem], changed: Bool) {
        _tabBar_willEndCustomizing!(tabBar, items, changed)
    }
    @objc func tabBar(_ tabBar: UITabBar, didEndCustomizing items: [UITabBarItem], changed: Bool) {
        _tabBar_didEndCustomizing!(tabBar, items, changed)
    }
}
