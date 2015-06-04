//
//  CE_UIGestureRecognizer.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UIGestureRecognizer {
    
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
    
    public func ce_shouldBegin(handle: (gestureRecognizer: UIGestureRecognizer) -> Bool) -> Self {
        ce._shouldBegin = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldRecognizeSimultaneouslyWithGestureRecognizer(handle: (gestureRecognizer: UIGestureRecognizer, otherGestureRecognizer: UIGestureRecognizer) -> Bool) -> Self {
        ce._shouldRecognizeSimultaneouslyWithGestureRecognizer = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldRequireFailureOfGestureRecognizer(handle: (gestureRecognizer: UIGestureRecognizer, otherGestureRecognizer: UIGestureRecognizer) -> Bool) -> Self {
        ce._shouldRequireFailureOfGestureRecognizer = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldBeRequiredToFailByGestureRecognizer(handle: (gestureRecognizer: UIGestureRecognizer, otherGestureRecognizer: UIGestureRecognizer) -> Bool) -> Self {
        ce._shouldBeRequiredToFailByGestureRecognizer = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldReceiveTouch(handle: (gestureRecognizer: UIGestureRecognizer, touch: UITouch) -> Bool) -> Self {
        ce._shouldReceiveTouch = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIGestureRecognizer_Delegate: NSObject, UIGestureRecognizerDelegate {
    
    var _shouldBegin: ((UIGestureRecognizer) -> Bool)?
    var _shouldRecognizeSimultaneouslyWithGestureRecognizer: ((UIGestureRecognizer, UIGestureRecognizer) -> Bool)?
    var _shouldRequireFailureOfGestureRecognizer: ((UIGestureRecognizer, UIGestureRecognizer) -> Bool)?
    var _shouldBeRequiredToFailByGestureRecognizer: ((UIGestureRecognizer, UIGestureRecognizer) -> Bool)?
    var _shouldReceiveTouch: ((UIGestureRecognizer, UITouch) -> Bool)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "gestureRecognizerShouldBegin:" : _shouldBegin,
            "gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:" : _shouldRecognizeSimultaneouslyWithGestureRecognizer,
            "gestureRecognizer:shouldRequireFailureOfGestureRecognizer:" : _shouldRequireFailureOfGestureRecognizer,
            "gestureRecognizer:shouldBeRequiredToFailByGestureRecognizer:" : _shouldBeRequiredToFailByGestureRecognizer,
            "gestureRecognizer:shouldReceiveTouch:" : _shouldReceiveTouch,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return _shouldBegin!(gestureRecognizer)
    }
    @objc func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return _shouldRecognizeSimultaneouslyWithGestureRecognizer!(gestureRecognizer, otherGestureRecognizer)
    }
    @objc func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOfGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return _shouldRequireFailureOfGestureRecognizer!(gestureRecognizer, otherGestureRecognizer)
    }
    @objc func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return _shouldBeRequiredToFailByGestureRecognizer!(gestureRecognizer, otherGestureRecognizer)
    }
    @objc func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return _shouldReceiveTouch!(gestureRecognizer, touch)
    }
}
