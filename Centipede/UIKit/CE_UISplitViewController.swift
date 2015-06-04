//
//  CE_UISplitViewController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UISplitViewController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UISplitViewController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UISplitViewController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: UISplitViewController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is UISplitViewController_Delegate {
                return obj as! UISplitViewController_Delegate
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
    
    internal override func getDelegateInstance() -> UISplitViewController_Delegate {
        return UISplitViewController_Delegate()
    }
    
    public func ce_willChangeToDisplayMode(handle: (svc: UISplitViewController, displayMode: UISplitViewControllerDisplayMode) -> Void) -> Self {
        ce._willChangeToDisplayMode = handle
        rebindingDelegate()
        return self
    }
    public func ce_targetDisplayModeForActionIn(handle: (svc: UISplitViewController) -> UISplitViewControllerDisplayMode) -> Self {
        ce._targetDisplayModeForActionIn = handle
        rebindingDelegate()
        return self
    }
    public func ce_showViewController(handle: (splitViewController: UISplitViewController, vc: UIViewController, sender: AnyObject?) -> Bool) -> Self {
        ce._showViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_showDetailViewController(handle: (splitViewController: UISplitViewController, vc: UIViewController, sender: AnyObject?) -> Bool) -> Self {
        ce._showDetailViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_primaryViewControllerForCollapsing(handle: (splitViewController: UISplitViewController) -> UIViewController?) -> Self {
        ce._primaryViewControllerForCollapsing = handle
        rebindingDelegate()
        return self
    }
    public func ce_primaryViewControllerForExpanding(handle: (splitViewController: UISplitViewController) -> UIViewController?) -> Self {
        ce._primaryViewControllerForExpanding = handle
        rebindingDelegate()
        return self
    }
    public func ce_collapseSecondaryViewController(handle: (splitViewController: UISplitViewController, secondaryViewController: UIViewController!, primaryViewController: UIViewController!) -> Bool) -> Self {
        ce._collapseSecondaryViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_separateSecondaryViewControllerFromPrimaryViewController(handle: (splitViewController: UISplitViewController, primaryViewController: UIViewController!) -> UIViewController?) -> Self {
        ce._separateSecondaryViewControllerFromPrimaryViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_supportedInterfaceOrientations(handle: (splitViewController: UISplitViewController) -> Int) -> Self {
        ce._supportedInterfaceOrientations = handle
        rebindingDelegate()
        return self
    }
    public func ce_preferredInterfaceOrientationForPresentation(handle: (splitViewController: UISplitViewController) -> UIInterfaceOrientation) -> Self {
        ce._preferredInterfaceOrientationForPresentation = handle
        rebindingDelegate()
        return self
    }
    public func ce_willHideViewController(handle: (svc: UISplitViewController, aViewController: UIViewController, barButtonItem: UIBarButtonItem, pc: UIPopoverController) -> Void) -> Self {
        ce._willHideViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_willShowViewController(handle: (svc: UISplitViewController, aViewController: UIViewController, barButtonItem: UIBarButtonItem) -> Void) -> Self {
        ce._willShowViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_popoverController(handle: (svc: UISplitViewController, pc: UIPopoverController, aViewController: UIViewController) -> Void) -> Self {
        ce._popoverController = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldHideViewController(handle: (svc: UISplitViewController, vc: UIViewController, orientation: UIInterfaceOrientation) -> Bool) -> Self {
        ce._shouldHideViewController = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UISplitViewController_Delegate: UIViewController_Delegate, UISplitViewControllerDelegate {
    
    var _willChangeToDisplayMode: ((UISplitViewController, UISplitViewControllerDisplayMode) -> Void)?
    var _targetDisplayModeForActionIn: ((UISplitViewController) -> UISplitViewControllerDisplayMode)?
    var _showViewController: ((UISplitViewController, UIViewController, AnyObject?) -> Bool)?
    var _showDetailViewController: ((UISplitViewController, UIViewController, AnyObject?) -> Bool)?
    var _primaryViewControllerForCollapsing: ((UISplitViewController) -> UIViewController?)?
    var _primaryViewControllerForExpanding: ((UISplitViewController) -> UIViewController?)?
    var _collapseSecondaryViewController: ((UISplitViewController, UIViewController!, UIViewController!) -> Bool)?
    var _separateSecondaryViewControllerFromPrimaryViewController: ((UISplitViewController, UIViewController!) -> UIViewController?)?
    var _supportedInterfaceOrientations: ((UISplitViewController) -> Int)?
    var _preferredInterfaceOrientationForPresentation: ((UISplitViewController) -> UIInterfaceOrientation)?
    var _willHideViewController: ((UISplitViewController, UIViewController, UIBarButtonItem, UIPopoverController) -> Void)?
    var _willShowViewController: ((UISplitViewController, UIViewController, UIBarButtonItem) -> Void)?
    var _popoverController: ((UISplitViewController, UIPopoverController, UIViewController) -> Void)?
    var _shouldHideViewController: ((UISplitViewController, UIViewController, UIInterfaceOrientation) -> Bool)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "splitViewController:willChangeToDisplayMode:" : _willChangeToDisplayMode,
            "targetDisplayModeForActionInSplitViewController:" : _targetDisplayModeForActionIn,
            "splitViewController:showViewController:sender:" : _showViewController,
            "splitViewController:showDetailViewController:sender:" : _showDetailViewController,
            "primaryViewControllerForCollapsingSplitViewController:" : _primaryViewControllerForCollapsing,
            "primaryViewControllerForExpandingSplitViewController:" : _primaryViewControllerForExpanding,
            "splitViewController:collapseSecondaryViewController:ontoPrimaryViewController:" : _collapseSecondaryViewController,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "splitViewController:separateSecondaryViewControllerFromPrimaryViewController:" : _separateSecondaryViewControllerFromPrimaryViewController,
            "splitViewControllerSupportedInterfaceOrientations:" : _supportedInterfaceOrientations,
            "splitViewControllerPreferredInterfaceOrientationForPresentation:" : _preferredInterfaceOrientationForPresentation,
            "splitViewController:willHideViewController:withBarButtonItem:forPopoverController:" : _willHideViewController,
            "splitViewController:willShowViewController:invalidatingBarButtonItem:" : _willShowViewController,
            "splitViewController:popoverController:willPresentViewController:" : _popoverController,
            "splitViewController:shouldHideViewController:inOrientation:" : _shouldHideViewController,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func splitViewController(svc: UISplitViewController, willChangeToDisplayMode displayMode: UISplitViewControllerDisplayMode) {
        _willChangeToDisplayMode!(svc, displayMode)
    }
    @objc func targetDisplayModeForActionInSplitViewController(svc: UISplitViewController) -> UISplitViewControllerDisplayMode {
        return _targetDisplayModeForActionIn!(svc)
    }
    @objc func splitViewController(splitViewController: UISplitViewController, showViewController vc: UIViewController, sender: AnyObject?) -> Bool {
        return _showViewController!(splitViewController, vc, sender)
    }
    @objc func splitViewController(splitViewController: UISplitViewController, showDetailViewController vc: UIViewController, sender: AnyObject?) -> Bool {
        return _showDetailViewController!(splitViewController, vc, sender)
    }
    @objc func primaryViewControllerForCollapsingSplitViewController(splitViewController: UISplitViewController) -> UIViewController? {
        return _primaryViewControllerForCollapsing!(splitViewController)
    }
    @objc func primaryViewControllerForExpandingSplitViewController(splitViewController: UISplitViewController) -> UIViewController? {
        return _primaryViewControllerForExpanding!(splitViewController)
    }
    @objc func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
        return _collapseSecondaryViewController!(splitViewController, secondaryViewController, primaryViewController)
    }
    @objc func splitViewController(splitViewController: UISplitViewController, separateSecondaryViewControllerFromPrimaryViewController primaryViewController: UIViewController!) -> UIViewController? {
        return _separateSecondaryViewControllerFromPrimaryViewController!(splitViewController, primaryViewController)
    }
    @objc func splitViewControllerSupportedInterfaceOrientations(splitViewController: UISplitViewController) -> Int {
        return _supportedInterfaceOrientations!(splitViewController)
    }
    @objc func splitViewControllerPreferredInterfaceOrientationForPresentation(splitViewController: UISplitViewController) -> UIInterfaceOrientation {
        return _preferredInterfaceOrientationForPresentation!(splitViewController)
    }
    @objc func splitViewController(svc: UISplitViewController, willHideViewController aViewController: UIViewController, withBarButtonItem barButtonItem: UIBarButtonItem, forPopoverController pc: UIPopoverController) {
        _willHideViewController!(svc, aViewController, barButtonItem, pc)
    }
    @objc func splitViewController(svc: UISplitViewController, willShowViewController aViewController: UIViewController, invalidatingBarButtonItem barButtonItem: UIBarButtonItem) {
        _willShowViewController!(svc, aViewController, barButtonItem)
    }
    @objc func splitViewController(svc: UISplitViewController, popoverController pc: UIPopoverController, willPresentViewController aViewController: UIViewController) {
        _popoverController!(svc, pc, aViewController)
    }
    @objc func splitViewController(svc: UISplitViewController, shouldHideViewController vc: UIViewController, inOrientation orientation: UIInterfaceOrientation) -> Bool {
        return _shouldHideViewController!(svc, vc, orientation)
    }
}
