//
//  CE_UIDocumentPickerViewController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UIDocumentPickerViewController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIDocumentPickerViewController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIDocumentPickerViewController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: UIDocumentPickerViewController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is UIDocumentPickerViewController_Delegate {
                return obj as! UIDocumentPickerViewController_Delegate
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
