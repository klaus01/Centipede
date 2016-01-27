//
//  CE_UIPageViewController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UIPageViewController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIPageViewController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIPageViewController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIPageViewController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is UIPageViewController_Delegate {
                return obj as! UIPageViewController_Delegate
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
        self.dataSource = nil
        self.dataSource = delegate
        self.transitioningDelegate = nil
        self.transitioningDelegate = delegate
    }
    
    internal override func getDelegateInstance() -> UIPageViewController_Delegate {
        return UIPageViewController_Delegate()
    }
    
    public func ce_willTransitionToViewControllers(handle: (pageViewController: UIPageViewController, pendingViewControllers: [UIViewController]) -> Void) -> Self {
        ce._willTransitionToViewControllers = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFinishAnimating(handle: (pageViewController: UIPageViewController, finished: Bool, previousViewControllers: [UIViewController], completed: Bool) -> Void) -> Self {
        ce._didFinishAnimating = handle
        rebindingDelegate()
        return self
    }
    public func ce_spineLocationForInterfaceOrientation(handle: (pageViewController: UIPageViewController, orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation) -> Self {
        ce._spineLocationForInterfaceOrientation = handle
        rebindingDelegate()
        return self
    }
    public func ce_supportedInterfaceOrientations(handle: (pageViewController: UIPageViewController) -> UIInterfaceOrientationMask) -> Self {
        ce._supportedInterfaceOrientations = handle
        rebindingDelegate()
        return self
    }
    public func ce_preferredInterfaceOrientationForPresentation(handle: (pageViewController: UIPageViewController) -> UIInterfaceOrientation) -> Self {
        ce._preferredInterfaceOrientationForPresentation = handle
        rebindingDelegate()
        return self
    }
    public func ce_viewControllerBeforeViewController(handle: (pageViewController: UIPageViewController, viewController: UIViewController) -> UIViewController?) -> Self {
        ce._viewControllerBeforeViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_viewControllerAfterViewController(handle: (pageViewController: UIPageViewController, viewController: UIViewController) -> UIViewController?) -> Self {
        ce._viewControllerAfterViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_presentationCountFor(handle: (pageViewController: UIPageViewController) -> Int) -> Self {
        ce._presentationCountFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_presentationIndexFor(handle: (pageViewController: UIPageViewController) -> Int) -> Self {
        ce._presentationIndexFor = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPageViewController_Delegate: UIViewController_Delegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var _willTransitionToViewControllers: ((UIPageViewController, [UIViewController]) -> Void)?
    var _didFinishAnimating: ((UIPageViewController, Bool, [UIViewController], Bool) -> Void)?
    var _spineLocationForInterfaceOrientation: ((UIPageViewController, UIInterfaceOrientation) -> UIPageViewControllerSpineLocation)?
    var _supportedInterfaceOrientations: ((UIPageViewController) -> UIInterfaceOrientationMask)?
    var _preferredInterfaceOrientationForPresentation: ((UIPageViewController) -> UIInterfaceOrientation)?
    var _viewControllerBeforeViewController: ((UIPageViewController, UIViewController) -> UIViewController?)?
    var _viewControllerAfterViewController: ((UIPageViewController, UIViewController) -> UIViewController?)?
    var _presentationCountFor: ((UIPageViewController) -> Int)?
    var _presentationIndexFor: ((UIPageViewController) -> Int)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "pageViewController:willTransitionToViewControllers:" : _willTransitionToViewControllers,
            "pageViewController:didFinishAnimating:previousViewControllers:transitionCompleted:" : _didFinishAnimating,
            "pageViewController:spineLocationForInterfaceOrientation:" : _spineLocationForInterfaceOrientation,
            "pageViewControllerSupportedInterfaceOrientations:" : _supportedInterfaceOrientations,
            "pageViewControllerPreferredInterfaceOrientationForPresentation:" : _preferredInterfaceOrientationForPresentation,
            "pageViewController:viewControllerBeforeViewController:" : _viewControllerBeforeViewController,
            "pageViewController:viewControllerAfterViewController:" : _viewControllerAfterViewController,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "presentationCountForPageViewController:" : _presentationCountFor,
            "presentationIndexForPageViewController:" : _presentationIndexFor,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        _willTransitionToViewControllers!(pageViewController, pendingViewControllers)
    }
    @objc func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        _didFinishAnimating!(pageViewController, finished, previousViewControllers, completed)
    }
    @objc func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        return _spineLocationForInterfaceOrientation!(pageViewController, orientation)
    }
    @objc func pageViewControllerSupportedInterfaceOrientations(pageViewController: UIPageViewController) -> UIInterfaceOrientationMask {
        return _supportedInterfaceOrientations!(pageViewController)
    }
    @objc func pageViewControllerPreferredInterfaceOrientationForPresentation(pageViewController: UIPageViewController) -> UIInterfaceOrientation {
        return _preferredInterfaceOrientationForPresentation!(pageViewController)
    }
    @objc func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return _viewControllerBeforeViewController!(pageViewController, viewController)
    }
    @objc func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return _viewControllerAfterViewController!(pageViewController, viewController)
    }
    @objc func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return _presentationCountFor!(pageViewController)
    }
    @objc func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return _presentationIndexFor!(pageViewController)
    }
}
