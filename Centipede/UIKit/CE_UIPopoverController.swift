//
//  CE_UIPopoverController.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

extension UIPopoverController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIPopoverController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIPopoverController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIPopoverController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is UIPopoverController_Delegate {
                return obj as! UIPopoverController_Delegate
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
    
    internal func getDelegateInstance() -> UIPopoverController_Delegate {
        return UIPopoverController_Delegate()
    }
    
    @discardableResult
    public func ce_popoverControllerShouldDismissPopover(handle: @escaping (UIPopoverController) -> Bool) -> Self {
        ce._popoverControllerShouldDismissPopover = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_popoverControllerDidDismissPopover(handle: @escaping (UIPopoverController) -> Void) -> Self {
        ce._popoverControllerDidDismissPopover = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_popoverController_willRepositionPopoverTo(handle: @escaping (UIPopoverController, UnsafeMutablePointer<CGRect>, AutoreleasingUnsafeMutablePointer<UIView>) -> Void) -> Self {
        ce._popoverController_willRepositionPopoverTo = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPopoverController_Delegate: NSObject, UIPopoverControllerDelegate {
    
    var _popoverControllerShouldDismissPopover: ((UIPopoverController) -> Bool)?
    var _popoverControllerDidDismissPopover: ((UIPopoverController) -> Void)?
    var _popoverController_willRepositionPopoverTo: ((UIPopoverController, UnsafeMutablePointer<CGRect>, AutoreleasingUnsafeMutablePointer<UIView>) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(popoverControllerShouldDismissPopover(_:)) : _popoverControllerShouldDismissPopover,
            #selector(popoverControllerDidDismissPopover(_:)) : _popoverControllerDidDismissPopover,
            #selector(popoverController(_:willRepositionPopoverTo:in:)) : _popoverController_willRepositionPopoverTo,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func popoverControllerShouldDismissPopover(_ popoverController: UIPopoverController) -> Bool {
        return _popoverControllerShouldDismissPopover!(popoverController)
    }
    @objc func popoverControllerDidDismissPopover(_ popoverController: UIPopoverController) {
        _popoverControllerDidDismissPopover!(popoverController)
    }
    @objc func popoverController(_ popoverController: UIPopoverController, willRepositionPopoverTo rect: UnsafeMutablePointer<CGRect>, in view: AutoreleasingUnsafeMutablePointer<UIView>) {
        _popoverController_willRepositionPopoverTo!(popoverController, rect, view)
    }
}
