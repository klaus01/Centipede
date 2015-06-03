//
//  CE_UIDocumentInteractionController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UIDocumentInteractionController {
    
    private var ce: UIDocumentInteractionController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIDocumentInteractionController_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UIDocumentInteractionController_Delegate {
                return delegate as! UIDocumentInteractionController_Delegate
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
    
    internal func getDelegateInstance() -> UIDocumentInteractionController_Delegate {
        return UIDocumentInteractionController_Delegate()
    }
    
    public func ce_ViewControllerForPreview(handle: (controller: UIDocumentInteractionController) -> UIViewController) -> Self {
        ce.ViewControllerForPreview = handle
        rebindingDelegate()
        return self
    }
    public func ce_RectForPreview(handle: (controller: UIDocumentInteractionController) -> CGRect) -> Self {
        ce.RectForPreview = handle
        rebindingDelegate()
        return self
    }
    public func ce_ViewForPreview(handle: (controller: UIDocumentInteractionController) -> UIView?) -> Self {
        ce.ViewForPreview = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillBeginPreview(handle: (controller: UIDocumentInteractionController) -> Void) -> Self {
        ce.WillBeginPreview = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndPreview(handle: (controller: UIDocumentInteractionController) -> Void) -> Self {
        ce.DidEndPreview = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillPresentOptionsMenu(handle: (controller: UIDocumentInteractionController) -> Void) -> Self {
        ce.WillPresentOptionsMenu = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidDismissOptionsMenu(handle: (controller: UIDocumentInteractionController) -> Void) -> Self {
        ce.DidDismissOptionsMenu = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillPresentOpenInMenu(handle: (controller: UIDocumentInteractionController) -> Void) -> Self {
        ce.WillPresentOpenInMenu = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidDismissOpenInMenu(handle: (controller: UIDocumentInteractionController) -> Void) -> Self {
        ce.DidDismissOpenInMenu = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillBeginSendingToApplication(handle: (controller: UIDocumentInteractionController, application: String) -> Void) -> Self {
        ce.WillBeginSendingToApplication = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndSendingToApplication(handle: (controller: UIDocumentInteractionController, application: String) -> Void) -> Self {
        ce.DidEndSendingToApplication = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIDocumentInteractionController_Delegate: NSObject, UIDocumentInteractionControllerDelegate {
    
    var ViewControllerForPreview: ((UIDocumentInteractionController) -> UIViewController)?
    var RectForPreview: ((UIDocumentInteractionController) -> CGRect)?
    var ViewForPreview: ((UIDocumentInteractionController) -> UIView?)?
    var WillBeginPreview: ((UIDocumentInteractionController) -> Void)?
    var DidEndPreview: ((UIDocumentInteractionController) -> Void)?
    var WillPresentOptionsMenu: ((UIDocumentInteractionController) -> Void)?
    var DidDismissOptionsMenu: ((UIDocumentInteractionController) -> Void)?
    var WillPresentOpenInMenu: ((UIDocumentInteractionController) -> Void)?
    var DidDismissOpenInMenu: ((UIDocumentInteractionController) -> Void)?
    var WillBeginSendingToApplication: ((UIDocumentInteractionController, String) -> Void)?
    var DidEndSendingToApplication: ((UIDocumentInteractionController, String) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "documentInteractionControllerViewControllerForPreview:" : ViewControllerForPreview,
            "documentInteractionControllerRectForPreview:" : RectForPreview,
            "documentInteractionControllerViewForPreview:" : ViewForPreview,
            "documentInteractionControllerWillBeginPreview:" : WillBeginPreview,
            "documentInteractionControllerDidEndPreview:" : DidEndPreview,
            "documentInteractionControllerWillPresentOptionsMenu:" : WillPresentOptionsMenu,
            "documentInteractionControllerDidDismissOptionsMenu:" : DidDismissOptionsMenu,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "documentInteractionControllerWillPresentOpenInMenu:" : WillPresentOpenInMenu,
            "documentInteractionControllerDidDismissOpenInMenu:" : DidDismissOpenInMenu,
            "documentInteractionController:willBeginSendingToApplication:" : WillBeginSendingToApplication,
            "documentInteractionController:didEndSendingToApplication:" : DidEndSendingToApplication,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController) -> UIViewController {
        return ViewControllerForPreview!(controller)
    }
    @objc func documentInteractionControllerRectForPreview(controller: UIDocumentInteractionController) -> CGRect {
        return RectForPreview!(controller)
    }
    @objc func documentInteractionControllerViewForPreview(controller: UIDocumentInteractionController) -> UIView? {
        return ViewForPreview!(controller)
    }
    @objc func documentInteractionControllerWillBeginPreview(controller: UIDocumentInteractionController) {
        WillBeginPreview!(controller)
    }
    @objc func documentInteractionControllerDidEndPreview(controller: UIDocumentInteractionController) {
        DidEndPreview!(controller)
    }
    @objc func documentInteractionControllerWillPresentOptionsMenu(controller: UIDocumentInteractionController) {
        WillPresentOptionsMenu!(controller)
    }
    @objc func documentInteractionControllerDidDismissOptionsMenu(controller: UIDocumentInteractionController) {
        DidDismissOptionsMenu!(controller)
    }
    @objc func documentInteractionControllerWillPresentOpenInMenu(controller: UIDocumentInteractionController) {
        WillPresentOpenInMenu!(controller)
    }
    @objc func documentInteractionControllerDidDismissOpenInMenu(controller: UIDocumentInteractionController) {
        DidDismissOpenInMenu!(controller)
    }
    @objc func documentInteractionController(controller: UIDocumentInteractionController, willBeginSendingToApplication application: String) {
        WillBeginSendingToApplication!(controller, application)
    }
    @objc func documentInteractionController(controller: UIDocumentInteractionController, didEndSendingToApplication application: String) {
        DidEndSendingToApplication!(controller, application)
    }
}
