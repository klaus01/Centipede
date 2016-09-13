//
//  CE_UIPageViewController.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
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
        if let obj: AnyObject = self.delegate {
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
    
    public func ce_pageViewController_willTransitionTo(handle: ((UIPageViewController, [UIViewController]) -> Void)) -> Self {
        ce._pageViewController_willTransitionTo = handle
        rebindingDelegate()
        return self
    }
    public func ce_pageViewController_didFinishAnimating(handle: ((UIPageViewController, Bool, [UIViewController], Bool) -> Void)) -> Self {
        ce._pageViewController_didFinishAnimating = handle
        rebindingDelegate()
        return self
    }
    public func ce_pageViewController_spineLocationFor(handle: ((UIPageViewController, UIInterfaceOrientation) -> UIPageViewControllerSpineLocation)) -> Self {
        ce._pageViewController_spineLocationFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_pageViewControllerSupportedInterfaceOrientations(handle: ((UIPageViewController) -> UIInterfaceOrientationMask)) -> Self {
        ce._pageViewControllerSupportedInterfaceOrientations = handle
        rebindingDelegate()
        return self
    }
    public func ce_pageViewControllerPreferredInterfaceOrientationForPresentation(handle: ((UIPageViewController) -> UIInterfaceOrientation)) -> Self {
        ce._pageViewControllerPreferredInterfaceOrientationForPresentation = handle
        rebindingDelegate()
        return self
    }
    public func ce_pageViewController_viewControllerBefore(handle: ((UIPageViewController, UIViewController) -> UIViewController?)) -> Self {
        ce._pageViewController_viewControllerBefore = handle
        rebindingDelegate()
        return self
    }
    public func ce_pageViewController_viewControllerAfter(handle: ((UIPageViewController, UIViewController) -> UIViewController?)) -> Self {
        ce._pageViewController_viewControllerAfter = handle
        rebindingDelegate()
        return self
    }
    public func ce_presentationCount_for(handle: ((UIPageViewController) -> Int)) -> Self {
        ce._presentationCount_for = handle
        rebindingDelegate()
        return self
    }
    public func ce_presentationIndex_for(handle: ((UIPageViewController) -> Int)) -> Self {
        ce._presentationIndex_for = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPageViewController_Delegate: UIViewController_Delegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var _pageViewController_willTransitionTo: ((UIPageViewController, [UIViewController]) -> Void)?
    var _pageViewController_didFinishAnimating: ((UIPageViewController, Bool, [UIViewController], Bool) -> Void)?
    var _pageViewController_spineLocationFor: ((UIPageViewController, UIInterfaceOrientation) -> UIPageViewControllerSpineLocation)?
    var _pageViewControllerSupportedInterfaceOrientations: ((UIPageViewController) -> UIInterfaceOrientationMask)?
    var _pageViewControllerPreferredInterfaceOrientationForPresentation: ((UIPageViewController) -> UIInterfaceOrientation)?
    var _pageViewController_viewControllerBefore: ((UIPageViewController, UIViewController) -> UIViewController?)?
    var _pageViewController_viewControllerAfter: ((UIPageViewController, UIViewController) -> UIViewController?)?
    var _presentationCount_for: ((UIPageViewController) -> Int)?
    var _presentationIndex_for: ((UIPageViewController) -> Int)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(pageViewController(_:willTransitionTo:)) : _pageViewController_willTransitionTo,
            #selector(pageViewController(_:didFinishAnimating:previousViewControllers:transitionCompleted:)) : _pageViewController_didFinishAnimating,
            #selector(pageViewController(_:spineLocationFor:)) : _pageViewController_spineLocationFor,
            #selector(pageViewControllerSupportedInterfaceOrientations(_:)) : _pageViewControllerSupportedInterfaceOrientations,
            #selector(pageViewControllerPreferredInterfaceOrientationForPresentation(_:)) : _pageViewControllerPreferredInterfaceOrientationForPresentation,
            #selector(pageViewController(_:viewControllerBefore:)) : _pageViewController_viewControllerBefore,
            #selector(pageViewController(_:viewControllerAfter:)) : _pageViewController_viewControllerAfter,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(presentationCount(for:)) : _presentationCount_for,
            #selector(presentationIndex(for:)) : _presentationIndex_for,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        _pageViewController_willTransitionTo!(pageViewController, pendingViewControllers)
    }
    @objc func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        _pageViewController_didFinishAnimating!(pageViewController, finished, previousViewControllers, completed)
    }
    @objc func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        return _pageViewController_spineLocationFor!(pageViewController, orientation)
    }
    @objc func pageViewControllerSupportedInterfaceOrientations(_ pageViewController: UIPageViewController) -> UIInterfaceOrientationMask {
        return _pageViewControllerSupportedInterfaceOrientations!(pageViewController)
    }
    @objc func pageViewControllerPreferredInterfaceOrientationForPresentation(_ pageViewController: UIPageViewController) -> UIInterfaceOrientation {
        return _pageViewControllerPreferredInterfaceOrientationForPresentation!(pageViewController)
    }
    @objc func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return _pageViewController_viewControllerBefore!(pageViewController, viewController)
    }
    @objc func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return _pageViewController_viewControllerAfter!(pageViewController, viewController)
    }
    @objc func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return _presentationCount_for!(pageViewController)
    }
    @objc func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return _presentationIndex_for!(pageViewController)
    }
}
