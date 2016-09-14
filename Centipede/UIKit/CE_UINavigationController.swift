//
//  CE_UINavigationController.swift
//  Centipede
//
//  Created by kelei on 2016/9/14.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension UINavigationController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UINavigationController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UINavigationController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UINavigationController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is UINavigationController_Delegate {
                return obj as! UINavigationController_Delegate
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
    
    internal override func getDelegateInstance() -> UINavigationController_Delegate {
        return UINavigationController_Delegate()
    }
    
    public func ce_navigationController_willShow(handle: @escaping (UINavigationController, UIViewController, Bool) -> Void) -> Self {
        ce._navigationController_willShow = handle
        rebindingDelegate()
        return self
    }
    public func ce_navigationController_didShow(handle: @escaping (UINavigationController, UIViewController, Bool) -> Void) -> Self {
        ce._navigationController_didShow = handle
        rebindingDelegate()
        return self
    }
    public func ce_navigationControllerSupportedInterfaceOrientations(handle: @escaping (UINavigationController) -> UIInterfaceOrientationMask) -> Self {
        ce._navigationControllerSupportedInterfaceOrientations = handle
        rebindingDelegate()
        return self
    }
    public func ce_navigationControllerPreferredInterfaceOrientationForPresentation(handle: @escaping (UINavigationController) -> UIInterfaceOrientation) -> Self {
        ce._navigationControllerPreferredInterfaceOrientationForPresentation = handle
        rebindingDelegate()
        return self
    }
    public func ce_navigationController_interactionControllerFor(handle: @escaping (UINavigationController, UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?) -> Self {
        ce._navigationController_interactionControllerFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_navigationController_animationControllerFor(handle: @escaping (UINavigationController, UINavigationControllerOperation, UIViewController, UIViewController) -> UIViewControllerAnimatedTransitioning?) -> Self {
        ce._navigationController_animationControllerFor = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UINavigationController_Delegate: UIViewController_Delegate, UINavigationControllerDelegate {
    
    var _navigationController_willShow: ((UINavigationController, UIViewController, Bool) -> Void)?
    var _navigationController_didShow: ((UINavigationController, UIViewController, Bool) -> Void)?
    var _navigationControllerSupportedInterfaceOrientations: ((UINavigationController) -> UIInterfaceOrientationMask)?
    var _navigationControllerPreferredInterfaceOrientationForPresentation: ((UINavigationController) -> UIInterfaceOrientation)?
    var _navigationController_interactionControllerFor: ((UINavigationController, UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?)?
    var _navigationController_animationControllerFor: ((UINavigationController, UINavigationControllerOperation, UIViewController, UIViewController) -> UIViewControllerAnimatedTransitioning?)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(navigationController(_:willShow:animated:)) : _navigationController_willShow,
            #selector(navigationController(_:didShow:animated:)) : _navigationController_didShow,
            #selector(navigationControllerSupportedInterfaceOrientations(_:)) : _navigationControllerSupportedInterfaceOrientations,
            #selector(navigationControllerPreferredInterfaceOrientationForPresentation(_:)) : _navigationControllerPreferredInterfaceOrientationForPresentation,
            #selector(navigationController(_:interactionControllerFor:)) : _navigationController_interactionControllerFor,
            #selector(navigationController(_:animationControllerFor:from:to:)) : _navigationController_animationControllerFor,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        _navigationController_willShow!(navigationController, viewController, animated)
    }
    @objc func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        _navigationController_didShow!(navigationController, viewController, animated)
    }
    @objc func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return _navigationControllerSupportedInterfaceOrientations!(navigationController)
    }
    @objc func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: UINavigationController) -> UIInterfaceOrientation {
        return _navigationControllerPreferredInterfaceOrientationForPresentation!(navigationController)
    }
    @objc func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return _navigationController_interactionControllerFor!(navigationController, animationController)
    }
    @objc func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return _navigationController_animationControllerFor!(navigationController, operation, fromVC, toVC)
    }
}
