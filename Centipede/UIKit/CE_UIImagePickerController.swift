//
//  CE_UIImagePickerController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

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
    
    public func ce_didFinishPickingMediaWithInfo(handle: (picker: UIImagePickerController, info: [NSObject : AnyObject]) -> Void) -> Self {
        ce._didFinishPickingMediaWithInfo = handle
        rebindingDelegate()
        return self
    }
    public func ce_didCancel(handle: (picker: UIImagePickerController) -> Void) -> Self {
        ce._didCancel = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIImagePickerController_Delegate: UINavigationController_Delegate, UIImagePickerControllerDelegate {
    
    var _didFinishPickingMediaWithInfo: ((UIImagePickerController, [NSObject : AnyObject]) -> Void)?
    var _didCancel: ((UIImagePickerController) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "imagePickerController:didFinishPickingMediaWithInfo:" : _didFinishPickingMediaWithInfo,
            "imagePickerControllerDidCancel:" : _didCancel,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        _didFinishPickingMediaWithInfo!(picker, info)
    }
    @objc func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        _didCancel!(picker)
    }
}
