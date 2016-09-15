//
//  CE_UIDocumentPickerViewController.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

extension UIDocumentPickerViewController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIDocumentPickerViewController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIDocumentPickerViewController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIDocumentPickerViewController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
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
    
    @discardableResult
    public func ce_documentPicker_didPickDocumentAt(handle: @escaping (UIDocumentPickerViewController, URL) -> Void) -> Self {
        ce._documentPicker_didPickDocumentAt = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_documentPickerWasCancelled(handle: @escaping (UIDocumentPickerViewController) -> Void) -> Self {
        ce._documentPickerWasCancelled = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIDocumentPickerViewController_Delegate: UIViewController_Delegate, UIDocumentPickerDelegate {
    
    var _documentPicker_didPickDocumentAt: ((UIDocumentPickerViewController, URL) -> Void)?
    var _documentPickerWasCancelled: ((UIDocumentPickerViewController) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(documentPicker(_:didPickDocumentAt:)) : _documentPicker_didPickDocumentAt,
            #selector(documentPickerWasCancelled(_:)) : _documentPickerWasCancelled,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        _documentPicker_didPickDocumentAt!(controller, url)
    }
    @objc func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        _documentPickerWasCancelled!(controller)
    }
}
