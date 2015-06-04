//
//  CE_UIActionSheet.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UIActionSheet {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIActionSheet_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIActionSheet_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: UIActionSheet_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is UIActionSheet_Delegate {
                return obj as! UIActionSheet_Delegate
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
    
    internal func getDelegateInstance() -> UIActionSheet_Delegate {
        return UIActionSheet_Delegate()
    }
    
    public convenience init(title: String?, cancelButtonTitle: String?, destructiveButtonTitle: String?, otherButtonTitles firstButtonTitle: String, _ moreButtonTitles: String...) {
        self.init(title: title, cancelButtonTitle: cancelButtonTitle, destructiveButtonTitle: destructiveButtonTitle)
        addButtonWithTitle(firstButtonTitle)
        
        for buttonTitle in moreButtonTitles {
            addButtonWithTitle(buttonTitle)
        }
    }
    
    public convenience init(title: String?, cancelButtonTitle: String?, destructiveButtonTitle: String?) {
        let obj = UIActionSheet_Delegate()
        self.init(title: title, delegate: obj, cancelButtonTitle: cancelButtonTitle, destructiveButtonTitle: destructiveButtonTitle)
        _delegate = obj
    }
    
    public func ce_clickedButtonAtIndex(handle: (actionSheet: UIActionSheet, buttonIndex: Int) -> Void) -> Self {
        ce._clickedButtonAtIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_cancel(handle: (actionSheet: UIActionSheet) -> Void) -> Self {
        ce._cancel = handle
        rebindingDelegate()
        return self
    }
    public func ce_willPresent(handle: (actionSheet: UIActionSheet) -> Void) -> Self {
        ce._willPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_didPresent(handle: (actionSheet: UIActionSheet) -> Void) -> Self {
        ce._didPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_willDismissWithButtonIndex(handle: (actionSheet: UIActionSheet, buttonIndex: Int) -> Void) -> Self {
        ce._willDismissWithButtonIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDismissWithButtonIndex(handle: (actionSheet: UIActionSheet, buttonIndex: Int) -> Void) -> Self {
        ce._didDismissWithButtonIndex = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIActionSheet_Delegate: NSObject, UIActionSheetDelegate {
    
    var _clickedButtonAtIndex: ((UIActionSheet, Int) -> Void)?
    var _cancel: ((UIActionSheet) -> Void)?
    var _willPresent: ((UIActionSheet) -> Void)?
    var _didPresent: ((UIActionSheet) -> Void)?
    var _willDismissWithButtonIndex: ((UIActionSheet, Int) -> Void)?
    var _didDismissWithButtonIndex: ((UIActionSheet, Int) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "actionSheet:clickedButtonAtIndex:" : _clickedButtonAtIndex,
            "actionSheetCancel:" : _cancel,
            "willPresentActionSheet:" : _willPresent,
            "didPresentActionSheet:" : _didPresent,
            "actionSheet:willDismissWithButtonIndex:" : _willDismissWithButtonIndex,
            "actionSheet:didDismissWithButtonIndex:" : _didDismissWithButtonIndex,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        _clickedButtonAtIndex!(actionSheet, buttonIndex)
    }
    @objc func actionSheetCancel(actionSheet: UIActionSheet) {
        _cancel!(actionSheet)
    }
    @objc func willPresentActionSheet(actionSheet: UIActionSheet) {
        _willPresent!(actionSheet)
    }
    @objc func didPresentActionSheet(actionSheet: UIActionSheet) {
        _didPresent!(actionSheet)
    }
    @objc func actionSheet(actionSheet: UIActionSheet, willDismissWithButtonIndex buttonIndex: Int) {
        _willDismissWithButtonIndex!(actionSheet, buttonIndex)
    }
    @objc func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        _didDismissWithButtonIndex!(actionSheet, buttonIndex)
    }
}
