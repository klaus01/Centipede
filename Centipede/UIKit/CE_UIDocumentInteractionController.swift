//
//  CE_UIDocumentInteractionController.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension UIDocumentInteractionController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIDocumentInteractionController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIDocumentInteractionController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIDocumentInteractionController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is UIDocumentInteractionController_Delegate {
                return obj as! UIDocumentInteractionController_Delegate
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
    
    internal func getDelegateInstance() -> UIDocumentInteractionController_Delegate {
        return UIDocumentInteractionController_Delegate()
    }
    
    public func ce_documentInteractionControllerViewControllerForPreview(handle: ((UIDocumentInteractionController) -> UIViewController)) -> Self {
        ce._documentInteractionControllerViewControllerForPreview = handle
        rebindingDelegate()
        return self
    }
    public func ce_documentInteractionControllerRectForPreview(handle: ((UIDocumentInteractionController) -> CGRect)) -> Self {
        ce._documentInteractionControllerRectForPreview = handle
        rebindingDelegate()
        return self
    }
    public func ce_documentInteractionControllerViewForPreview(handle: ((UIDocumentInteractionController) -> UIView?)) -> Self {
        ce._documentInteractionControllerViewForPreview = handle
        rebindingDelegate()
        return self
    }
    public func ce_documentInteractionControllerWillBeginPreview(handle: ((UIDocumentInteractionController) -> Void)) -> Self {
        ce._documentInteractionControllerWillBeginPreview = handle
        rebindingDelegate()
        return self
    }
    public func ce_documentInteractionControllerDidEndPreview(handle: ((UIDocumentInteractionController) -> Void)) -> Self {
        ce._documentInteractionControllerDidEndPreview = handle
        rebindingDelegate()
        return self
    }
    public func ce_documentInteractionControllerWillPresentOptionsMenu(handle: ((UIDocumentInteractionController) -> Void)) -> Self {
        ce._documentInteractionControllerWillPresentOptionsMenu = handle
        rebindingDelegate()
        return self
    }
    public func ce_documentInteractionControllerDidDismissOptionsMenu(handle: ((UIDocumentInteractionController) -> Void)) -> Self {
        ce._documentInteractionControllerDidDismissOptionsMenu = handle
        rebindingDelegate()
        return self
    }
    public func ce_documentInteractionControllerWillPresentOpenInMenu(handle: ((UIDocumentInteractionController) -> Void)) -> Self {
        ce._documentInteractionControllerWillPresentOpenInMenu = handle
        rebindingDelegate()
        return self
    }
    public func ce_documentInteractionControllerDidDismissOpenInMenu(handle: ((UIDocumentInteractionController) -> Void)) -> Self {
        ce._documentInteractionControllerDidDismissOpenInMenu = handle
        rebindingDelegate()
        return self
    }
    public func ce_documentInteractionController_willBeginSendingToApplication(handle: ((UIDocumentInteractionController, String?) -> Void)) -> Self {
        ce._documentInteractionController_willBeginSendingToApplication = handle
        rebindingDelegate()
        return self
    }
    public func ce_documentInteractionController_didEndSendingToApplication(handle: ((UIDocumentInteractionController, String?) -> Void)) -> Self {
        ce._documentInteractionController_didEndSendingToApplication = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIDocumentInteractionController_Delegate: NSObject, UIDocumentInteractionControllerDelegate {
    
    var _documentInteractionControllerViewControllerForPreview: ((UIDocumentInteractionController) -> UIViewController)?
    var _documentInteractionControllerRectForPreview: ((UIDocumentInteractionController) -> CGRect)?
    var _documentInteractionControllerViewForPreview: ((UIDocumentInteractionController) -> UIView?)?
    var _documentInteractionControllerWillBeginPreview: ((UIDocumentInteractionController) -> Void)?
    var _documentInteractionControllerDidEndPreview: ((UIDocumentInteractionController) -> Void)?
    var _documentInteractionControllerWillPresentOptionsMenu: ((UIDocumentInteractionController) -> Void)?
    var _documentInteractionControllerDidDismissOptionsMenu: ((UIDocumentInteractionController) -> Void)?
    var _documentInteractionControllerWillPresentOpenInMenu: ((UIDocumentInteractionController) -> Void)?
    var _documentInteractionControllerDidDismissOpenInMenu: ((UIDocumentInteractionController) -> Void)?
    var _documentInteractionController_willBeginSendingToApplication: ((UIDocumentInteractionController, String?) -> Void)?
    var _documentInteractionController_didEndSendingToApplication: ((UIDocumentInteractionController, String?) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(documentInteractionControllerViewControllerForPreview(_:)) : _documentInteractionControllerViewControllerForPreview,
            #selector(documentInteractionControllerRectForPreview(_:)) : _documentInteractionControllerRectForPreview,
            #selector(documentInteractionControllerViewForPreview(_:)) : _documentInteractionControllerViewForPreview,
            #selector(documentInteractionControllerWillBeginPreview(_:)) : _documentInteractionControllerWillBeginPreview,
            #selector(documentInteractionControllerDidEndPreview(_:)) : _documentInteractionControllerDidEndPreview,
            #selector(documentInteractionControllerWillPresentOptionsMenu(_:)) : _documentInteractionControllerWillPresentOptionsMenu,
            #selector(documentInteractionControllerDidDismissOptionsMenu(_:)) : _documentInteractionControllerDidDismissOptionsMenu,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(documentInteractionControllerWillPresentOpenInMenu(_:)) : _documentInteractionControllerWillPresentOpenInMenu,
            #selector(documentInteractionControllerDidDismissOpenInMenu(_:)) : _documentInteractionControllerDidDismissOpenInMenu,
            #selector(documentInteractionController(_:willBeginSendingToApplication:)) : _documentInteractionController_willBeginSendingToApplication,
            #selector(documentInteractionController(_:didEndSendingToApplication:)) : _documentInteractionController_didEndSendingToApplication,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return _documentInteractionControllerViewControllerForPreview!(controller)
    }
    @objc func documentInteractionControllerRectForPreview(_ controller: UIDocumentInteractionController) -> CGRect {
        return _documentInteractionControllerRectForPreview!(controller)
    }
    @objc func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
        return _documentInteractionControllerViewForPreview!(controller)
    }
    @objc func documentInteractionControllerWillBeginPreview(_ controller: UIDocumentInteractionController) {
        _documentInteractionControllerWillBeginPreview!(controller)
    }
    @objc func documentInteractionControllerDidEndPreview(_ controller: UIDocumentInteractionController) {
        _documentInteractionControllerDidEndPreview!(controller)
    }
    @objc func documentInteractionControllerWillPresentOptionsMenu(_ controller: UIDocumentInteractionController) {
        _documentInteractionControllerWillPresentOptionsMenu!(controller)
    }
    @objc func documentInteractionControllerDidDismissOptionsMenu(_ controller: UIDocumentInteractionController) {
        _documentInteractionControllerDidDismissOptionsMenu!(controller)
    }
    @objc func documentInteractionControllerWillPresentOpenInMenu(_ controller: UIDocumentInteractionController) {
        _documentInteractionControllerWillPresentOpenInMenu!(controller)
    }
    @objc func documentInteractionControllerDidDismissOpenInMenu(_ controller: UIDocumentInteractionController) {
        _documentInteractionControllerDidDismissOpenInMenu!(controller)
    }
    @objc func documentInteractionController(_ controller: UIDocumentInteractionController, willBeginSendingToApplication application: String?) {
        _documentInteractionController_willBeginSendingToApplication!(controller, application)
    }
    @objc func documentInteractionController(_ controller: UIDocumentInteractionController, didEndSendingToApplication application: String?) {
        _documentInteractionController_didEndSendingToApplication!(controller, application)
    }
}
