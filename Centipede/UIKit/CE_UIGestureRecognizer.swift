//
//  CE_UIGestureRecognizer.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension UIGestureRecognizer {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIGestureRecognizer_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIGestureRecognizer_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIGestureRecognizer_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is UIGestureRecognizer_Delegate {
                return obj as! UIGestureRecognizer_Delegate
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
    
    internal func getDelegateInstance() -> UIGestureRecognizer_Delegate {
        return UIGestureRecognizer_Delegate()
    }
    
    @discardableResult
    public func ce_gestureRecognizerShouldBegin(handle: @escaping (UIGestureRecognizer) -> Bool) -> Self {
        ce._gestureRecognizerShouldBegin = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_gestureRecognizer_shouldRecognizeSimultaneouslyWith(handle: @escaping (UIGestureRecognizer, UIGestureRecognizer) -> Bool) -> Self {
        ce._gestureRecognizer_shouldRecognizeSimultaneouslyWith = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_gestureRecognizer_shouldRequireFailureOf(handle: @escaping (UIGestureRecognizer, UIGestureRecognizer) -> Bool) -> Self {
        ce._gestureRecognizer_shouldRequireFailureOf = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_gestureRecognizer_shouldBeRequiredToFailBy(handle: @escaping (UIGestureRecognizer, UIGestureRecognizer) -> Bool) -> Self {
        ce._gestureRecognizer_shouldBeRequiredToFailBy = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_gestureRecognizer_shouldReceive(handle: @escaping (UIGestureRecognizer, UITouch) -> Bool) -> Self {
        ce._gestureRecognizer_shouldReceive = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIGestureRecognizer_Delegate: NSObject, UIGestureRecognizerDelegate {
    
    var _gestureRecognizerShouldBegin: ((UIGestureRecognizer) -> Bool)?
    var _gestureRecognizer_shouldRecognizeSimultaneouslyWith: ((UIGestureRecognizer, UIGestureRecognizer) -> Bool)?
    var _gestureRecognizer_shouldRequireFailureOf: ((UIGestureRecognizer, UIGestureRecognizer) -> Bool)?
    var _gestureRecognizer_shouldBeRequiredToFailBy: ((UIGestureRecognizer, UIGestureRecognizer) -> Bool)?
    var _gestureRecognizer_shouldReceive: ((UIGestureRecognizer, UITouch) -> Bool)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(gestureRecognizerShouldBegin(_:)) : _gestureRecognizerShouldBegin,
            #selector(gestureRecognizer(_:shouldRecognizeSimultaneouslyWith:)) : _gestureRecognizer_shouldRecognizeSimultaneouslyWith,
            #selector(gestureRecognizer(_:shouldRequireFailureOf:)) : _gestureRecognizer_shouldRequireFailureOf,
            #selector(gestureRecognizer(_:shouldBeRequiredToFailBy:)) : _gestureRecognizer_shouldBeRequiredToFailBy,
            #selector(gestureRecognizer(_:shouldReceive:)) : _gestureRecognizer_shouldReceive,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return _gestureRecognizerShouldBegin!(gestureRecognizer)
    }
    @objc func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return _gestureRecognizer_shouldRecognizeSimultaneouslyWith!(gestureRecognizer, otherGestureRecognizer)
    }
    @objc func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return _gestureRecognizer_shouldRequireFailureOf!(gestureRecognizer, otherGestureRecognizer)
    }
    @objc func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return _gestureRecognizer_shouldBeRequiredToFailBy!(gestureRecognizer, otherGestureRecognizer)
    }
    @objc func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return _gestureRecognizer_shouldReceive!(gestureRecognizer, touch)
    }
}
