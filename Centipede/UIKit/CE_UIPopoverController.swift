//
//  CE_UIPopoverController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UIPopoverController {
    
    private var ce: UIPopoverController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIPopoverController_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UIPopoverController_Delegate {
                return delegate as! UIPopoverController_Delegate
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
    
    internal func getDelegateInstance() -> UIPopoverController_Delegate {
        return UIPopoverController_Delegate()
    }
    
    public func ce_ShouldDismissPopover(handle: (popoverController: UIPopoverController) -> Bool) -> Self {
        ce.ShouldDismissPopover = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidDismissPopover(handle: (popoverController: UIPopoverController) -> Void) -> Self {
        ce.DidDismissPopover = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillRepositionPopoverToRect(handle: (popoverController: UIPopoverController, rect: UnsafeMutablePointer<CGRect>, view: AutoreleasingUnsafeMutablePointer<UIView?>) -> Void) -> Self {
        ce.WillRepositionPopoverToRect = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPopoverController_Delegate: NSObject, UIPopoverControllerDelegate {
    
    var ShouldDismissPopover: ((UIPopoverController) -> Bool)?
    var DidDismissPopover: ((UIPopoverController) -> Void)?
    var WillRepositionPopoverToRect: ((UIPopoverController, UnsafeMutablePointer<CGRect>, AutoreleasingUnsafeMutablePointer<UIView?>) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "popoverControllerShouldDismissPopover:" : ShouldDismissPopover,
            "popoverControllerDidDismissPopover:" : DidDismissPopover,
            "popoverController:willRepositionPopoverToRect:inView:" : WillRepositionPopoverToRect,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func popoverControllerShouldDismissPopover(popoverController: UIPopoverController) -> Bool {
        return ShouldDismissPopover!(popoverController)
    }
    @objc func popoverControllerDidDismissPopover(popoverController: UIPopoverController) {
        DidDismissPopover!(popoverController)
    }
    @objc func popoverController(popoverController: UIPopoverController, willRepositionPopoverToRect rect: UnsafeMutablePointer<CGRect>, inView view: AutoreleasingUnsafeMutablePointer<UIView?>) {
        WillRepositionPopoverToRect!(popoverController, rect, view)
    }
}
