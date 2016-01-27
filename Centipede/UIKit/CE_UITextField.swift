//
//  CE_UITextField.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UITextField {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UITextField_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UITextField_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UITextField_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is UITextField_Delegate {
                return obj as! UITextField_Delegate
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
    
    internal func getDelegateInstance() -> UITextField_Delegate {
        return UITextField_Delegate()
    }
    
    public func ce_shouldBeginEditing(handle: (textField: UITextField) -> Bool) -> Self {
        ce._shouldBeginEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_didBeginEditing(handle: (textField: UITextField) -> Void) -> Self {
        ce._didBeginEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldEndEditing(handle: (textField: UITextField) -> Bool) -> Self {
        ce._shouldEndEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndEditing(handle: (textField: UITextField) -> Void) -> Self {
        ce._didEndEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldChangeCharactersInRange(handle: (textField: UITextField, range: NSRange, string: String) -> Bool) -> Self {
        ce._shouldChangeCharactersInRange = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldClear(handle: (textField: UITextField) -> Bool) -> Self {
        ce._shouldClear = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldReturn(handle: (textField: UITextField) -> Bool) -> Self {
        ce._shouldReturn = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UITextField_Delegate: NSObject, UITextFieldDelegate {
    
    var _shouldBeginEditing: ((UITextField) -> Bool)?
    var _didBeginEditing: ((UITextField) -> Void)?
    var _shouldEndEditing: ((UITextField) -> Bool)?
    var _didEndEditing: ((UITextField) -> Void)?
    var _shouldChangeCharactersInRange: ((UITextField, NSRange, String) -> Bool)?
    var _shouldClear: ((UITextField) -> Bool)?
    var _shouldReturn: ((UITextField) -> Bool)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "textFieldShouldBeginEditing:" : _shouldBeginEditing,
            "textFieldDidBeginEditing:" : _didBeginEditing,
            "textFieldShouldEndEditing:" : _shouldEndEditing,
            "textFieldDidEndEditing:" : _didEndEditing,
            "textField:shouldChangeCharactersInRange:replacementString:" : _shouldChangeCharactersInRange,
            "textFieldShouldClear:" : _shouldClear,
            "textFieldShouldReturn:" : _shouldReturn,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return _shouldBeginEditing!(textField)
    }
    @objc func textFieldDidBeginEditing(textField: UITextField) {
        _didBeginEditing!(textField)
    }
    @objc func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return _shouldEndEditing!(textField)
    }
    @objc func textFieldDidEndEditing(textField: UITextField) {
        _didEndEditing!(textField)
    }
    @objc func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return _shouldChangeCharactersInRange!(textField, range, string)
    }
    @objc func textFieldShouldClear(textField: UITextField) -> Bool {
        return _shouldClear!(textField)
    }
    @objc func textFieldShouldReturn(textField: UITextField) -> Bool {
        return _shouldReturn!(textField)
    }
}
