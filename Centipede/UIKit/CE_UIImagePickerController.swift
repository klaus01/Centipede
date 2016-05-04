//
//  CE_UIImagePickerController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UIImagePickerController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIImagePickerController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIImagePickerController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIImagePickerController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is UIImagePickerController_Delegate {
                return obj as! UIImagePickerController_Delegate
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
    
    internal override func getDelegateInstance() -> UIImagePickerController_Delegate {
        return UIImagePickerController_Delegate()
    }
    
    public func ce_didFinishPickingMediaWithInfo(handle: (picker: UIImagePickerController, info: [String : AnyObject]) -> Void) -> Self {
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
    
    var _didFinishPickingMediaWithInfo: ((UIImagePickerController, [String : AnyObject]) -> Void)?
    var _didCancel: ((UIImagePickerController) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(imagePickerController(_:didFinishPickingMediaWithInfo:)) : _didFinishPickingMediaWithInfo,
            #selector(imagePickerControllerDidCancel(_:)) : _didCancel,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        _didFinishPickingMediaWithInfo!(picker, info)
    }
    @objc func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        _didCancel!(picker)
    }
}
