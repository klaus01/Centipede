//
//  CE_UIPopoverPresentationController.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

extension UIPopoverPresentationController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIPopoverPresentationController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIPopoverPresentationController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIPopoverPresentationController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is UIPopoverPresentationController_Delegate {
                return obj as! UIPopoverPresentationController_Delegate
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
    
    internal override func getDelegateInstance() -> UIPopoverPresentationController_Delegate {
        return UIPopoverPresentationController_Delegate()
    }
    
    @discardableResult
    public func ce_prepareForPopoverPresentation(handle: @escaping (UIPopoverPresentationController) -> Void) -> Self {
        ce._prepareForPopoverPresentation = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_popoverPresentationControllerShouldDismissPopover(handle: @escaping (UIPopoverPresentationController) -> Bool) -> Self {
        ce._popoverPresentationControllerShouldDismissPopover = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_popoverPresentationControllerDidDismissPopover(handle: @escaping (UIPopoverPresentationController) -> Void) -> Self {
        ce._popoverPresentationControllerDidDismissPopover = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_popoverPresentationController_willRepositionPopoverTo(handle: @escaping (UIPopoverPresentationController, UnsafeMutablePointer<CGRect>, AutoreleasingUnsafeMutablePointer<UIView>) -> Void) -> Self {
        ce._popoverPresentationController_willRepositionPopoverTo = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPopoverPresentationController_Delegate: UIPresentationController_Delegate, UIPopoverPresentationControllerDelegate {
    
    var _prepareForPopoverPresentation: ((UIPopoverPresentationController) -> Void)?
    var _popoverPresentationControllerShouldDismissPopover: ((UIPopoverPresentationController) -> Bool)?
    var _popoverPresentationControllerDidDismissPopover: ((UIPopoverPresentationController) -> Void)?
    var _popoverPresentationController_willRepositionPopoverTo: ((UIPopoverPresentationController, UnsafeMutablePointer<CGRect>, AutoreleasingUnsafeMutablePointer<UIView>) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(prepareForPopoverPresentation(_:)) : _prepareForPopoverPresentation,
            #selector(popoverPresentationControllerShouldDismissPopover(_:)) : _popoverPresentationControllerShouldDismissPopover,
            #selector(popoverPresentationControllerDidDismissPopover(_:)) : _popoverPresentationControllerDidDismissPopover,
            #selector(popoverPresentationController(_:willRepositionPopoverTo:in:)) : _popoverPresentationController_willRepositionPopoverTo,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        _prepareForPopoverPresentation!(popoverPresentationController)
    }
    @objc func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return _popoverPresentationControllerShouldDismissPopover!(popoverPresentationController)
    }
    @objc func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        _popoverPresentationControllerDidDismissPopover!(popoverPresentationController)
    }
    @objc func popoverPresentationController(_ popoverPresentationController: UIPopoverPresentationController, willRepositionPopoverTo rect: UnsafeMutablePointer<CGRect>, in view: AutoreleasingUnsafeMutablePointer<UIView>) {
        _popoverPresentationController_willRepositionPopoverTo!(popoverPresentationController, rect, view)
    }
}
