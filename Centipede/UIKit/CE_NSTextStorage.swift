//
//  CE_NSTextStorage.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

extension NSTextStorage {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NSTextStorage_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NSTextStorage_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: NSTextStorage_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is NSTextStorage_Delegate {
                return obj as! NSTextStorage_Delegate
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
    
    internal func getDelegateInstance() -> NSTextStorage_Delegate {
        return NSTextStorage_Delegate()
    }
    
    @discardableResult
    public func ce_textStorage_willProcessEditing(handle: @escaping (NSTextStorage, NSTextStorageEditActions, NSRange, Int) -> Void) -> Self {
        ce._textStorage_willProcessEditing = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_textStorage_didProcessEditing(handle: @escaping (NSTextStorage, NSTextStorageEditActions, NSRange, Int) -> Void) -> Self {
        ce._textStorage_didProcessEditing = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSTextStorage_Delegate: NSObject, NSTextStorageDelegate {
    
    var _textStorage_willProcessEditing: ((NSTextStorage, NSTextStorageEditActions, NSRange, Int) -> Void)?
    var _textStorage_didProcessEditing: ((NSTextStorage, NSTextStorageEditActions, NSRange, Int) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(textStorage(_:willProcessEditing:range:changeInLength:)) : _textStorage_willProcessEditing,
            #selector(textStorage(_:didProcessEditing:range:changeInLength:)) : _textStorage_didProcessEditing,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func textStorage(_ textStorage: NSTextStorage, willProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
        _textStorage_willProcessEditing!(textStorage, editedMask, editedRange, delta)
    }
    @objc func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
        _textStorage_didProcessEditing!(textStorage, editedMask, editedRange, delta)
    }
}
