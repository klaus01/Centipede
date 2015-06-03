//
//  CE_UIActionSheet.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UIActionSheet {
    
    private var ce: UIActionSheet_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIActionSheet_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UIActionSheet_Delegate {
                return delegate as! UIActionSheet_Delegate
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
    
    internal func getDelegateInstance() -> UIActionSheet_Delegate {
        return UIActionSheet_Delegate()
    }
    
    public func ce_ClickedButtonAtIndex(handle: (actionSheet: UIActionSheet, buttonIndex: Int) -> Void) -> Self {
        ce.ClickedButtonAtIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_Cancel(handle: (actionSheet: UIActionSheet) -> Void) -> Self {
        ce.Cancel = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillPresent(handle: (actionSheet: UIActionSheet) -> Void) -> Self {
        ce.WillPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidPresent(handle: (actionSheet: UIActionSheet) -> Void) -> Self {
        ce.DidPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillDismissWithButtonIndex(handle: (actionSheet: UIActionSheet, buttonIndex: Int) -> Void) -> Self {
        ce.WillDismissWithButtonIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidDismissWithButtonIndex(handle: (actionSheet: UIActionSheet, buttonIndex: Int) -> Void) -> Self {
        ce.DidDismissWithButtonIndex = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIActionSheet_Delegate: NSObject, UIActionSheetDelegate {
    
    var ClickedButtonAtIndex: ((UIActionSheet, Int) -> Void)?
    var Cancel: ((UIActionSheet) -> Void)?
    var WillPresent: ((UIActionSheet) -> Void)?
    var DidPresent: ((UIActionSheet) -> Void)?
    var WillDismissWithButtonIndex: ((UIActionSheet, Int) -> Void)?
    var DidDismissWithButtonIndex: ((UIActionSheet, Int) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "actionSheet:clickedButtonAtIndex:" : ClickedButtonAtIndex,
            "actionSheetCancel:" : Cancel,
            "willPresentActionSheet:" : WillPresent,
            "didPresentActionSheet:" : DidPresent,
            "actionSheet:willDismissWithButtonIndex:" : WillDismissWithButtonIndex,
            "actionSheet:didDismissWithButtonIndex:" : DidDismissWithButtonIndex,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        ClickedButtonAtIndex!(actionSheet, buttonIndex)
    }
    @objc func actionSheetCancel(actionSheet: UIActionSheet) {
        Cancel!(actionSheet)
    }
    @objc func willPresentActionSheet(actionSheet: UIActionSheet) {
        WillPresent!(actionSheet)
    }
    @objc func didPresentActionSheet(actionSheet: UIActionSheet) {
        DidPresent!(actionSheet)
    }
    @objc func actionSheet(actionSheet: UIActionSheet, willDismissWithButtonIndex buttonIndex: Int) {
        WillDismissWithButtonIndex!(actionSheet, buttonIndex)
    }
    @objc func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        DidDismissWithButtonIndex!(actionSheet, buttonIndex)
    }
}
