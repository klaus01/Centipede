//
//  CE_UIPopoverPresentationController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UIPopoverPresentationController {
    
    private var ce: UIPopoverPresentationController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIPopoverPresentationController_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UIPopoverPresentationController_Delegate {
                return delegate as! UIPopoverPresentationController_Delegate
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
    
    internal override func getDelegateInstance() -> UIPopoverPresentationController_Delegate {
        return UIPopoverPresentationController_Delegate()
    }
    
    public func ce_PrepareForPopoverPresentation(handle: (popoverPresentationController: UIPopoverPresentationController) -> Void) -> Self {
        ce.PrepareForPopoverPresentation = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldDismissPopover(handle: (popoverPresentationController: UIPopoverPresentationController) -> Bool) -> Self {
        ce.ShouldDismissPopover = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidDismissPopover(handle: (popoverPresentationController: UIPopoverPresentationController) -> Void) -> Self {
        ce.DidDismissPopover = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillRepositionPopoverToRect(handle: (popoverPresentationController: UIPopoverPresentationController, rect: UnsafeMutablePointer<CGRect>, view: AutoreleasingUnsafeMutablePointer<UIView?>) -> Void) -> Self {
        ce.WillRepositionPopoverToRect = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPopoverPresentationController_Delegate: UIPresentationController_Delegate, UIPopoverPresentationControllerDelegate {
    
    var PrepareForPopoverPresentation: ((UIPopoverPresentationController) -> Void)?
    var ShouldDismissPopover: ((UIPopoverPresentationController) -> Bool)?
    var DidDismissPopover: ((UIPopoverPresentationController) -> Void)?
    var WillRepositionPopoverToRect: ((UIPopoverPresentationController, UnsafeMutablePointer<CGRect>, AutoreleasingUnsafeMutablePointer<UIView?>) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "prepareForPopoverPresentation:" : PrepareForPopoverPresentation,
            "popoverPresentationControllerShouldDismissPopover:" : ShouldDismissPopover,
            "popoverPresentationControllerDidDismissPopover:" : DidDismissPopover,
            "popoverPresentationController:willRepositionPopoverToRect:inView:" : WillRepositionPopoverToRect,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func prepareForPopoverPresentation(popoverPresentationController: UIPopoverPresentationController) {
        PrepareForPopoverPresentation!(popoverPresentationController)
    }
    @objc func popoverPresentationControllerShouldDismissPopover(popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return ShouldDismissPopover!(popoverPresentationController)
    }
    @objc func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        DidDismissPopover!(popoverPresentationController)
    }
    @objc func popoverPresentationController(popoverPresentationController: UIPopoverPresentationController, willRepositionPopoverToRect rect: UnsafeMutablePointer<CGRect>, inView view: AutoreleasingUnsafeMutablePointer<UIView?>) {
        WillRepositionPopoverToRect!(popoverPresentationController, rect, view)
    }
}
