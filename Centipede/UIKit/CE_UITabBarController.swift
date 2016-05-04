//
//  CE_UITabBarController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UITabBarController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UITabBarController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UITabBarController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UITabBarController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is UITabBarController_Delegate {
                return obj as! UITabBarController_Delegate
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
    public func ce_willBeginCustomizingViewControllers(handle: (tabBarController: UITabBarController, viewControllers: [UIViewController]) -> Void) -> Self {
        ce._willBeginCustomizingViewControllers = handle
        rebindingDelegate()
        return self
    }
    public func ce_willEndCustomizingViewControllers(handle: (tabBarController: UITabBarController, viewControllers: [UIViewController], changed: Bool) -> Void) -> Self {
        ce._willEndCustomizingViewControllers = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndCustomizingViewControllers(handle: (tabBarController: UITabBarController, viewControllers: [UIViewController], changed: Bool) -> Void) -> Self {
        ce._didEndCustomizingViewControllers = handle
        rebindingDelegate()
        return self
    }
    public func ce_supportedInterfaceOrientations(handle: (tabBarController: UITabBarController) -> UIInterfaceOrientationMask) -> Self {
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
    var _willBeginCustomizingViewControllers: ((UITabBarController, [UIViewController]) -> Void)?
    var _willEndCustomizingViewControllers: ((UITabBarController, [UIViewController], Bool) -> Void)?
    var _didEndCustomizingViewControllers: ((UITabBarController, [UIViewController], Bool) -> Void)?
    var _supportedInterfaceOrientations: ((UITabBarController) -> UIInterfaceOrientationMask)?
    var _preferredInterfaceOrientationForPresentation: ((UITabBarController) -> UIInterfaceOrientation)?
    var _interactionControllerForAnimationController: ((UITabBarController, UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?)?
    var _animationControllerForTransitionFromViewController: ((UITabBarController, UIViewController, UIViewController) -> UIViewControllerAnimatedTransitioning?)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(tabBarController(_:shouldSelectViewController:)) : _shouldSelectViewController,
            #selector(tabBarController(_:didSelectViewController:)) : _didSelectViewController,
            #selector(tabBarController(_:willBeginCustomizingViewControllers:)) : _willBeginCustomizingViewControllers,
            #selector(tabBarController(_:willEndCustomizingViewControllers:changed:)) : _willEndCustomizingViewControllers,
            #selector(tabBarController(_:didEndCustomizingViewControllers:changed:)) : _didEndCustomizingViewControllers,
            #selector(tabBarControllerSupportedInterfaceOrientations(_:)) : _supportedInterfaceOrientations,
            #selector(tabBarControllerPreferredInterfaceOrientationForPresentation(_:)) : _preferredInterfaceOrientationForPresentation,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(tabBarController(_:interactionControllerForAnimationController:)) : _interactionControllerForAnimationController,
            #selector(tabBarController(_:animationControllerForTransitionFromViewController:toViewController:)) : _animationControllerForTransitionFromViewController,
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
    @objc func tabBarController(tabBarController: UITabBarController, willBeginCustomizingViewControllers viewControllers: [UIViewController]) {
        _willBeginCustomizingViewControllers!(tabBarController, viewControllers)
    }
    @objc func tabBarController(tabBarController: UITabBarController, willEndCustomizingViewControllers viewControllers: [UIViewController], changed: Bool) {
        _willEndCustomizingViewControllers!(tabBarController, viewControllers, changed)
    }
    @objc func tabBarController(tabBarController: UITabBarController, didEndCustomizingViewControllers viewControllers: [UIViewController], changed: Bool) {
        _didEndCustomizingViewControllers!(tabBarController, viewControllers, changed)
    }
    @objc func tabBarControllerSupportedInterfaceOrientations(tabBarController: UITabBarController) -> UIInterfaceOrientationMask {
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
