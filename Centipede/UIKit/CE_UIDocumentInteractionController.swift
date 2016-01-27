//
//  CE_UIDocumentInteractionController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
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
        if let obj = self.delegate {
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
    
    public func ce_viewControllerForPreview(handle: (controller: UIDocumentInteractionController) -> UIViewController) -> Self {
        ce._viewControllerForPreview = handle
        rebindingDelegate()
        return self
    }
    public func ce_rectForPreview(handle: (controller: UIDocumentInteractionController) -> CGRect) -> Self {
        ce._rectForPreview = handle
        rebindingDelegate()
        return self
    }
    public func ce_viewForPreview(handle: (controller: UIDocumentInteractionController) -> UIView?) -> Self {
        ce._viewForPreview = handle
        rebindingDelegate()
        return self
    }
    public func ce_willBeginPreview(handle: (controller: UIDocumentInteractionController) -> Void) -> Self {
        ce._willBeginPreview = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndPreview(handle: (controller: UIDocumentInteractionController) -> Void) -> Self {
        ce._didEndPreview = handle
        rebindingDelegate()
        return self
    }
    public func ce_willPresentOptionsMenu(handle: (controller: UIDocumentInteractionController) -> Void) -> Self {
        ce._willPresentOptionsMenu = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDismissOptionsMenu(handle: (controller: UIDocumentInteractionController) -> Void) -> Self {
        ce._didDismissOptionsMenu = handle
        rebindingDelegate()
        return self
    }
    public func ce_willPresentOpenInMenu(handle: (controller: UIDocumentInteractionController) -> Void) -> Self {
        ce._willPresentOpenInMenu = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDismissOpenInMenu(handle: (controller: UIDocumentInteractionController) -> Void) -> Self {
        ce._didDismissOpenInMenu = handle
        rebindingDelegate()
        return self
    }
    public func ce_willBeginSendingToApplication(handle: (controller: UIDocumentInteractionController, application: String?) -> Void) -> Self {
        ce._willBeginSendingToApplication = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndSendingToApplication(handle: (controller: UIDocumentInteractionController, application: String?) -> Void) -> Self {
        ce._didEndSendingToApplication = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIDocumentInteractionController_Delegate: NSObject, UIDocumentInteractionControllerDelegate {
    
    var _viewControllerForPreview: ((UIDocumentInteractionController) -> UIViewController)?
    var _rectForPreview: ((UIDocumentInteractionController) -> CGRect)?
    var _viewForPreview: ((UIDocumentInteractionController) -> UIView?)?
    var _willBeginPreview: ((UIDocumentInteractionController) -> Void)?
    var _didEndPreview: ((UIDocumentInteractionController) -> Void)?
    var _willPresentOptionsMenu: ((UIDocumentInteractionController) -> Void)?
    var _didDismissOptionsMenu: ((UIDocumentInteractionController) -> Void)?
    var _willPresentOpenInMenu: ((UIDocumentInteractionController) -> Void)?
    var _didDismissOpenInMenu: ((UIDocumentInteractionController) -> Void)?
    var _willBeginSendingToApplication: ((UIDocumentInteractionController, String?) -> Void)?
    var _didEndSendingToApplication: ((UIDocumentInteractionController, String?) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "documentInteractionControllerViewControllerForPreview:" : _viewControllerForPreview,
            "documentInteractionControllerRectForPreview:" : _rectForPreview,
            "documentInteractionControllerViewForPreview:" : _viewForPreview,
            "documentInteractionControllerWillBeginPreview:" : _willBeginPreview,
            "documentInteractionControllerDidEndPreview:" : _didEndPreview,
            "documentInteractionControllerWillPresentOptionsMenu:" : _willPresentOptionsMenu,
            "documentInteractionControllerDidDismissOptionsMenu:" : _didDismissOptionsMenu,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "documentInteractionControllerWillPresentOpenInMenu:" : _willPresentOpenInMenu,
            "documentInteractionControllerDidDismissOpenInMenu:" : _didDismissOpenInMenu,
            "documentInteractionController:willBeginSendingToApplication:" : _willBeginSendingToApplication,
            "documentInteractionController:didEndSendingToApplication:" : _didEndSendingToApplication,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController) -> UIViewController {
        return _viewControllerForPreview!(controller)
    }
    @objc func documentInteractionControllerRectForPreview(controller: UIDocumentInteractionController) -> CGRect {
        return _rectForPreview!(controller)
    }
    @objc func documentInteractionControllerViewForPreview(controller: UIDocumentInteractionController) -> UIView? {
        return _viewForPreview!(controller)
    }
    @objc func documentInteractionControllerWillBeginPreview(controller: UIDocumentInteractionController) {
        _willBeginPreview!(controller)
    }
    @objc func documentInteractionControllerDidEndPreview(controller: UIDocumentInteractionController) {
        _didEndPreview!(controller)
    }
    @objc func documentInteractionControllerWillPresentOptionsMenu(controller: UIDocumentInteractionController) {
        _willPresentOptionsMenu!(controller)
    }
    @objc func documentInteractionControllerDidDismissOptionsMenu(controller: UIDocumentInteractionController) {
        _didDismissOptionsMenu!(controller)
    }
    @objc func documentInteractionControllerWillPresentOpenInMenu(controller: UIDocumentInteractionController) {
        _willPresentOpenInMenu!(controller)
    }
    @objc func documentInteractionControllerDidDismissOpenInMenu(controller: UIDocumentInteractionController) {
        _didDismissOpenInMenu!(controller)
    }
    @objc func documentInteractionController(controller: UIDocumentInteractionController, willBeginSendingToApplication application: String?) {
        _willBeginSendingToApplication!(controller, application)
    }
    @objc func documentInteractionController(controller: UIDocumentInteractionController, didEndSendingToApplication application: String?) {
        _didEndSendingToApplication!(controller, application)
    }
}
