//
//  CE_UINavigationController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    private var ce: UINavigationController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UINavigationController_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UINavigationController_Delegate {
                return delegate as! UINavigationController_Delegate
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
    
    internal override func getDelegateInstance() -> UINavigationController_Delegate {
        return UINavigationController_Delegate()
    }
    
    public func ce_WillShowViewController(handle: (navigationController: UINavigationController, viewController: UIViewController, animated: Bool) -> Void) -> Self {
        ce.WillShowViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidShowViewController(handle: (navigationController: UINavigationController, viewController: UIViewController, animated: Bool) -> Void) -> Self {
        ce.DidShowViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_SupportedInterfaceOrientations(handle: (navigationController: UINavigationController) -> Int) -> Self {
        ce.SupportedInterfaceOrientations = handle
        rebindingDelegate()
        return self
    }
    public func ce_PreferredInterfaceOrientationForPresentation(handle: (navigationController: UINavigationController) -> UIInterfaceOrientation) -> Self {
        ce.PreferredInterfaceOrientationForPresentation = handle
        rebindingDelegate()
        return self
    }
    public func ce_InteractionControllerForAnimationController(handle: (navigationController: UINavigationController, animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?) -> Self {
        ce.InteractionControllerForAnimationController = handle
        rebindingDelegate()
        return self
    }
    public func ce_AnimationControllerForOperation(handle: (navigationController: UINavigationController, operation: UINavigationControllerOperation, fromVC: UIViewController, toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?) -> Self {
        ce.AnimationControllerForOperation = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UINavigationController_Delegate: UIViewController_Delegate, UINavigationControllerDelegate {
    
    var WillShowViewController: ((UINavigationController, UIViewController, Bool) -> Void)?
    var DidShowViewController: ((UINavigationController, UIViewController, Bool) -> Void)?
    var SupportedInterfaceOrientations: ((UINavigationController) -> Int)?
    var PreferredInterfaceOrientationForPresentation: ((UINavigationController) -> UIInterfaceOrientation)?
    var InteractionControllerForAnimationController: ((UINavigationController, UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?)?
    var AnimationControllerForOperation: ((UINavigationController, UINavigationControllerOperation, UIViewController, UIViewController) -> UIViewControllerAnimatedTransitioning?)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "navigationController:willShowViewController:animated:" : WillShowViewController,
            "navigationController:didShowViewController:animated:" : DidShowViewController,
            "navigationControllerSupportedInterfaceOrientations:" : SupportedInterfaceOrientations,
            "navigationControllerPreferredInterfaceOrientationForPresentation:" : PreferredInterfaceOrientationForPresentation,
            "navigationController:interactionControllerForAnimationController:" : InteractionControllerForAnimationController,
            "navigationController:animationControllerForOperation:fromViewController:toViewController:" : AnimationControllerForOperation,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        WillShowViewController!(navigationController, viewController, animated)
    }
    @objc func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        DidShowViewController!(navigationController, viewController, animated)
    }
    @objc func navigationControllerSupportedInterfaceOrientations(navigationController: UINavigationController) -> Int {
        return SupportedInterfaceOrientations!(navigationController)
    }
    @objc func navigationControllerPreferredInterfaceOrientationForPresentation(navigationController: UINavigationController) -> UIInterfaceOrientation {
        return PreferredInterfaceOrientationForPresentation!(navigationController)
    }
    @objc func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return InteractionControllerForAnimationController!(navigationController, animationController)
    }
    @objc func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationControllerForOperation!(navigationController, operation, fromVC, toVC)
    }
}
