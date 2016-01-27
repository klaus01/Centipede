//
//  CE_UIDocumentMenuViewController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UIDocumentMenuViewController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIDocumentMenuViewController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIDocumentMenuViewController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIDocumentMenuViewController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is UIDocumentMenuViewController_Delegate {
                return obj as! UIDocumentMenuViewController_Delegate
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
        self.transitioningDelegate = nil
        self.transitioningDelegate = delegate
    }
    
    internal override func getDelegateInstance() -> UIDocumentMenuViewController_Delegate {
        return UIDocumentMenuViewController_Delegate()
    }
    
    public func ce_documentMenu(handle: (documentMenu: UIDocumentMenuViewController, documentPicker: UIDocumentPickerViewController) -> Void) -> Self {
        ce._documentMenu = handle
        rebindingDelegate()
        return self
    }
    public func ce_documentMenuWasCancelled(handle: (documentMenu: UIDocumentMenuViewController) -> Void) -> Self {
        ce._documentMenuWasCancelled = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIDocumentMenuViewController_Delegate: UIViewController_Delegate, UIDocumentMenuDelegate {
    
    var _documentMenu: ((UIDocumentMenuViewController, UIDocumentPickerViewController) -> Void)?
    var _documentMenuWasCancelled: ((UIDocumentMenuViewController) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "documentMenu:didPickDocumentPicker:" : _documentMenu,
            "documentMenuWasCancelled:" : _documentMenuWasCancelled,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func documentMenu(documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        _documentMenu!(documentMenu, documentPicker)
    }
    @objc func documentMenuWasCancelled(documentMenu: UIDocumentMenuViewController) {
        _documentMenuWasCancelled!(documentMenu)
    }
}
