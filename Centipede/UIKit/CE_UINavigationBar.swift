//
//  CE_UINavigationBar.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension UINavigationBar {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UINavigationBar_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UINavigationBar_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UINavigationBar_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
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
    
    public func ce_navigationBar(handle: ((UINavigationBar, UINavigationItem) -> Bool)) -> Self {
        ce._navigationBar = handle
        rebindingDelegate()
        return self
    }
    public func ce_navigationBar_didPush(handle: ((UINavigationBar, UINavigationItem) -> Void)) -> Self {
        ce._navigationBar_didPush = handle
        rebindingDelegate()
        return self
    }
    public func ce_navigationBar_shouldPop(handle: ((UINavigationBar, UINavigationItem) -> Bool)) -> Self {
        ce._navigationBar_shouldPop = handle
        rebindingDelegate()
        return self
    }
    public func ce_navigationBar_didPop(handle: ((UINavigationBar, UINavigationItem) -> Void)) -> Self {
        ce._navigationBar_didPop = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UINavigationBar_Delegate: NSObject, UINavigationBarDelegate {
    
    var _navigationBar: ((UINavigationBar, UINavigationItem) -> Bool)?
    var _navigationBar_didPush: ((UINavigationBar, UINavigationItem) -> Void)?
    var _navigationBar_shouldPop: ((UINavigationBar, UINavigationItem) -> Bool)?
    var _navigationBar_didPop: ((UINavigationBar, UINavigationItem) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(navigationBar(_:shouldPush:)) : _navigationBar,
            #selector(navigationBar(_:didPush:)) : _navigationBar_didPush,
            #selector(navigationBar(_:shouldPop:)) : _navigationBar_shouldPop,
            #selector(navigationBar(_:didPop:)) : _navigationBar_didPop,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        return _navigationBar!(navigationBar, item)
    }
    @objc func navigationBar(_ navigationBar: UINavigationBar, didPush item: UINavigationItem) {
        _navigationBar_didPush!(navigationBar, item)
    }
    @objc func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        return _navigationBar_shouldPop!(navigationBar, item)
    }
    @objc func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem) {
        _navigationBar_didPop!(navigationBar, item)
    }
}
