//
//  CE_UIPopoverController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UIPopoverController {
    
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
    
    public func ce_shouldDismissPopover(handle: (popoverController: UIPopoverController) -> Bool) -> Self {
        ce._shouldDismissPopover = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDismissPopover(handle: (popoverController: UIPopoverController) -> Void) -> Self {
        ce._didDismissPopover = handle
        rebindingDelegate()
        return self
    }
    public func ce_willRepositionPopoverToRect(handle: (popoverController: UIPopoverController, rect: UnsafeMutablePointer<CGRect>, view: AutoreleasingUnsafeMutablePointer<UIView?>) -> Void) -> Self {
        ce._willRepositionPopoverToRect = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPopoverController_Delegate: NSObject, UIPopoverControllerDelegate {
    
    var _shouldDismissPopover: ((UIPopoverController) -> Bool)?
    var _didDismissPopover: ((UIPopoverController) -> Void)?
    var _willRepositionPopoverToRect: ((UIPopoverController, UnsafeMutablePointer<CGRect>, AutoreleasingUnsafeMutablePointer<UIView?>) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "popoverControllerShouldDismissPopover:" : _shouldDismissPopover,
            "popoverControllerDidDismissPopover:" : _didDismissPopover,
            "popoverController:willRepositionPopoverToRect:inView:" : _willRepositionPopoverToRect,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func popoverControllerShouldDismissPopover(popoverController: UIPopoverController) -> Bool {
        return _shouldDismissPopover!(popoverController)
    }
    @objc func popoverControllerDidDismissPopover(popoverController: UIPopoverController) {
        _didDismissPopover!(popoverController)
    }
    @objc func popoverController(popoverController: UIPopoverController, willRepositionPopoverToRect rect: UnsafeMutablePointer<CGRect>, inView view: AutoreleasingUnsafeMutablePointer<UIView?>) {
        _willRepositionPopoverToRect!(popoverController, rect, view)
    }
}
