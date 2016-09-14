//
//  CE_UITextView.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension UITextView {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UITextView_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UITextView_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UITextView_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is UITextView_Delegate {
                return obj as! UITextView_Delegate
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
    
    internal override func getDelegateInstance() -> UITextView_Delegate {
        return UITextView_Delegate()
    }
    
    @discardableResult
    public func ce_textViewShouldBeginEditing(handle: @escaping (UITextView) -> Bool) -> Self {
        ce._textViewShouldBeginEditing = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_textViewShouldEndEditing(handle: @escaping (UITextView) -> Bool) -> Self {
        ce._textViewShouldEndEditing = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_textViewDidBeginEditing(handle: @escaping (UITextView) -> Void) -> Self {
        ce._textViewDidBeginEditing = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_textViewDidEndEditing(handle: @escaping (UITextView) -> Void) -> Self {
        ce._textViewDidEndEditing = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_textView_shouldChangeTextIn(handle: @escaping (UITextView, NSRange, String) -> Bool) -> Self {
        ce._textView_shouldChangeTextIn = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_textViewDidChange(handle: @escaping (UITextView) -> Void) -> Self {
        ce._textViewDidChange = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_textViewDidChangeSelection(handle: @escaping (UITextView) -> Void) -> Self {
        ce._textViewDidChangeSelection = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UITextView_Delegate: UIScrollView_Delegate, UITextViewDelegate {
    
    var _textViewShouldBeginEditing: ((UITextView) -> Bool)?
    var _textViewShouldEndEditing: ((UITextView) -> Bool)?
    var _textViewDidBeginEditing: ((UITextView) -> Void)?
    var _textViewDidEndEditing: ((UITextView) -> Void)?
    var _textView_shouldChangeTextIn: ((UITextView, NSRange, String) -> Bool)?
    var _textViewDidChange: ((UITextView) -> Void)?
    var _textViewDidChangeSelection: ((UITextView) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(textViewShouldBeginEditing(_:)) : _textViewShouldBeginEditing,
            #selector(textViewShouldEndEditing(_:)) : _textViewShouldEndEditing,
            #selector(textViewDidBeginEditing(_:)) : _textViewDidBeginEditing,
            #selector(textViewDidEndEditing(_:)) : _textViewDidEndEditing,
            #selector(textView(_:shouldChangeTextIn:replacementText:)) : _textView_shouldChangeTextIn,
            #selector(textViewDidChange(_:)) : _textViewDidChange,
            #selector(textViewDidChangeSelection(_:)) : _textViewDidChangeSelection,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return _textViewShouldBeginEditing!(textView)
    }
    @objc func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return _textViewShouldEndEditing!(textView)
    }
    @objc func textViewDidBeginEditing(_ textView: UITextView) {
        _textViewDidBeginEditing!(textView)
    }
    @objc func textViewDidEndEditing(_ textView: UITextView) {
        _textViewDidEndEditing!(textView)
    }
    @objc func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return _textView_shouldChangeTextIn!(textView, range, text)
    }
    @objc func textViewDidChange(_ textView: UITextView) {
        _textViewDidChange!(textView)
    }
    @objc func textViewDidChangeSelection(_ textView: UITextView) {
        _textViewDidChangeSelection!(textView)
    }
}
