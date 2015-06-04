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
    
    public func ce_documentPicker(handle: (controller: UIDocumentPickerViewController, url: NSURL) -> Void) -> Self {
        ce._documentPicker = handle
        rebindingDelegate()
        return self
    }
    public func ce_documentPickerWasCancelled(handle: (controller: UIDocumentPickerViewController) -> Void) -> Self {
        ce._documentPickerWasCancelled = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIDocumentPickerViewController_Delegate: UIViewController_Delegate, UIDocumentPickerDelegate {
    
    var _documentPicker: ((UIDocumentPickerViewController, NSURL) -> Void)?
    var _documentPickerWasCancelled: ((UIDocumentPickerViewController) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "documentPicker:didPickDocumentAtURL:" : _documentPicker,
            "documentPickerWasCancelled:" : _documentPickerWasCancelled,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func documentPicker(controller: UIDocumentPickerViewController, didPickDocumentAtURL url: NSURL) {
        _documentPicker!(controller, url)
    }
    @objc func documentPickerWasCancelled(controller: UIDocumentPickerViewController) {
        _documentPickerWasCancelled!(controller)
    }
}
