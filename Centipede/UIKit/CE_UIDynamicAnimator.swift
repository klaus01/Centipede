//
//  CE_UIDynamicAnimator.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

extension UIDynamicAnimator {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIDynamicAnimator_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIDynamicAnimator_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIDynamicAnimator_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
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
    
    @discardableResult
    public func ce_dynamicAnimatorWillResume(handle: @escaping (UIDynamicAnimator) -> Void) -> Self {
        ce._dynamicAnimatorWillResume = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_dynamicAnimatorDidPause(handle: @escaping (UIDynamicAnimator) -> Void) -> Self {
        ce._dynamicAnimatorDidPause = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIDynamicAnimator_Delegate: NSObject, UIDynamicAnimatorDelegate {
    
    var _dynamicAnimatorWillResume: ((UIDynamicAnimator) -> Void)?
    var _dynamicAnimatorDidPause: ((UIDynamicAnimator) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(dynamicAnimatorWillResume(_:)) : _dynamicAnimatorWillResume,
            #selector(dynamicAnimatorDidPause(_:)) : _dynamicAnimatorDidPause,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func dynamicAnimatorWillResume(_ animator: UIDynamicAnimator) {
        _dynamicAnimatorWillResume!(animator)
    }
    @objc func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        _dynamicAnimatorDidPause!(animator)
    }
}
