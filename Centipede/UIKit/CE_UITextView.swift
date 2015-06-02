//
//  CE_UITextView.swift
//  Centipede
//
//  Created by kelei on 15/5/5.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    
    private var ce: UITextView_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UITextView_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UITextView_Delegate {
                return delegate as! UITextView_Delegate
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
    
    internal override func getDelegateInstance() -> UITextView_Delegate {
        return UITextView_Delegate()
    }
    
    public func ce_ShouldBeginEditing(handle: (textView: UITextView) -> Bool) -> Self {
        ce.ShouldBeginEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldEndEditing(handle: (textView: UITextView) -> Bool) -> Self {
        ce.ShouldEndEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidBeginEditing(handle: (textView: UITextView) -> Void) -> Self {
        ce.DidBeginEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndEditing(handle: (textView: UITextView) -> Void) -> Self {
        ce.DidEndEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldChangeTextInRange(handle: (textView: UITextView, range: NSRange, text: String) -> Bool) -> Self {
        ce.ShouldChangeTextInRange = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidChange(handle: (textView: UITextView) -> Void) -> Self {
        ce.DidChange = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidChangeSelection(handle: (textView: UITextView) -> Void) -> Self {
        ce.DidChangeSelection = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldInteractWithURL(handle: (textView: UITextView, URL: NSURL, characterRange: NSRange) -> Bool) -> Self {
        ce.ShouldInteractWithURL = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldInteractWithTextAttachment(handle: (textView: UITextView, textAttachment: NSTextAttachment, characterRange: NSRange) -> Bool) -> Self {
        ce.ShouldInteractWithTextAttachment = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UITextView_Delegate: UIScrollView_Delegate, UITextViewDelegate {
    
    var ShouldBeginEditing: ((UITextView) -> Bool)?
    var ShouldEndEditing: ((UITextView) -> Bool)?
    var DidBeginEditing: ((UITextView) -> Void)?
    var DidEndEditing: ((UITextView) -> Void)?
    var ShouldChangeTextInRange: ((UITextView, NSRange, String) -> Bool)?
    var DidChange: ((UITextView) -> Void)?
    var DidChangeSelection: ((UITextView) -> Void)?
    var ShouldInteractWithURL: ((UITextView, NSURL, NSRange) -> Bool)?
    var ShouldInteractWithTextAttachment: ((UITextView, NSTextAttachment, NSRange) -> Bool)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "textViewShouldBeginEditing:" : ShouldBeginEditing,
            "textViewShouldEndEditing:" : ShouldEndEditing,
            "textViewDidBeginEditing:" : DidBeginEditing,
            "textViewDidEndEditing:" : DidEndEditing,
            "textView:shouldChangeTextInRange:replacementText:" : ShouldChangeTextInRange,
            "textViewDidChange:" : DidChange,
            "textViewDidChangeSelection:" : DidChangeSelection,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "textView:shouldInteractWithURL:inRange:" : ShouldInteractWithURL,
            "textView:shouldInteractWithTextAttachment:inRange:" : ShouldInteractWithTextAttachment,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return ShouldBeginEditing!(textView)
    }
    @objc func textViewShouldEndEditing(textView: UITextView) -> Bool {
        return ShouldEndEditing!(textView)
    }
    @objc func textViewDidBeginEditing(textView: UITextView) {
        DidBeginEditing!(textView)
    }
    @objc func textViewDidEndEditing(textView: UITextView) {
        DidEndEditing!(textView)
    }
    @objc func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return ShouldChangeTextInRange!(textView, range, text)
    }
    @objc func textViewDidChange(textView: UITextView) {
        DidChange!(textView)
    }
    @objc func textViewDidChangeSelection(textView: UITextView) {
        DidChangeSelection!(textView)
    }
    @objc func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        return ShouldInteractWithURL!(textView, URL, characterRange)
    }
    @objc func textView(textView: UITextView, shouldInteractWithTextAttachment textAttachment: NSTextAttachment, inRange characterRange: NSRange) -> Bool {
        return ShouldInteractWithTextAttachment!(textView, textAttachment, characterRange)
    }
}