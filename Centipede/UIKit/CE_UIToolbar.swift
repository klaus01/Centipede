//
//  CE_UIToolbar.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension UIToolbar {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIToolbar_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIToolbar_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIToolbar_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is UIToolbar_Delegate {
                return obj as! UIToolbar_Delegate
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
    
    internal func getDelegateInstance() -> UIToolbar_Delegate {
        return UIToolbar_Delegate()
    }
    
    public func ce_position_for(handle: ((UIBarPositioning) -> UIBarPosition)) -> Self {
        ce._position_for = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIToolbar_Delegate: NSObject, UIToolbarDelegate {
    
    var _position_for: ((UIBarPositioning) -> UIBarPosition)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(position(for:)) : _position_for,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func position(for bar: UIBarPositioning) -> UIBarPosition {
        return _position_for!(bar)
    }
}
