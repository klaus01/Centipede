//
//  CE_UIImagePickerController.swift
//  Centipede
//
//  Created by kelei on 15/4/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import Foundation
import UIKit


extension UIImagePickerController {
    
    private var ce: UIImagePickerController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIImagePickerController_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UIImagePickerController_Delegate {
                return delegate as! UIImagePickerController_Delegate
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
    
    internal override func getDelegateInstance() -> UIImagePickerController_Delegate {
        return UIImagePickerController_Delegate()
    }
    
    public func ce_DidFinishPickingMediaWithInfo(handle: (picker: UIImagePickerController, info: [NSObject : AnyObject]) -> Void) -> Self {
        ce.DidFinishPickingMediaWithInfo = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidCancel(handle: (picker: UIImagePickerController) -> Void) -> Self {
        ce.DidCancel = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIImagePickerController_Delegate: UINavigationController_Delegate, UIImagePickerControllerDelegate {
    
    var DidFinishPickingMediaWithInfo: ((UIImagePickerController, [NSObject : AnyObject]) -> Void)?
    var DidCancel: ((UIImagePickerController) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "imagePickerController:didFinishPickingMediaWithInfo:" : DidFinishPickingMediaWithInfo,
            "imagePickerControllerDidCancel:" : DidCancel,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        DidFinishPickingMediaWithInfo!(picker, info)
    }
    @objc func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        DidCancel!(picker)
    }
}