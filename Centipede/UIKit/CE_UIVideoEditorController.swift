//
//  CE_UIVideoEditorController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UIVideoEditorController {
    
    private var ce: UIVideoEditorController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIVideoEditorController_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UIVideoEditorController_Delegate {
                return delegate as! UIVideoEditorController_Delegate
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
    
    internal override func getDelegateInstance() -> UIVideoEditorController_Delegate {
        return UIVideoEditorController_Delegate()
    }
    
    public func ce_DidSaveEditedVideoToPath(handle: (editor: UIVideoEditorController, editedVideoPath: String) -> Void) -> Self {
        ce.DidSaveEditedVideoToPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidFailWithError(handle: (editor: UIVideoEditorController, error: NSError) -> Void) -> Self {
        ce.DidFailWithError = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidCancel(handle: (editor: UIVideoEditorController) -> Void) -> Self {
        ce.DidCancel = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIVideoEditorController_Delegate: UINavigationController_Delegate, UIVideoEditorControllerDelegate {
    
    var DidSaveEditedVideoToPath: ((UIVideoEditorController, String) -> Void)?
    var DidFailWithError: ((UIVideoEditorController, NSError) -> Void)?
    var DidCancel: ((UIVideoEditorController) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "videoEditorController:didSaveEditedVideoToPath:" : DidSaveEditedVideoToPath,
            "videoEditorController:didFailWithError:" : DidFailWithError,
            "videoEditorControllerDidCancel:" : DidCancel,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func videoEditorController(editor: UIVideoEditorController, didSaveEditedVideoToPath editedVideoPath: String) {
        DidSaveEditedVideoToPath!(editor, editedVideoPath)
    }
    @objc func videoEditorController(editor: UIVideoEditorController, didFailWithError error: NSError) {
        DidFailWithError!(editor, error)
    }
    @objc func videoEditorControllerDidCancel(editor: UIVideoEditorController) {
        DidCancel!(editor)
    }
}
