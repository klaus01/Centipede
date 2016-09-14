//
//  CE_UITabBarController.swift
//  Centipede
//
//  Created by kelei on 2016/9/14.
//  Copyright (c) 2016年 kelei. All rights reserved.
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
        if let obj: AnyObject = self.delegate {
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
    
    public func ce_tabBarController_shouldSelect(handle: @escaping (UITabBarController, UIViewController) -> Bool) -> Self {
        ce._tabBarController_shouldSelect = handle
        rebindingDelegate()
        return self
    }
    public func ce_tabBarController_didSelect(handle: @escaping (UITabBarController, UIViewController) -> Void) -> Self {
        ce._tabBarController_didSelect = handle
        rebindingDelegate()
        return self
    }
    public func ce_tabBarController_willBeginCustomizing(handle: @escaping (UITabBarController, [UIViewController]) -> Void) -> Self {
        ce._tabBarController_willBeginCustomizing = handle
        rebindingDelegate()
        return self
    }
    public func ce_tabBarController_willEndCustomizing(handle: @escaping (UITabBarController, [UIViewController], Bool) -> Void) -> Self {
        ce._tabBarController_willEndCustomizing = handle
        rebindingDelegate()
        return self
    }
    public func ce_tabBarController_didEndCustomizing(handle: @escaping (UITabBarController, [UIViewController], Bool) -> Void) -> Self {
        ce._tabBarController_didEndCustomizing = handle
        rebindingDelegate()
        return self
    }
    public func ce_tabBarControllerSupportedInterfaceOrientations(handle: @escaping (UITabBarController) -> UIInterfaceOrientationMask) -> Self {
        ce._tabBarControllerSupportedInterfaceOrientations = handle
        rebindingDelegate()
        return self
    }
    public func ce_tabBarControllerPreferredInterfaceOrientationForPresentation(handle: @escaping (UITabBarController) -> UIInterfaceOrientation) -> Self {
        ce._tabBarControllerPreferredInterfaceOrientationForPresentation = handle
        rebindingDelegate()
        return self
    }
    public func ce_tabBarController_interactionControllerFor(handle: @escaping (UITabBarController, UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?) -> Self {
        ce._tabBarController_interactionControllerFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_tabBarController_animationControllerForTransitionFrom(handle: @escaping (UITabBarController, UIViewController, UIViewController) -> UIViewControllerAnimatedTransitioning?) -> Self {
        ce._tabBarController_animationControllerForTransitionFrom = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UITabBarController_Delegate: UIViewController_Delegate, UITabBarControllerDelegate {
    
    var _tabBarController_shouldSelect: ((UITabBarController, UIViewController) -> Bool)?
    var _tabBarController_didSelect: ((UITabBarController, UIViewController) -> Void)?
    var _tabBarController_willBeginCustomizing: ((UITabBarController, [UIViewController]) -> Void)?
    var _tabBarController_willEndCustomizing: ((UITabBarController, [UIViewController], Bool) -> Void)?
    var _tabBarController_didEndCustomizing: ((UITabBarController, [UIViewController], Bool) -> Void)?
    var _tabBarControllerSupportedInterfaceOrientations: ((UITabBarController) -> UIInterfaceOrientationMask)?
    var _tabBarControllerPreferredInterfaceOrientationForPresentation: ((UITabBarController) -> UIInterfaceOrientation)?
    var _tabBarController_interactionControllerFor: ((UITabBarController, UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?)?
    var _tabBarController_animationControllerForTransitionFrom: ((UITabBarController, UIViewController, UIViewController) -> UIViewControllerAnimatedTransitioning?)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(tabBarController(_:shouldSelect:)) : _tabBarController_shouldSelect,
            #selector(tabBarController(_:didSelect:)) : _tabBarController_didSelect,
            #selector(tabBarController(_:willBeginCustomizing:)) : _tabBarController_willBeginCustomizing,
            #selector(tabBarController(_:willEndCustomizing:changed:)) : _tabBarController_willEndCustomizing,
            #selector(tabBarController(_:didEndCustomizing:changed:)) : _tabBarController_didEndCustomizing,
            #selector(tabBarControllerSupportedInterfaceOrientations(_:)) : _tabBarControllerSupportedInterfaceOrientations,
            #selector(tabBarControllerPreferredInterfaceOrientationForPresentation(_:)) : _tabBarControllerPreferredInterfaceOrientationForPresentation,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(tabBarController(_:interactionControllerFor:)) : _tabBarController_interactionControllerFor,
            #selector(tabBarController(_:animationControllerForTransitionFrom:to:)) : _tabBarController_animationControllerForTransitionFrom,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return _tabBarController_shouldSelect!(tabBarController, viewController)
    }
    @objc func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        _tabBarController_didSelect!(tabBarController, viewController)
    }
    @objc func tabBarController(_ tabBarController: UITabBarController, willBeginCustomizing viewControllers: [UIViewController]) {
        _tabBarController_willBeginCustomizing!(tabBarController, viewControllers)
    }
    @objc func tabBarController(_ tabBarController: UITabBarController, willEndCustomizing viewControllers: [UIViewController], changed: Bool) {
        _tabBarController_willEndCustomizing!(tabBarController, viewControllers, changed)
    }
    @objc func tabBarController(_ tabBarController: UITabBarController, didEndCustomizing viewControllers: [UIViewController], changed: Bool) {
        _tabBarController_didEndCustomizing!(tabBarController, viewControllers, changed)
    }
    @objc func tabBarControllerSupportedInterfaceOrientations(_ tabBarController: UITabBarController) -> UIInterfaceOrientationMask {
        return _tabBarControllerSupportedInterfaceOrientations!(tabBarController)
    }
    @objc func tabBarControllerPreferredInterfaceOrientationForPresentation(_ tabBarController: UITabBarController) -> UIInterfaceOrientation {
        return _tabBarControllerPreferredInterfaceOrientationForPresentation!(tabBarController)
    }
    @objc func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return _tabBarController_interactionControllerFor!(tabBarController, animationController)
    }
    @objc func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return _tabBarController_animationControllerForTransitionFrom!(tabBarController, fromVC, toVC)
    }
}
