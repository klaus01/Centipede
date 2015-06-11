//
//  CE_CAAnimation.swift
//  Centipede
//
//  Created by kelei on 2015/6/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import QuartzCore

public extension CAAnimation {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: CAAnimation_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? CAAnimation_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
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
    
    public func ce_didStart(handle: (anim: CAAnimation) -> Void) -> Self {
        ce._didStart = handle
        rebindingDelegate()
        return self
    }
    public func ce_didStop(handle: (anim: CAAnimation, flag: Bool) -> Void) -> Self {
        ce._didStop = handle
        rebindingDelegate()
        return self
    }
    
}

internal class CAAnimation_Delegate: NSObject {
    
    var _didStart: ((CAAnimation) -> Void)?
    var _didStop: ((CAAnimation, Bool) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "animationDidStart:" : _didStart,
            "animationDidStop:finished:" : _didStop,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc override func animationDidStart(anim: CAAnimation) {
        super.animationDidStart(anim)
        _didStart!(anim)
    }
    @objc override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        super.animationDidStop(anim, finished: flag)
        _didStop!(anim, flag)
    }
}
