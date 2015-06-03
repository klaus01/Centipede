//
//  CE_UIPageViewController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UIPageViewController {
    
    private var ce: UIPageViewController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIPageViewController_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UIPageViewController_Delegate {
                return delegate as! UIPageViewController_Delegate
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
        self.dataSource = nil
        self.dataSource = delegate
        self.transitioningDelegate = nil
        self.transitioningDelegate = delegate
    }
    
    internal override func getDelegateInstance() -> UIPageViewController_Delegate {
        return UIPageViewController_Delegate()
    }
    
    public func ce_WillTransitionToViewControllers(handle: (pageViewController: UIPageViewController, pendingViewControllers: [AnyObject]) -> Void) -> Self {
        ce.WillTransitionToViewControllers = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidFinishAnimating(handle: (pageViewController: UIPageViewController, finished: Bool, previousViewControllers: [AnyObject], completed: Bool) -> Void) -> Self {
        ce.DidFinishAnimating = handle
        rebindingDelegate()
        return self
    }
    public func ce_SpineLocationForInterfaceOrientation(handle: (pageViewController: UIPageViewController, orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation) -> Self {
        ce.SpineLocationForInterfaceOrientation = handle
        rebindingDelegate()
        return self
    }
    public func ce_SupportedInterfaceOrientations(handle: (pageViewController: UIPageViewController) -> Int) -> Self {
        ce.SupportedInterfaceOrientations = handle
        rebindingDelegate()
        return self
    }
    public func ce_PreferredInterfaceOrientationForPresentation(handle: (pageViewController: UIPageViewController) -> UIInterfaceOrientation) -> Self {
        ce.PreferredInterfaceOrientationForPresentation = handle
        rebindingDelegate()
        return self
    }
    public func ce_ViewControllerBeforeViewController(handle: (pageViewController: UIPageViewController, viewController: UIViewController) -> UIViewController?) -> Self {
        ce.ViewControllerBeforeViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_ViewControllerAfterViewController(handle: (pageViewController: UIPageViewController, viewController: UIViewController) -> UIViewController?) -> Self {
        ce.ViewControllerAfterViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_PresentationCountFor(handle: (pageViewController: UIPageViewController) -> Int) -> Self {
        ce.PresentationCountFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_PresentationIndexFor(handle: (pageViewController: UIPageViewController) -> Int) -> Self {
        ce.PresentationIndexFor = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPageViewController_Delegate: UIViewController_Delegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var WillTransitionToViewControllers: ((UIPageViewController, [AnyObject]) -> Void)?
    var DidFinishAnimating: ((UIPageViewController, Bool, [AnyObject], Bool) -> Void)?
    var SpineLocationForInterfaceOrientation: ((UIPageViewController, UIInterfaceOrientation) -> UIPageViewControllerSpineLocation)?
    var SupportedInterfaceOrientations: ((UIPageViewController) -> Int)?
    var PreferredInterfaceOrientationForPresentation: ((UIPageViewController) -> UIInterfaceOrientation)?
    var ViewControllerBeforeViewController: ((UIPageViewController, UIViewController) -> UIViewController?)?
    var ViewControllerAfterViewController: ((UIPageViewController, UIViewController) -> UIViewController?)?
    var PresentationCountFor: ((UIPageViewController) -> Int)?
    var PresentationIndexFor: ((UIPageViewController) -> Int)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "pageViewController:willTransitionToViewControllers:" : WillTransitionToViewControllers,
            "pageViewController:didFinishAnimating:previousViewControllers:transitionCompleted:" : DidFinishAnimating,
            "pageViewController:spineLocationForInterfaceOrientation:" : SpineLocationForInterfaceOrientation,
            "pageViewControllerSupportedInterfaceOrientations:" : SupportedInterfaceOrientations,
            "pageViewControllerPreferredInterfaceOrientationForPresentation:" : PreferredInterfaceOrientationForPresentation,
            "pageViewController:viewControllerBeforeViewController:" : ViewControllerBeforeViewController,
            "pageViewController:viewControllerAfterViewController:" : ViewControllerAfterViewController,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "presentationCountForPageViewController:" : PresentationCountFor,
            "presentationIndexForPageViewController:" : PresentationIndexFor,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [AnyObject]) {
        WillTransitionToViewControllers!(pageViewController, pendingViewControllers)
    }
    @objc func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        DidFinishAnimating!(pageViewController, finished, previousViewControllers, completed)
    }
    @objc func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        return SpineLocationForInterfaceOrientation!(pageViewController, orientation)
    }
    @objc func pageViewControllerSupportedInterfaceOrientations(pageViewController: UIPageViewController) -> Int {
        return SupportedInterfaceOrientations!(pageViewController)
    }
    @objc func pageViewControllerPreferredInterfaceOrientationForPresentation(pageViewController: UIPageViewController) -> UIInterfaceOrientation {
        return PreferredInterfaceOrientationForPresentation!(pageViewController)
    }
    @objc func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return ViewControllerBeforeViewController!(pageViewController, viewController)
    }
    @objc func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return ViewControllerAfterViewController!(pageViewController, viewController)
    }
    @objc func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return PresentationCountFor!(pageViewController)
    }
    @objc func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return PresentationIndexFor!(pageViewController)
    }
}
