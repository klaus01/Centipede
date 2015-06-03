//
//  CE_UIDocumentPickerViewController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UIDocumentPickerViewController {
    
    private var ce: UIDocumentPickerViewController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIDocumentPickerViewController_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UIDocumentPickerViewController_Delegate {
                return delegate as! UIDocumentPickerViewController_Delegate
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
    
    internal override func getDelegateInstance() -> UIDocumentPickerViewController_Delegate {
        return UIDocumentPickerViewController_Delegate()
    }
    
    public func ce_DocumentPicker(handle: (controller: UIDocumentPickerViewController, url: NSURL) -> Void) -> Self {
        ce.DocumentPicker = handle
        rebindingDelegate()
        return self
    }
    public func ce_DocumentPickerWasCancelled(handle: (controller: UIDocumentPickerViewController) -> Void) -> Self {
        ce.DocumentPickerWasCancelled = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIDocumentPickerViewController_Delegate: UIViewController_Delegate, UIDocumentPickerDelegate {
    
    var DocumentPicker: ((UIDocumentPickerViewController, NSURL) -> Void)?
    var DocumentPickerWasCancelled: ((UIDocumentPickerViewController) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "documentPicker:didPickDocumentAtURL:" : DocumentPicker,
            "documentPickerWasCancelled:" : DocumentPickerWasCancelled,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func documentPicker(controller: UIDocumentPickerViewController, didPickDocumentAtURL url: NSURL) {
        DocumentPicker!(controller, url)
    }
    @objc func documentPickerWasCancelled(controller: UIDocumentPickerViewController) {
        DocumentPickerWasCancelled!(controller)
    }
}
