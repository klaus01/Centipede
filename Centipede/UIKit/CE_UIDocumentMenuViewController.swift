//
//  CE_UIDocumentMenuViewController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UIDocumentMenuViewController {
    
    private var ce: UIDocumentMenuViewController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIDocumentMenuViewController_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UIDocumentMenuViewController_Delegate {
                return delegate as! UIDocumentMenuViewController_Delegate
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
        self.transitioningDelegate = nil
        self.transitioningDelegate = delegate
    }
    
    internal override func getDelegateInstance() -> UIDocumentMenuViewController_Delegate {
        return UIDocumentMenuViewController_Delegate()
    }
    
    public func ce_DocumentMenu(handle: (documentMenu: UIDocumentMenuViewController, documentPicker: UIDocumentPickerViewController) -> Void) -> Self {
        ce.DocumentMenu = handle
        rebindingDelegate()
        return self
    }
    public func ce_DocumentMenuWasCancelled(handle: (documentMenu: UIDocumentMenuViewController) -> Void) -> Self {
        ce.DocumentMenuWasCancelled = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIDocumentMenuViewController_Delegate: UIViewController_Delegate, UIDocumentMenuDelegate {
    
    var DocumentMenu: ((UIDocumentMenuViewController, UIDocumentPickerViewController) -> Void)?
    var DocumentMenuWasCancelled: ((UIDocumentMenuViewController) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "documentMenu:didPickDocumentPicker:" : DocumentMenu,
            "documentMenuWasCancelled:" : DocumentMenuWasCancelled,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func documentMenu(documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        DocumentMenu!(documentMenu, documentPicker)
    }
    @objc func documentMenuWasCancelled(documentMenu: UIDocumentMenuViewController) {
        DocumentMenuWasCancelled!(documentMenu)
    }
}
