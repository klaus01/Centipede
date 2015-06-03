//
//  CE_UISplitViewController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UISplitViewController {
    
    private var ce: UISplitViewController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UISplitViewController_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UISplitViewController_Delegate {
                return delegate as! UISplitViewController_Delegate
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
    
    internal override func getDelegateInstance() -> UISplitViewController_Delegate {
        return UISplitViewController_Delegate()
    }
    
    public func ce_WillChangeToDisplayMode(handle: (svc: UISplitViewController, displayMode: UISplitViewControllerDisplayMode) -> Void) -> Self {
        ce.WillChangeToDisplayMode = handle
        rebindingDelegate()
        return self
    }
    public func ce_TargetDisplayModeForActionIn(handle: (svc: UISplitViewController) -> UISplitViewControllerDisplayMode) -> Self {
        ce.TargetDisplayModeForActionIn = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShowViewController(handle: (splitViewController: UISplitViewController, vc: UIViewController, sender: AnyObject?) -> Bool) -> Self {
        ce.ShowViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShowDetailViewController(handle: (splitViewController: UISplitViewController, vc: UIViewController, sender: AnyObject?) -> Bool) -> Self {
        ce.ShowDetailViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_PrimaryViewControllerForCollapsing(handle: (splitViewController: UISplitViewController) -> UIViewController?) -> Self {
        ce.PrimaryViewControllerForCollapsing = handle
        rebindingDelegate()
        return self
    }
    public func ce_PrimaryViewControllerForExpanding(handle: (splitViewController: UISplitViewController) -> UIViewController?) -> Self {
        ce.PrimaryViewControllerForExpanding = handle
        rebindingDelegate()
        return self
    }
    public func ce_CollapseSecondaryViewController(handle: (splitViewController: UISplitViewController, secondaryViewController: UIViewController!, primaryViewController: UIViewController!) -> Bool) -> Self {
        ce.CollapseSecondaryViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_SeparateSecondaryViewControllerFromPrimaryViewController(handle: (splitViewController: UISplitViewController, primaryViewController: UIViewController!) -> UIViewController?) -> Self {
        ce.SeparateSecondaryViewControllerFromPrimaryViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_SupportedInterfaceOrientations(handle: (splitViewController: UISplitViewController) -> Int) -> Self {
        ce.SupportedInterfaceOrientations = handle
        rebindingDelegate()
        return self
    }
    public func ce_PreferredInterfaceOrientationForPresentation(handle: (splitViewController: UISplitViewController) -> UIInterfaceOrientation) -> Self {
        ce.PreferredInterfaceOrientationForPresentation = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillHideViewController(handle: (svc: UISplitViewController, aViewController: UIViewController, barButtonItem: UIBarButtonItem, pc: UIPopoverController) -> Void) -> Self {
        ce.WillHideViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillShowViewController(handle: (svc: UISplitViewController, aViewController: UIViewController, barButtonItem: UIBarButtonItem) -> Void) -> Self {
        ce.WillShowViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_PopoverController(handle: (svc: UISplitViewController, pc: UIPopoverController, aViewController: UIViewController) -> Void) -> Self {
        ce.PopoverController = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldHideViewController(handle: (svc: UISplitViewController, vc: UIViewController, orientation: UIInterfaceOrientation) -> Bool) -> Self {
        ce.ShouldHideViewController = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UISplitViewController_Delegate: UIViewController_Delegate, UISplitViewControllerDelegate {
    
    var WillChangeToDisplayMode: ((UISplitViewController, UISplitViewControllerDisplayMode) -> Void)?
    var TargetDisplayModeForActionIn: ((UISplitViewController) -> UISplitViewControllerDisplayMode)?
    var ShowViewController: ((UISplitViewController, UIViewController, AnyObject?) -> Bool)?
    var ShowDetailViewController: ((UISplitViewController, UIViewController, AnyObject?) -> Bool)?
    var PrimaryViewControllerForCollapsing: ((UISplitViewController) -> UIViewController?)?
    var PrimaryViewControllerForExpanding: ((UISplitViewController) -> UIViewController?)?
    var CollapseSecondaryViewController: ((UISplitViewController, UIViewController!, UIViewController!) -> Bool)?
    var SeparateSecondaryViewControllerFromPrimaryViewController: ((UISplitViewController, UIViewController!) -> UIViewController?)?
    var SupportedInterfaceOrientations: ((UISplitViewController) -> Int)?
    var PreferredInterfaceOrientationForPresentation: ((UISplitViewController) -> UIInterfaceOrientation)?
    var WillHideViewController: ((UISplitViewController, UIViewController, UIBarButtonItem, UIPopoverController) -> Void)?
    var WillShowViewController: ((UISplitViewController, UIViewController, UIBarButtonItem) -> Void)?
    var PopoverController: ((UISplitViewController, UIPopoverController, UIViewController) -> Void)?
    var ShouldHideViewController: ((UISplitViewController, UIViewController, UIInterfaceOrientation) -> Bool)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "splitViewController:willChangeToDisplayMode:" : WillChangeToDisplayMode,
            "targetDisplayModeForActionInSplitViewController:" : TargetDisplayModeForActionIn,
            "splitViewController:showViewController:sender:" : ShowViewController,
            "splitViewController:showDetailViewController:sender:" : ShowDetailViewController,
            "primaryViewControllerForCollapsingSplitViewController:" : PrimaryViewControllerForCollapsing,
            "primaryViewControllerForExpandingSplitViewController:" : PrimaryViewControllerForExpanding,
            "splitViewController:collapseSecondaryViewController:ontoPrimaryViewController:" : CollapseSecondaryViewController,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "splitViewController:separateSecondaryViewControllerFromPrimaryViewController:" : SeparateSecondaryViewControllerFromPrimaryViewController,
            "splitViewControllerSupportedInterfaceOrientations:" : SupportedInterfaceOrientations,
            "splitViewControllerPreferredInterfaceOrientationForPresentation:" : PreferredInterfaceOrientationForPresentation,
            "splitViewController:willHideViewController:withBarButtonItem:forPopoverController:" : WillHideViewController,
            "splitViewController:willShowViewController:invalidatingBarButtonItem:" : WillShowViewController,
            "splitViewController:popoverController:willPresentViewController:" : PopoverController,
            "splitViewController:shouldHideViewController:inOrientation:" : ShouldHideViewController,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func splitViewController(svc: UISplitViewController, willChangeToDisplayMode displayMode: UISplitViewControllerDisplayMode) {
        WillChangeToDisplayMode!(svc, displayMode)
    }
    @objc func targetDisplayModeForActionInSplitViewController(svc: UISplitViewController) -> UISplitViewControllerDisplayMode {
        return TargetDisplayModeForActionIn!(svc)
    }
    @objc func splitViewController(splitViewController: UISplitViewController, showViewController vc: UIViewController, sender: AnyObject?) -> Bool {
        return ShowViewController!(splitViewController, vc, sender)
    }
    @objc func splitViewController(splitViewController: UISplitViewController, showDetailViewController vc: UIViewController, sender: AnyObject?) -> Bool {
        return ShowDetailViewController!(splitViewController, vc, sender)
    }
    @objc func primaryViewControllerForCollapsingSplitViewController(splitViewController: UISplitViewController) -> UIViewController? {
        return PrimaryViewControllerForCollapsing!(splitViewController)
    }
    @objc func primaryViewControllerForExpandingSplitViewController(splitViewController: UISplitViewController) -> UIViewController? {
        return PrimaryViewControllerForExpanding!(splitViewController)
    }
    @objc func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
        return CollapseSecondaryViewController!(splitViewController, secondaryViewController, primaryViewController)
    }
    @objc func splitViewController(splitViewController: UISplitViewController, separateSecondaryViewControllerFromPrimaryViewController primaryViewController: UIViewController!) -> UIViewController? {
        return SeparateSecondaryViewControllerFromPrimaryViewController!(splitViewController, primaryViewController)
    }
    @objc func splitViewControllerSupportedInterfaceOrientations(splitViewController: UISplitViewController) -> Int {
        return SupportedInterfaceOrientations!(splitViewController)
    }
    @objc func splitViewControllerPreferredInterfaceOrientationForPresentation(splitViewController: UISplitViewController) -> UIInterfaceOrientation {
        return PreferredInterfaceOrientationForPresentation!(splitViewController)
    }
    @objc func splitViewController(svc: UISplitViewController, willHideViewController aViewController: UIViewController, withBarButtonItem barButtonItem: UIBarButtonItem, forPopoverController pc: UIPopoverController) {
        WillHideViewController!(svc, aViewController, barButtonItem, pc)
    }
    @objc func splitViewController(svc: UISplitViewController, willShowViewController aViewController: UIViewController, invalidatingBarButtonItem barButtonItem: UIBarButtonItem) {
        WillShowViewController!(svc, aViewController, barButtonItem)
    }
    @objc func splitViewController(svc: UISplitViewController, popoverController pc: UIPopoverController, willPresentViewController aViewController: UIViewController) {
        PopoverController!(svc, pc, aViewController)
    }
    @objc func splitViewController(svc: UISplitViewController, shouldHideViewController vc: UIViewController, inOrientation orientation: UIInterfaceOrientation) -> Bool {
        return ShouldHideViewController!(svc, vc, orientation)
    }
}
