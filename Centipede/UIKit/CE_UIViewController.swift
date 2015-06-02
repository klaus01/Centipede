//
//  CE_UIViewController.swift
//  Centipede
//
//  Created by kelei on 15/4/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    private var ce: UIViewController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIViewController_Delegate {
            return obj
        }
        if let delegate = self.transitioningDelegate {
            if delegate is UIViewController_Delegate {
                return delegate as! UIViewController_Delegate
            }
        }
        let delegate = getDelegateInstance()
        objc_setAssociatedObject(self, &Static.AssociationKey, delegate, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        return delegate
    }
    
    private func rebindingDelegate() {
        let delegate = ce
        self.transitioningDelegate = nil
        self.transitioningDelegate = delegate
    }
    
    internal func getDelegateInstance() -> UIViewController_Delegate {
        return UIViewController_Delegate()
    }
    
    public func ce_AnimationControllerForPresentedController(handle: (presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?) -> Self {
        ce.AnimationControllerForPresentedController = handle
        rebindingDelegate()
        return self
    }
    public func ce_AnimationControllerForDismissedController(handle: (dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?) -> Self {
        ce.AnimationControllerForDismissedController = handle
        rebindingDelegate()
        return self
    }
    public func ce_InteractionControllerForPresentation(handle: (animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?) -> Self {
        ce.InteractionControllerForPresentation = handle
        rebindingDelegate()
        return self
    }
    public func ce_InteractionControllerForDismissal(handle: (animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?) -> Self {
        ce.InteractionControllerForDismissal = handle
        rebindingDelegate()
        return self
    }
    public func ce_PresentationControllerForPresented(handle: (presented: UIViewController, presenting: UIViewController!, source: UIViewController) -> UIPresentationController?) -> Self {
        ce.PresentationControllerForPresented = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIViewController_Delegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var AnimationControllerForPresentedController: ((UIViewController, UIViewController, UIViewController) -> UIViewControllerAnimatedTransitioning?)?
    var AnimationControllerForDismissedController: ((UIViewController) -> UIViewControllerAnimatedTransitioning?)?
    var InteractionControllerForPresentation: ((UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?)?
    var InteractionControllerForDismissal: ((UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?)?
    var PresentationControllerForPresented: ((UIViewController, UIViewController!, UIViewController) -> UIPresentationController?)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "animationControllerForPresentedController:presentingController:sourceController:" : AnimationControllerForPresentedController,
            "animationControllerForDismissedController:" : AnimationControllerForDismissedController,
            "interactionControllerForPresentation:" : InteractionControllerForPresentation,
            "interactionControllerForDismissal:" : InteractionControllerForDismissal,
            "presentationControllerForPresentedViewController:presentingViewController:sourceViewController:" : PresentationControllerForPresented,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationControllerForPresentedController!(presented, presenting, source)
    }
    @objc func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationControllerForDismissedController!(dismissed)
    }
    @objc func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return InteractionControllerForPresentation!(animator)
    }
    @objc func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return InteractionControllerForDismissal!(animator)
    }
    @objc func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController? {
        return PresentationControllerForPresented!(presented, presenting, source)
    }
}