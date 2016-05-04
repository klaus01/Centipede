//
//  CE_EKEventViewController.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import EventKitUI

public extension EKEventViewController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: EKEventViewController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? EKEventViewController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: EKEventViewController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is EKEventViewController_Delegate {
                return obj as! EKEventViewController_Delegate
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
    
    internal override func getDelegateInstance() -> EKEventViewController_Delegate {
        return EKEventViewController_Delegate()
    }
    
    public func ce_didCompleteWithAction(handle: (controller: EKEventViewController, action: EKEventViewAction) -> Void) -> Self {
        ce._didCompleteWithAction = handle
        rebindingDelegate()
        return self
    }
    
}

internal class EKEventViewController_Delegate: UIViewController_Delegate, EKEventViewDelegate {
    
    var _didCompleteWithAction: ((EKEventViewController, EKEventViewAction) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(eventViewController(_:didCompleteWithAction:)) : _didCompleteWithAction,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func eventViewController(controller: EKEventViewController, didCompleteWithAction action: EKEventViewAction) {
        _didCompleteWithAction!(controller, action)
    }
}
