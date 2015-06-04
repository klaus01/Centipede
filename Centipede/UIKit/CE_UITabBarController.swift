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
    
    public func ce_shouldSelectViewController(handle: (tabBarController: UITabBarController, viewController: UIViewController) -> Bool) -> Self {
        ce._shouldSelectViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_didSelectViewController(handle: (tabBarController: UITabBarController, viewController: UIViewController) -> Void) -> Self {
        ce._didSelectViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_willBeginCustomizingViewControllers(handle: (tabBarController: UITabBarController, viewControllers: [AnyObject]) -> Void) -> Self {
        ce._willBeginCustomizingViewControllers = handle
        rebindingDelegate()
        return self
    }
    public func ce_willEndCustomizingViewControllers(handle: (tabBarController: UITabBarController, viewControllers: [AnyObject], changed: Bool) -> Void) -> Self {
        ce._willEndCustomizingViewControllers = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndCustomizingViewControllers(handle: (tabBarController: UITabBarController, viewControllers: [AnyObject], changed: Bool) -> Void) -> Self {
        ce._didEndCustomizingViewControllers = handle
        rebindingDelegate()
        return self
    }
    public func ce_supportedInterfaceOrientations(handle: (tabBarController: UITabBarController) -> Int) -> Self {
        ce._supportedInterfaceOrientations = handle
        rebindingDelegate()
        return self
    }
    public func ce_preferredInterfaceOrientationForPresentation(handle: (tabBarController: UITabBarController) -> UIInterfaceOrientation) -> Self {
        ce._preferredInterfaceOrientationForPresentation = handle
        rebindingDelegate()
        return self
    }
    public func ce_interactionControllerForAnimationController(handle: (tabBarController: UITabBarController, animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?) -> Self {
        ce._interactionControllerForAnimationController = handle
        rebindingDelegate()
        return self
    }
    public func ce_animationControllerForTransitionFromViewController(handle: (tabBarController: UITabBarController, fromVC: UIViewController, toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?) -> Self {
        ce._animationControllerForTransitionFromViewController = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UITabBarController_Delegate: UIViewController_Delegate, UITabBarControllerDelegate {
    
    var _shouldSelectViewController: ((UITabBarController, UIViewController) -> Bool)?
    var _didSelectViewController: ((UITabBarController, UIViewController) -> Void)?
    var _willBeginCustomizingViewControllers: ((UITabBarController, [AnyObject]) -> Void)?
    var _willEndCustomizingViewControllers: ((UITabBarController, [AnyObject], Bool) -> Void)?
    var _didEndCustomizingViewControllers: ((UITabBarController, [AnyObject], Bool) -> Void)?
    var _supportedInterfaceOrientations: ((UITabBarController) -> Int)?
    var _preferredInterfaceOrientationForPresentation: ((UITabBarController) -> UIInterfaceOrientation)?
    var _interactionControllerForAnimationController: ((UITabBarController, UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?)?
    var _animationControllerForTransitionFromViewController: ((UITabBarController, UIViewController, UIViewController) -> UIViewControllerAnimatedTransitioning?)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "tabBarController:shouldSelectViewController:" : _shouldSelectViewController,
            "tabBarController:didSelectViewController:" : _didSelectViewController,
            "tabBarController:willBeginCustomizingViewControllers:" : _willBeginCustomizingViewControllers,
            "tabBarController:willEndCustomizingViewControllers:changed:" : _willEndCustomizingViewControllers,
            "tabBarController:didEndCustomizingViewControllers:changed:" : _didEndCustomizingViewControllers,
            "tabBarControllerSupportedInterfaceOrientations:" : _supportedInterfaceOrientations,
            "tabBarControllerPreferredInterfaceOrientationForPresentation:" : _preferredInterfaceOrientationForPresentation,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "tabBarController:interactionControllerForAnimationController:" : _interactionControllerForAnimationController,
            "tabBarController:animationControllerForTransitionFromViewController:toViewController:" : _animationControllerForTransitionFromViewController,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        return _shouldSelectViewController!(tabBarController, viewController)
    }
    @objc func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        _didSelectViewController!(tabBarController, viewController)
    }
    @objc func tabBarController(tabBarController: UITabBarController, willBeginCustomizingViewControllers viewControllers: [AnyObject]) {
        _willBeginCustomizingViewControllers!(tabBarController, viewControllers)
    }
    @objc func tabBarController(tabBarController: UITabBarController, willEndCustomizingViewControllers viewControllers: [AnyObject], changed: Bool) {
        _willEndCustomizingViewControllers!(tabBarController, viewControllers, changed)
    }
    @objc func tabBarController(tabBarController: UITabBarController, didEndCustomizingViewControllers viewControllers: [AnyObject], changed: Bool) {
        _didEndCustomizingViewControllers!(tabBarController, viewControllers, changed)
    }
    @objc func tabBarControllerSupportedInterfaceOrientations(tabBarController: UITabBarController) -> Int {
        return _supportedInterfaceOrientations!(tabBarController)
    }
    @objc func tabBarControllerPreferredInterfaceOrientationForPresentation(tabBarController: UITabBarController) -> UIInterfaceOrientation {
        return _preferredInterfaceOrientationForPresentation!(tabBarController)
    }
    @objc func tabBarController(tabBarController: UITabBarController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return _interactionControllerForAnimationController!(tabBarController, animationController)
    }
    @objc func tabBarController(tabBarController: UITabBarController, animationControllerForTransitionFromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return _animationControllerForTransitionFromViewController!(tabBarController, fromVC, toVC)
    }
}
