//
//  CE_UIPresentationController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UIPresentationController {
    
    private var ce: UIPresentationController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIPresentationController_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UIPresentationController_Delegate {
                return delegate as! UIPresentationController_Delegate
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
    
    internal func getDelegateInstance() -> UIPresentationController_Delegate {
        return UIPresentationController_Delegate()
    }
    
    public func ce_AdaptivePresentationStyleFor(handle: (controller: UIPresentationController) -> UIModalPresentationStyle) -> Self {
        ce.AdaptivePresentationStyleFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_AdaptivePresentationStyleForAndTraitCollection(handle: (controller: UIPresentationController, traitCollection: UITraitCollection!) -> UIModalPresentationStyle) -> Self {
        ce.AdaptivePresentationStyleForAndTraitCollection = handle
        rebindingDelegate()
        return self
    }
    public func ce_ViewControllerForAdaptivePresentationStyle(handle: (controller: UIPresentationController, style: UIModalPresentationStyle) -> UIViewController?) -> Self {
        ce.ViewControllerForAdaptivePresentationStyle = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillPresentWithAdaptiveStyle(handle: (presentationController: UIPresentationController, style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator!) -> Void) -> Self {
        ce.WillPresentWithAdaptiveStyle = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPresentationController_Delegate: NSObject, UIAdaptivePresentationControllerDelegate {
    
    var AdaptivePresentationStyleFor: ((UIPresentationController) -> UIModalPresentationStyle)?
    var AdaptivePresentationStyleForAndTraitCollection: ((UIPresentationController, UITraitCollection!) -> UIModalPresentationStyle)?
    var ViewControllerForAdaptivePresentationStyle: ((UIPresentationController, UIModalPresentationStyle) -> UIViewController?)?
    var WillPresentWithAdaptiveStyle: ((UIPresentationController, UIModalPresentationStyle, UIViewControllerTransitionCoordinator!) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "adaptivePresentationStyleForPresentationController:" : AdaptivePresentationStyleFor,
            "adaptivePresentationStyleForPresentationController:traitCollection:" : AdaptivePresentationStyleForAndTraitCollection,
            "presentationController:viewControllerForAdaptivePresentationStyle:" : ViewControllerForAdaptivePresentationStyle,
            "presentationController:willPresentWithAdaptiveStyle:transitionCoordinator:" : WillPresentWithAdaptiveStyle,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return AdaptivePresentationStyleFor!(controller)
    }
    @objc func adaptivePresentationStyleForPresentationController(controller: UIPresentationController, traitCollection: UITraitCollection!) -> UIModalPresentationStyle {
        return AdaptivePresentationStyleForAndTraitCollection!(controller, traitCollection)
    }
    @objc func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        return ViewControllerForAdaptivePresentationStyle!(controller, style)
    }
    @objc func presentationController(presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator!) {
        WillPresentWithAdaptiveStyle!(presentationController, style, transitionCoordinator)
    }
}
