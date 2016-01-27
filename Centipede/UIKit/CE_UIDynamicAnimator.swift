//
//  CE_UIDynamicAnimator.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UIDynamicAnimator {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIDynamicAnimator_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIDynamicAnimator_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIDynamicAnimator_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is UIDynamicAnimator_Delegate {
                return obj as! UIDynamicAnimator_Delegate
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
    
    internal func getDelegateInstance() -> UIDynamicAnimator_Delegate {
        return UIDynamicAnimator_Delegate()
    }
    
    public func ce_willResume(handle: (animator: UIDynamicAnimator) -> Void) -> Self {
        ce._willResume = handle
        rebindingDelegate()
        return self
    }
    public func ce_didPause(handle: (animator: UIDynamicAnimator) -> Void) -> Self {
        ce._didPause = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIDynamicAnimator_Delegate: NSObject, UIDynamicAnimatorDelegate {
    
    var _willResume: ((UIDynamicAnimator) -> Void)?
    var _didPause: ((UIDynamicAnimator) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "dynamicAnimatorWillResume:" : _willResume,
            "dynamicAnimatorDidPause:" : _didPause,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func dynamicAnimatorWillResume(animator: UIDynamicAnimator) {
        _willResume!(animator)
    }
    @objc func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        _didPause!(animator)
    }
}
