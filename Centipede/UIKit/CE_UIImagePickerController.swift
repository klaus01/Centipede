//
//  CE_UIImagePickerController.swift
//  Centipede
//
//  Created by kelei on 2016/9/14.
//  Copyright (c) 2016年 kelei. All rights reserved.
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
        if let obj: AnyObject = self.delegate {
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
    
    public func ce_imagePickerController_didFinishPickingMediaWithInfo(handle: @escaping (UIImagePickerController, [String : Any]) -> Void) -> Self {
        ce._imagePickerController_didFinishPickingMediaWithInfo = handle
        rebindingDelegate()
        return self
    }
    public func ce_imagePickerControllerDidCancel(handle: @escaping (UIImagePickerController) -> Void) -> Self {
        ce._imagePickerControllerDidCancel = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIImagePickerController_Delegate: UINavigationController_Delegate, UIImagePickerControllerDelegate {
    
    var _imagePickerController_didFinishPickingMediaWithInfo: ((UIImagePickerController, [String : Any]) -> Void)?
    var _imagePickerControllerDidCancel: ((UIImagePickerController) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(imagePickerController(_:didFinishPickingMediaWithInfo:)) : _imagePickerController_didFinishPickingMediaWithInfo,
            #selector(imagePickerControllerDidCancel(_:)) : _imagePickerControllerDidCancel,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        _imagePickerController_didFinishPickingMediaWithInfo!(picker, info)
    }
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        _imagePickerControllerDidCancel!(picker)
    }
}
