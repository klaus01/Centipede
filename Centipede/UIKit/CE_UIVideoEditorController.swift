//
//  CE_UIVideoEditorController.swift
//  Centipede
//
//  Created by kelei on 2016/9/14.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension UIVideoEditorController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIVideoEditorController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIVideoEditorController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIVideoEditorController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is UIVideoEditorController_Delegate {
                return obj as! UIVideoEditorController_Delegate
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
    
    internal override func getDelegateInstance() -> UIVideoEditorController_Delegate {
        return UIVideoEditorController_Delegate()
    }
    
    public func ce_videoEditorController_didSaveEditedVideoToPath(handle: @escaping (UIVideoEditorController, String) -> Void) -> Self {
        ce._videoEditorController_didSaveEditedVideoToPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_videoEditorController_didFailWithError(handle: @escaping (UIVideoEditorController, Error) -> Void) -> Self {
        ce._videoEditorController_didFailWithError = handle
        rebindingDelegate()
        return self
    }
    public func ce_videoEditorControllerDidCancel(handle: @escaping (UIVideoEditorController) -> Void) -> Self {
        ce._videoEditorControllerDidCancel = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIVideoEditorController_Delegate: UINavigationController_Delegate, UIVideoEditorControllerDelegate {
    
    var _videoEditorController_didSaveEditedVideoToPath: ((UIVideoEditorController, String) -> Void)?
    var _videoEditorController_didFailWithError: ((UIVideoEditorController, Error) -> Void)?
    var _videoEditorControllerDidCancel: ((UIVideoEditorController) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(videoEditorController(_:didSaveEditedVideoToPath:)) : _videoEditorController_didSaveEditedVideoToPath,
            #selector(videoEditorController(_:didFailWithError:)) : _videoEditorController_didFailWithError,
            #selector(videoEditorControllerDidCancel(_:)) : _videoEditorControllerDidCancel,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func videoEditorController(_ editor: UIVideoEditorController, didSaveEditedVideoToPath editedVideoPath: String) {
        _videoEditorController_didSaveEditedVideoToPath!(editor, editedVideoPath)
    }
    @objc func videoEditorController(_ editor: UIVideoEditorController, didFailWithError error: Error) {
        _videoEditorController_didFailWithError!(editor, error)
    }
    @objc func videoEditorControllerDidCancel(_ editor: UIVideoEditorController) {
        _videoEditorControllerDidCancel!(editor)
    }
}
