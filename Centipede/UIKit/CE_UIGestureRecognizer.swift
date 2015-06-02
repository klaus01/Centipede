//
//  CE_UIGestureRecognizer.swift
//  Centipede
//
//  Created by kelei on 15/5/24.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UIGestureRecognizer {
    
    private var ce: UIGestureRecognizer_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIGestureRecognizer_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UIGestureRecognizer_Delegate {
                return delegate as! UIGestureRecognizer_Delegate
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
    
    internal func getDelegateInstance() -> UIGestureRecognizer_Delegate {
        return UIGestureRecognizer_Delegate()
    }
    
    public func ce_ShouldBegin(handle: (gestureRecognizer: UIGestureRecognizer) -> Bool) -> Self {
        ce.ShouldBegin = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldRecognizeSimultaneouslyWithGestureRecognizer(handle: (gestureRecognizer: UIGestureRecognizer, otherGestureRecognizer: UIGestureRecognizer) -> Bool) -> Self {
        ce.ShouldRecognizeSimultaneouslyWithGestureRecognizer = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldRequireFailureOfGestureRecognizer(handle: (gestureRecognizer: UIGestureRecognizer, otherGestureRecognizer: UIGestureRecognizer) -> Bool) -> Self {
        ce.ShouldRequireFailureOfGestureRecognizer = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldBeRequiredToFailByGestureRecognizer(handle: (gestureRecognizer: UIGestureRecognizer, otherGestureRecognizer: UIGestureRecognizer) -> Bool) -> Self {
        ce.ShouldBeRequiredToFailByGestureRecognizer = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldReceiveTouch(handle: (gestureRecognizer: UIGestureRecognizer, touch: UITouch) -> Bool) -> Self {
        ce.ShouldReceiveTouch = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIGestureRecognizer_Delegate: NSObject, UIGestureRecognizerDelegate {
    
    var ShouldBegin: ((UIGestureRecognizer) -> Bool)?
    var ShouldRecognizeSimultaneouslyWithGestureRecognizer: ((UIGestureRecognizer, UIGestureRecognizer) -> Bool)?
    var ShouldRequireFailureOfGestureRecognizer: ((UIGestureRecognizer, UIGestureRecognizer) -> Bool)?
    var ShouldBeRequiredToFailByGestureRecognizer: ((UIGestureRecognizer, UIGestureRecognizer) -> Bool)?
    var ShouldReceiveTouch: ((UIGestureRecognizer, UITouch) -> Bool)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "gestureRecognizerShouldBegin:" : ShouldBegin,
            "gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:" : ShouldRecognizeSimultaneouslyWithGestureRecognizer,
            "gestureRecognizer:shouldRequireFailureOfGestureRecognizer:" : ShouldRequireFailureOfGestureRecognizer,
            "gestureRecognizer:shouldBeRequiredToFailByGestureRecognizer:" : ShouldBeRequiredToFailByGestureRecognizer,
            "gestureRecognizer:shouldReceiveTouch:" : ShouldReceiveTouch,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return ShouldBegin!(gestureRecognizer)
    }
    @objc func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return ShouldRecognizeSimultaneouslyWithGestureRecognizer!(gestureRecognizer, otherGestureRecognizer)
    }
    @objc func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOfGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return ShouldRequireFailureOfGestureRecognizer!(gestureRecognizer, otherGestureRecognizer)
    }
    @objc func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return ShouldBeRequiredToFailByGestureRecognizer!(gestureRecognizer, otherGestureRecognizer)
    }
    @objc func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return ShouldReceiveTouch!(gestureRecognizer, touch)
    }
}