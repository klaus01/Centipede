//
//  CE_UIViewController.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIViewController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIViewController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIViewController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.transitioningDelegate {
            if obj is UIViewController_Delegate {
                return obj as! UIViewController_Delegate
            }
        }
        let obj = getDelegateInstance()
        _delegate = obj
        return obj
    }
    
    private func rebindingDelegate() {
        let delegate = ce
        self.transitioningDelegate = nil
        self.transitioningDelegate = delegate
    }
    
    internal func getDelegateInstance() -> UIViewController_Delegate {
        return UIViewController_Delegate()
    }
    
    @discardableResult
    public func ce_animationController_forDismissed(handle: @escaping (UIViewController) -> UIViewControllerAnimatedTransitioning?) -> Self {
        ce._animationController_forDismissed = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_animationController_forPresented(handle: @escaping (UIViewController, UIViewController, UIViewController) -> UIViewControllerAnimatedTransitioning?) -> Self {
        ce._animationController_forPresented = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_interactionControllerForPresentation_using(handle: @escaping (UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?) -> Self {
        ce._interactionControllerForPresentation_using = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_interactionControllerForDismissal_using(handle: @escaping (UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?) -> Self {
        ce._interactionControllerForDismissal_using = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_presentationController_forPresented(handle: @escaping (UIViewController, UIViewController?, UIViewController) -> UIPresentationController?) -> Self {
        ce._presentationController_forPresented = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIViewController_Delegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var _animationController_forDismissed: ((UIViewController) -> UIViewControllerAnimatedTransitioning?)?
    var _animationController_forPresented: ((UIViewController, UIViewController, UIViewController) -> UIViewControllerAnimatedTransitioning?)?
    var _interactionControllerForPresentation_using: ((UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?)?
    var _interactionControllerForDismissal_using: ((UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?)?
    var _presentationController_forPresented: ((UIViewController, UIViewController?, UIViewController) -> UIPresentationController?)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(animationController(forDismissed:)) : _animationController_forDismissed,
            #selector(animationController(forPresented:presenting:source:)) : _animationController_forPresented,
            #selector(interactionControllerForPresentation(using:)) : _interactionControllerForPresentation_using,
            #selector(interactionControllerForDismissal(using:)) : _interactionControllerForDismissal_using,
            #selector(presentationController(forPresented:presenting:source:)) : _presentationController_forPresented,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return _animationController_forDismissed!(dismissed)
    }
    @objc func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return _animationController_forPresented!(presented, presenting, source)
    }
    @objc func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return _interactionControllerForPresentation_using!(animator)
    }
    @objc func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return _interactionControllerForDismissal_using!(animator)
    }
    @objc func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return _presentationController_forPresented!(presented, presenting, source)
    }
}
