//
//  CE_UITextField.swift
//  Centipede
//
//  Created by kelei on 2016/9/14.
//  Copyright (c) 2016年 kelei. All rights reserved.
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
        if let obj: AnyObject = self.delegate {
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
    
    public func ce_textFieldShouldBeginEditing(handle: @escaping (UITextField) -> Bool) -> Self {
        ce._textFieldShouldBeginEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_textFieldDidBeginEditing(handle: @escaping (UITextField) -> Void) -> Self {
        ce._textFieldDidBeginEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_textFieldShouldEndEditing(handle: @escaping (UITextField) -> Bool) -> Self {
        ce._textFieldShouldEndEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_textFieldDidEndEditing(handle: @escaping (UITextField) -> Void) -> Self {
        ce._textFieldDidEndEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_textField_shouldChangeCharactersIn(handle: @escaping (UITextField, NSRange, String) -> Bool) -> Self {
        ce._textField_shouldChangeCharactersIn = handle
        rebindingDelegate()
        return self
    }
    public func ce_textFieldShouldClear(handle: @escaping (UITextField) -> Bool) -> Self {
        ce._textFieldShouldClear = handle
        rebindingDelegate()
        return self
    }
    public func ce_textFieldShouldReturn(handle: @escaping (UITextField) -> Bool) -> Self {
        ce._textFieldShouldReturn = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UITextField_Delegate: NSObject, UITextFieldDelegate {
    
    var _textFieldShouldBeginEditing: ((UITextField) -> Bool)?
    var _textFieldDidBeginEditing: ((UITextField) -> Void)?
    var _textFieldShouldEndEditing: ((UITextField) -> Bool)?
    var _textFieldDidEndEditing: ((UITextField) -> Void)?
    var _textField_shouldChangeCharactersIn: ((UITextField, NSRange, String) -> Bool)?
    var _textFieldShouldClear: ((UITextField) -> Bool)?
    var _textFieldShouldReturn: ((UITextField) -> Bool)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(textFieldShouldBeginEditing(_:)) : _textFieldShouldBeginEditing,
            #selector(textFieldDidBeginEditing(_:)) : _textFieldDidBeginEditing,
            #selector(textFieldShouldEndEditing(_:)) : _textFieldShouldEndEditing,
            #selector(textFieldDidEndEditing(_:)) : _textFieldDidEndEditing,
            #selector(textField(_:shouldChangeCharactersIn:replacementString:)) : _textField_shouldChangeCharactersIn,
            #selector(textFieldShouldClear(_:)) : _textFieldShouldClear,
            #selector(textFieldShouldReturn(_:)) : _textFieldShouldReturn,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return _textFieldShouldBeginEditing!(textField)
    }
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        _textFieldDidBeginEditing!(textField)
    }
    @objc func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return _textFieldShouldEndEditing!(textField)
    }
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        _textFieldDidEndEditing!(textField)
    }
    @objc func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return _textField_shouldChangeCharactersIn!(textField, range, string)
    }
    @objc func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return _textFieldShouldClear!(textField)
    }
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return _textFieldShouldReturn!(textField)
    }
}
