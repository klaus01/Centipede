//
//  CE_UIAlertView.swift
//  Centipede
//
//  Created by kelei on 2016/9/14.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension UIAlertView {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIAlertView_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIAlertView_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
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
    
    public func ce_alertView_clickedButtonAt(handle: @escaping (UIAlertView, Int) -> Void) -> Self {
        ce._alertView_clickedButtonAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_alertViewCancel(handle: @escaping (UIAlertView) -> Void) -> Self {
        ce._alertViewCancel = handle
        rebindingDelegate()
        return self
    }
    public func ce_willPresent(handle: @escaping (UIAlertView) -> Void) -> Self {
        ce._willPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_didPresent(handle: @escaping (UIAlertView) -> Void) -> Self {
        ce._didPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_alertView_willDismissWithButtonIndex(handle: @escaping (UIAlertView, Int) -> Void) -> Self {
        ce._alertView_willDismissWithButtonIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_alertView_didDismissWithButtonIndex(handle: @escaping (UIAlertView, Int) -> Void) -> Self {
        ce._alertView_didDismissWithButtonIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_alertViewShouldEnableFirstOtherButton(handle: @escaping (UIAlertView) -> Bool) -> Self {
        ce._alertViewShouldEnableFirstOtherButton = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIAlertView_Delegate: NSObject, UIAlertViewDelegate {
    
    var _alertView_clickedButtonAt: ((UIAlertView, Int) -> Void)?
    var _alertViewCancel: ((UIAlertView) -> Void)?
    var _willPresent: ((UIAlertView) -> Void)?
    var _didPresent: ((UIAlertView) -> Void)?
    var _alertView_willDismissWithButtonIndex: ((UIAlertView, Int) -> Void)?
    var _alertView_didDismissWithButtonIndex: ((UIAlertView, Int) -> Void)?
    var _alertViewShouldEnableFirstOtherButton: ((UIAlertView) -> Bool)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(alertView(_:clickedButtonAt:)) : _alertView_clickedButtonAt,
            #selector(alertViewCancel(_:)) : _alertViewCancel,
            #selector(willPresent(_:)) : _willPresent,
            #selector(didPresent(_:)) : _didPresent,
            #selector(alertView(_:willDismissWithButtonIndex:)) : _alertView_willDismissWithButtonIndex,
            #selector(alertView(_:didDismissWithButtonIndex:)) : _alertView_didDismissWithButtonIndex,
            #selector(alertViewShouldEnableFirstOtherButton(_:)) : _alertViewShouldEnableFirstOtherButton,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        _alertView_clickedButtonAt!(alertView, buttonIndex)
    }
    @objc func alertViewCancel(_ alertView: UIAlertView) {
        _alertViewCancel!(alertView)
    }
    @objc func willPresent(_ alertView: UIAlertView) {
        _willPresent!(alertView)
    }
    @objc func didPresent(_ alertView: UIAlertView) {
        _didPresent!(alertView)
    }
    @objc func alertView(_ alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) {
        _alertView_willDismissWithButtonIndex!(alertView, buttonIndex)
    }
    @objc func alertView(_ alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        _alertView_didDismissWithButtonIndex!(alertView, buttonIndex)
    }
    @objc func alertViewShouldEnableFirstOtherButton(_ alertView: UIAlertView) -> Bool {
        return _alertViewShouldEnableFirstOtherButton!(alertView)
    }
}
