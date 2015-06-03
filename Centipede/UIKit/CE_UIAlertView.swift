//
//  CE_UIAlertView.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UIAlertView {
    
    private var ce: UIAlertView_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIAlertView_Delegate {
            return obj
        }
        if let delegate: AnyObject = self.delegate {
            if delegate is UIAlertView_Delegate {
                return delegate as! UIAlertView_Delegate
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
    
    internal func getDelegateInstance() -> UIAlertView_Delegate {
        return UIAlertView_Delegate()
    }
    
    public func ce_ClickedButtonAtIndex(handle: (alertView: UIAlertView, buttonIndex: Int) -> Void) -> Self {
        ce.ClickedButtonAtIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_Cancel(handle: (alertView: UIAlertView) -> Void) -> Self {
        ce.Cancel = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillPresent(handle: (alertView: UIAlertView) -> Void) -> Self {
        ce.WillPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidPresent(handle: (alertView: UIAlertView) -> Void) -> Self {
        ce.DidPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillDismissWithButtonIndex(handle: (alertView: UIAlertView, buttonIndex: Int) -> Void) -> Self {
        ce.WillDismissWithButtonIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidDismissWithButtonIndex(handle: (alertView: UIAlertView, buttonIndex: Int) -> Void) -> Self {
        ce.DidDismissWithButtonIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldEnableFirstOtherButton(handle: (alertView: UIAlertView) -> Bool) -> Self {
        ce.ShouldEnableFirstOtherButton = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIAlertView_Delegate: NSObject, UIAlertViewDelegate {
    
    var ClickedButtonAtIndex: ((UIAlertView, Int) -> Void)?
    var Cancel: ((UIAlertView) -> Void)?
    var WillPresent: ((UIAlertView) -> Void)?
    var DidPresent: ((UIAlertView) -> Void)?
    var WillDismissWithButtonIndex: ((UIAlertView, Int) -> Void)?
    var DidDismissWithButtonIndex: ((UIAlertView, Int) -> Void)?
    var ShouldEnableFirstOtherButton: ((UIAlertView) -> Bool)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "alertView:clickedButtonAtIndex:" : ClickedButtonAtIndex,
            "alertViewCancel:" : Cancel,
            "willPresentAlertView:" : WillPresent,
            "didPresentAlertView:" : DidPresent,
            "alertView:willDismissWithButtonIndex:" : WillDismissWithButtonIndex,
            "alertView:didDismissWithButtonIndex:" : DidDismissWithButtonIndex,
            "alertViewShouldEnableFirstOtherButton:" : ShouldEnableFirstOtherButton,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        ClickedButtonAtIndex!(alertView, buttonIndex)
    }
    @objc func alertViewCancel(alertView: UIAlertView) {
        Cancel!(alertView)
    }
    @objc func willPresentAlertView(alertView: UIAlertView) {
        WillPresent!(alertView)
    }
    @objc func didPresentAlertView(alertView: UIAlertView) {
        DidPresent!(alertView)
    }
    @objc func alertView(alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) {
        WillDismissWithButtonIndex!(alertView, buttonIndex)
    }
    @objc func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        DidDismissWithButtonIndex!(alertView, buttonIndex)
    }
    @objc func alertViewShouldEnableFirstOtherButton(alertView: UIAlertView) -> Bool {
        return ShouldEnableFirstOtherButton!(alertView)
    }
}
