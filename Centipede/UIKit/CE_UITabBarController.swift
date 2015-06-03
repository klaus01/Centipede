//
//  CE_UITabBarController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UITabBarController {
    
    private var ce: UITabBarController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UITabBarController_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UITabBarController_Delegate {
                return delegate as! UITabBarController_Delegate
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
        self.transitioningDelegate = nil
        self.transitioningDelegate = delegate
    }
    
    internal override func getDelegateInstance() -> UITabBarController_Delegate {
        return UITabBarController_Delegate()
    }
    
    public func ce_ShouldSelectViewController(handle: (tabBarController: UITabBarController, viewController: UIViewController) -> Bool) -> Self {
        ce.ShouldSelectViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidSelectViewController(handle: (tabBarController: UITabBarController, viewController: UIViewController) -> Void) -> Self {
        ce.DidSelectViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillBeginCustomizingViewControllers(handle: (tabBarController: UITabBarController, viewControllers: [AnyObject]) -> Void) -> Self {
        ce.WillBeginCustomizingViewControllers = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillEndCustomizingViewControllers(handle: (tabBarController: UITabBarController, viewControllers: [AnyObject], changed: Bool) -> Void) -> Self {
        ce.WillEndCustomizingViewControllers = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndCustomizingViewControllers(handle: (tabBarController: UITabBarController, viewControllers: [AnyObject], changed: Bool) -> Void) -> Self {
        ce.DidEndCustomizingViewControllers = handle
        rebindingDelegate()
        return self
    }
    public func ce_SupportedInterfaceOrientations(handle: (tabBarController: UITabBarController) -> Int) -> Self {
        ce.SupportedInterfaceOrientations = handle
        rebindingDelegate()
        return self
    }
    public func ce_PreferredInterfaceOrientationForPresentation(handle: (tabBarController: UITabBarController) -> UIInterfaceOrientation) -> Self {
        ce.PreferredInterfaceOrientationForPresentation = handle
        rebindingDelegate()
        return self
    }
    public func ce_InteractionControllerForAnimationController(handle: (tabBarController: UITabBarController, animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?) -> Self {
        ce.InteractionControllerForAnimationController = handle
        rebindingDelegate()
        return self
    }
    public func ce_AnimationControllerForTransitionFromViewController(handle: (tabBarController: UITabBarController, fromVC: UIViewController, toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?) -> Self {
        ce.AnimationControllerForTransitionFromViewController = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UITabBarController_Delegate: UIViewController_Delegate, UITabBarControllerDelegate {
    
    var ShouldSelectViewController: ((UITabBarController, UIViewController) -> Bool)?
    var DidSelectViewController: ((UITabBarController, UIViewController) -> Void)?
    var WillBeginCustomizingViewControllers: ((UITabBarController, [AnyObject]) -> Void)?
    var WillEndCustomizingViewControllers: ((UITabBarController, [AnyObject], Bool) -> Void)?
    var DidEndCustomizingViewControllers: ((UITabBarController, [AnyObject], Bool) -> Void)?
    var SupportedInterfaceOrientations: ((UITabBarController) -> Int)?
    var PreferredInterfaceOrientationForPresentation: ((UITabBarController) -> UIInterfaceOrientation)?
    var InteractionControllerForAnimationController: ((UITabBarController, UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?)?
    var AnimationControllerForTransitionFromViewController: ((UITabBarController, UIViewController, UIViewController) -> UIViewControllerAnimatedTransitioning?)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "tabBarController:shouldSelectViewController:" : ShouldSelectViewController,
            "tabBarController:didSelectViewController:" : DidSelectViewController,
            "tabBarController:willBeginCustomizingViewControllers:" : WillBeginCustomizingViewControllers,
            "tabBarController:willEndCustomizingViewControllers:changed:" : WillEndCustomizingViewControllers,
            "tabBarController:didEndCustomizingViewControllers:changed:" : DidEndCustomizingViewControllers,
            "tabBarControllerSupportedInterfaceOrientations:" : SupportedInterfaceOrientations,
            "tabBarControllerPreferredInterfaceOrientationForPresentation:" : PreferredInterfaceOrientationForPresentation,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "tabBarController:interactionControllerForAnimationController:" : InteractionControllerForAnimationController,
            "tabBarController:animationControllerForTransitionFromViewController:toViewController:" : AnimationControllerForTransitionFromViewController,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        return ShouldSelectViewController!(tabBarController, viewController)
    }
    @objc func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        DidSelectViewController!(tabBarController, viewController)
    }
    @objc func tabBarController(tabBarController: UITabBarController, willBeginCustomizingViewControllers viewControllers: [AnyObject]) {
        WillBeginCustomizingViewControllers!(tabBarController, viewControllers)
    }
    @objc func tabBarController(tabBarController: UITabBarController, willEndCustomizingViewControllers viewControllers: [AnyObject], changed: Bool) {
        WillEndCustomizingViewControllers!(tabBarController, viewControllers, changed)
    }
    @objc func tabBarController(tabBarController: UITabBarController, didEndCustomizingViewControllers viewControllers: [AnyObject], changed: Bool) {
        DidEndCustomizingViewControllers!(tabBarController, viewControllers, changed)
    }
    @objc func tabBarControllerSupportedInterfaceOrientations(tabBarController: UITabBarController) -> Int {
        return SupportedInterfaceOrientations!(tabBarController)
    }
    @objc func tabBarControllerPreferredInterfaceOrientationForPresentation(tabBarController: UITabBarController) -> UIInterfaceOrientation {
        return PreferredInterfaceOrientationForPresentation!(tabBarController)
    }
    @objc func tabBarController(tabBarController: UITabBarController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return InteractionControllerForAnimationController!(tabBarController, animationController)
    }
    @objc func tabBarController(tabBarController: UITabBarController, animationControllerForTransitionFromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationControllerForTransitionFromViewController!(tabBarController, fromVC, toVC)
    }
}
