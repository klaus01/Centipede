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
    
    public func ce_didSaveEditedVideoToPath(handle: (editor: UIVideoEditorController, editedVideoPath: String) -> Void) -> Self {
        ce._didSaveEditedVideoToPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFailWithError(handle: (editor: UIVideoEditorController, error: NSError) -> Void) -> Self {
        ce._didFailWithError = handle
        rebindingDelegate()
        return self
    }
    public func ce_didCancel(handle: (editor: UIVideoEditorController) -> Void) -> Self {
        ce._didCancel = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIVideoEditorController_Delegate: UINavigationController_Delegate, UIVideoEditorControllerDelegate {
    
    var _didSaveEditedVideoToPath: ((UIVideoEditorController, String) -> Void)?
    var _didFailWithError: ((UIVideoEditorController, NSError) -> Void)?
    var _didCancel: ((UIVideoEditorController) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "videoEditorController:didSaveEditedVideoToPath:" : _didSaveEditedVideoToPath,
            "videoEditorController:didFailWithError:" : _didFailWithError,
            "videoEditorControllerDidCancel:" : _didCancel,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func videoEditorController(editor: UIVideoEditorController, didSaveEditedVideoToPath editedVideoPath: String) {
        _didSaveEditedVideoToPath!(editor, editedVideoPath)
    }
    @objc func videoEditorController(editor: UIVideoEditorController, didFailWithError error: NSError) {
        _didFailWithError!(editor, error)
    }
    @objc func videoEditorControllerDidCancel(editor: UIVideoEditorController) {
        _didCancel!(editor)
    }
}
