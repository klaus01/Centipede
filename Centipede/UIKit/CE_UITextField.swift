//
//  CE_UITextField.swift
//  Centipede
//
//  Created by kelei on 15/4/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UITextField {
    
    private var ce: UITextField_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UITextField_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UITextField_Delegate {
                return delegate as! UITextField_Delegate
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
    
    internal func getDelegateInstance() -> UITextField_Delegate {
        return UITextField_Delegate()
    }
    
    public func ce_ShouldBeginEditing(handle: (textField: UITextField) -> Bool) -> Self {
        ce.ShouldBeginEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidBeginEditing(handle: (textField: UITextField) -> Void) -> Self {
        ce.DidBeginEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldEndEditing(handle: (textField: UITextField) -> Bool) -> Self {
        ce.ShouldEndEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndEditing(handle: (textField: UITextField) -> Void) -> Self {
        ce.DidEndEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldChangeCharactersInRange(handle: (textField: UITextField, range: NSRange, string: String) -> Bool) -> Self {
        ce.ShouldChangeCharactersInRange = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldClear(handle: (textField: UITextField) -> Bool) -> Self {
        ce.ShouldClear = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldReturn(handle: (textField: UITextField) -> Bool) -> Self {
        ce.ShouldReturn = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UITextField_Delegate: NSObject, UITextFieldDelegate {
    
    var ShouldBeginEditing: ((UITextField) -> Bool)?
    var DidBeginEditing: ((UITextField) -> Void)?
    var ShouldEndEditing: ((UITextField) -> Bool)?
    var DidEndEditing: ((UITextField) -> Void)?
    var ShouldChangeCharactersInRange: ((UITextField, NSRange, String) -> Bool)?
    var ShouldClear: ((UITextField) -> Bool)?
    var ShouldReturn: ((UITextField) -> Bool)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "textFieldShouldBeginEditing:" : ShouldBeginEditing,
            "textFieldDidBeginEditing:" : DidBeginEditing,
            "textFieldShouldEndEditing:" : ShouldEndEditing,
            "textFieldDidEndEditing:" : DidEndEditing,
            "textField:shouldChangeCharactersInRange:replacementString:" : ShouldChangeCharactersInRange,
            "textFieldShouldClear:" : ShouldClear,
            "textFieldShouldReturn:" : ShouldReturn,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return ShouldBeginEditing!(textField)
    }
    @objc func textFieldDidBeginEditing(textField: UITextField) {
        DidBeginEditing!(textField)
    }
    @objc func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return ShouldEndEditing!(textField)
    }
    @objc func textFieldDidEndEditing(textField: UITextField) {
        DidEndEditing!(textField)
    }
    @objc func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return ShouldChangeCharactersInRange!(textField, range, string)
    }
    @objc func textFieldShouldClear(textField: UITextField) -> Bool {
        return ShouldClear!(textField)
    }
    @objc func textFieldShouldReturn(textField: UITextField) -> Bool {
        return ShouldReturn!(textField)
    }
}
