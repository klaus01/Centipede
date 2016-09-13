//
//  CE_UIViewController.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
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
    
    public func ce_animationController(handle: ((UIViewController) -> UIViewControllerAnimatedTransitioning?)) -> Self {
        ce._animationController = handle
        rebindingDelegate()
        return self
    }
    public func ce_animationController_forPresented(handle: ((UIViewController, UIViewController, UIViewController) -> UIViewControllerAnimatedTransitioning?)) -> Self {
        ce._animationController_forPresented = handle
        rebindingDelegate()
        return self
    }
    public func ce_interactionControllerForPresentation(handle: ((UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?)) -> Self {
        ce._interactionControllerForPresentation = handle
        rebindingDelegate()
        return self
    }
    public func ce_interactionControllerForDismissal(handle: ((UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?)) -> Self {
        ce._interactionControllerForDismissal = handle
        rebindingDelegate()
        return self
    }
    public func ce_presentationController(handle: ((UIViewController, UIViewController?, UIViewController) -> UIPresentationController?)) -> Self {
        ce._presentationController = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIViewController_Delegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var _animationController: ((UIViewController) -> UIViewControllerAnimatedTransitioning?)?
    var _animationController_forPresented: ((UIViewController, UIViewController, UIViewController) -> UIViewControllerAnimatedTransitioning?)?
    var _interactionControllerForPresentation: ((UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?)?
    var _interactionControllerForDismissal: ((UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?)?
    var _presentationController: ((UIViewController, UIViewController?, UIViewController) -> UIPresentationController?)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(animationController(forDismissed:)) : _animationController,
            #selector(animationController(forPresented:presenting:source:)) : _animationController_forPresented,
            #selector(interactionControllerForPresentation(using:)) : _interactionControllerForPresentation,
            #selector(interactionControllerForDismissal(using:)) : _interactionControllerForDismissal,
            #selector(presentationController(forPresented:presenting:source:)) : _presentationController,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return _animationController!(dismissed)
    }
    @objc func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return _animationController_forPresented!(presented, presenting, source)
    }
    @objc func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return _interactionControllerForPresentation!(animator)
    }
    @objc func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return _interactionControllerForDismissal!(animator)
    }
    @objc func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return _presentationController!(presented, presenting, source)
    }
}
