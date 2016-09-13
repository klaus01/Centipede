//
//  CE_CAAnimation.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import QuartzCore

public extension CAAnimation {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: CAAnimation_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? CAAnimation_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: CAAnimation_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is CAAnimation_Delegate {
                return obj as! CAAnimation_Delegate
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
    
    internal func getDelegateInstance() -> CAAnimation_Delegate {
        return CAAnimation_Delegate()
    }
    
    public func ce_animationDidStart(handle: ((CAAnimation) -> Void)) -> Self {
        ce._animationDidStart = handle
        rebindingDelegate()
        return self
    }
    public func ce_animationDidStop(handle: ((CAAnimation, Bool) -> Void)) -> Self {
        ce._animationDidStop = handle
        rebindingDelegate()
        return self
    }
    
}

internal class CAAnimation_Delegate: NSObject, CAAnimationDelegate {
    
    var _animationDidStart: ((CAAnimation) -> Void)?
    var _animationDidStop: ((CAAnimation, Bool) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(animationDidStart(_:)) : _animationDidStart,
            #selector(animationDidStop(_:finished:)) : _animationDidStop,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func animationDidStart(_ anim: CAAnimation) {
        _animationDidStart!(anim)
    }
    @objc func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        _animationDidStop!(anim, flag)
    }
}
