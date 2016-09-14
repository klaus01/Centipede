//
//  CE_UIActionSheet.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension UIActionSheet {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIActionSheet_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIActionSheet_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIActionSheet_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
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
    
    @discardableResult
    public func ce_actionSheet_clickedButtonAt(handle: @escaping (UIActionSheet, Int) -> Void) -> Self {
        ce._actionSheet_clickedButtonAt = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_actionSheetCancel(handle: @escaping (UIActionSheet) -> Void) -> Self {
        ce._actionSheetCancel = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_willPresent(handle: @escaping (UIActionSheet) -> Void) -> Self {
        ce._willPresent = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_didPresent(handle: @escaping (UIActionSheet) -> Void) -> Self {
        ce._didPresent = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_actionSheet_willDismissWithButtonIndex(handle: @escaping (UIActionSheet, Int) -> Void) -> Self {
        ce._actionSheet_willDismissWithButtonIndex = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_actionSheet_didDismissWithButtonIndex(handle: @escaping (UIActionSheet, Int) -> Void) -> Self {
        ce._actionSheet_didDismissWithButtonIndex = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIActionSheet_Delegate: NSObject, UIActionSheetDelegate {
    
    var _actionSheet_clickedButtonAt: ((UIActionSheet, Int) -> Void)?
    var _actionSheetCancel: ((UIActionSheet) -> Void)?
    var _willPresent: ((UIActionSheet) -> Void)?
    var _didPresent: ((UIActionSheet) -> Void)?
    var _actionSheet_willDismissWithButtonIndex: ((UIActionSheet, Int) -> Void)?
    var _actionSheet_didDismissWithButtonIndex: ((UIActionSheet, Int) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(actionSheet(_:clickedButtonAt:)) : _actionSheet_clickedButtonAt,
            #selector(actionSheetCancel(_:)) : _actionSheetCancel,
            #selector(willPresent(_:)) : _willPresent,
            #selector(didPresent(_:)) : _didPresent,
            #selector(actionSheet(_:willDismissWithButtonIndex:)) : _actionSheet_willDismissWithButtonIndex,
            #selector(actionSheet(_:didDismissWithButtonIndex:)) : _actionSheet_didDismissWithButtonIndex,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        _actionSheet_clickedButtonAt!(actionSheet, buttonIndex)
    }
    @objc func actionSheetCancel(_ actionSheet: UIActionSheet) {
        _actionSheetCancel!(actionSheet)
    }
    @objc func willPresent(_ actionSheet: UIActionSheet) {
        _willPresent!(actionSheet)
    }
    @objc func didPresent(_ actionSheet: UIActionSheet) {
        _didPresent!(actionSheet)
    }
    @objc func actionSheet(_ actionSheet: UIActionSheet, willDismissWithButtonIndex buttonIndex: Int) {
        _actionSheet_willDismissWithButtonIndex!(actionSheet, buttonIndex)
    }
    @objc func actionSheet(_ actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        _actionSheet_didDismissWithButtonIndex!(actionSheet, buttonIndex)
    }
}
