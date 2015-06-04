//
//  CE_UIAlertView.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UIAlertView {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIAlertView_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIAlertView_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: UIAlertView_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is UIAlertView_Delegate {
                return obj as! UIAlertView_Delegate
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
    
    internal func getDelegateInstance() -> UIAlertView_Delegate {
        return UIAlertView_Delegate()
    }
    
    public convenience init(title: String?, message: String?, cancelButtonTitle: String?, otherButtonTitles firstButtonTitle: String, _ moreButtonTitles: String...) {
        self.init(title: title, message: message, cancelButtonTitle: cancelButtonTitle)
        addButtonWithTitle(firstButtonTitle)
        
        for buttonTitle in moreButtonTitles {
            addButtonWithTitle(buttonTitle)
        }
    }
    
    public convenience init(title: String?, message: String?, cancelButtonTitle: String?) {
        let obj = UIAlertView_Delegate()
        self.init(title: title, message: message, delegate: obj, cancelButtonTitle: cancelButtonTitle)
        _delegate = obj
    }
    
    public func ce_clickedButtonAtIndex(handle: (alertView: UIAlertView, buttonIndex: Int) -> Void) -> Self {
        ce._clickedButtonAtIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_cancel(handle: (alertView: UIAlertView) -> Void) -> Self {
        ce._cancel = handle
        rebindingDelegate()
        return self
    }
    public func ce_willPresent(handle: (alertView: UIAlertView) -> Void) -> Self {
        ce._willPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_didPresent(handle: (alertView: UIAlertView) -> Void) -> Self {
        ce._didPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_willDismissWithButtonIndex(handle: (alertView: UIAlertView, buttonIndex: Int) -> Void) -> Self {
        ce._willDismissWithButtonIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDismissWithButtonIndex(handle: (alertView: UIAlertView, buttonIndex: Int) -> Void) -> Self {
        ce._didDismissWithButtonIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldEnableFirstOtherButton(handle: (alertView: UIAlertView) -> Bool) -> Self {
        ce._shouldEnableFirstOtherButton = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIAlertView_Delegate: NSObject, UIAlertViewDelegate {
    
    var _clickedButtonAtIndex: ((UIAlertView, Int) -> Void)?
    var _cancel: ((UIAlertView) -> Void)?
    var _willPresent: ((UIAlertView) -> Void)?
    var _didPresent: ((UIAlertView) -> Void)?
    var _willDismissWithButtonIndex: ((UIAlertView, Int) -> Void)?
    var _didDismissWithButtonIndex: ((UIAlertView, Int) -> Void)?
    var _shouldEnableFirstOtherButton: ((UIAlertView) -> Bool)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "alertView:clickedButtonAtIndex:" : _clickedButtonAtIndex,
            "alertViewCancel:" : _cancel,
            "willPresentAlertView:" : _willPresent,
            "didPresentAlertView:" : _didPresent,
            "alertView:willDismissWithButtonIndex:" : _willDismissWithButtonIndex,
            "alertView:didDismissWithButtonIndex:" : _didDismissWithButtonIndex,
            "alertViewShouldEnableFirstOtherButton:" : _shouldEnableFirstOtherButton,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        _clickedButtonAtIndex!(alertView, buttonIndex)
    }
    @objc func alertViewCancel(alertView: UIAlertView) {
        _cancel!(alertView)
    }
    @objc func willPresentAlertView(alertView: UIAlertView) {
        _willPresent!(alertView)
    }
    @objc func didPresentAlertView(alertView: UIAlertView) {
        _didPresent!(alertView)
    }
    @objc func alertView(alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) {
        _willDismissWithButtonIndex!(alertView, buttonIndex)
    }
    @objc func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        _didDismissWithButtonIndex!(alertView, buttonIndex)
    }
    @objc func alertViewShouldEnableFirstOtherButton(alertView: UIAlertView) -> Bool {
        return _shouldEnableFirstOtherButton!(alertView)
    }
}
