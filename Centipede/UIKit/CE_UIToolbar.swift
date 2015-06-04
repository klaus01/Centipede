//
//  CE_UIToolbar.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UIToolbar {
    
    private var ce: UIToolbar_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIToolbar_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UIToolbar_Delegate {
                return delegate as! UIToolbar_Delegate
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
    
    internal func getDelegateInstance() -> UIToolbar_Delegate {
        return UIToolbar_Delegate()
    }
    
    public func ce_positionForBar(handle: (bar: UIBarPositioning) -> UIBarPosition) -> Self {
        ce._positionForBar = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIToolbar_Delegate: NSObject, UIToolbarDelegate {
    
    var _positionForBar: ((UIBarPositioning) -> UIBarPosition)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "positionForBar:" : _positionForBar,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return _positionForBar!(bar)
    }
}
