//
//  CE_UISplitViewController.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension UISplitViewController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UISplitViewController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UISplitViewController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UISplitViewController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
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
    
    @discardableResult
    public func ce_splitViewController_willChangeTo(handle: @escaping (UISplitViewController, UISplitViewControllerDisplayMode) -> Void) -> Self {
        ce._splitViewController_willChangeTo = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_targetDisplayModeForAction_in(handle: @escaping (UISplitViewController) -> UISplitViewControllerDisplayMode) -> Self {
        ce._targetDisplayModeForAction_in = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_splitViewController_show(handle: @escaping (UISplitViewController, UIViewController, Any?) -> Bool) -> Self {
        ce._splitViewController_show = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_splitViewController_showDetail(handle: @escaping (UISplitViewController, UIViewController, Any?) -> Bool) -> Self {
        ce._splitViewController_showDetail = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_primaryViewController_forCollapsing(handle: @escaping (UISplitViewController) -> UIViewController?) -> Self {
        ce._primaryViewController_forCollapsing = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_primaryViewController_forExpanding(handle: @escaping (UISplitViewController) -> UIViewController?) -> Self {
        ce._primaryViewController_forExpanding = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_splitViewController_collapseSecondary(handle: @escaping (UISplitViewController, UIViewController, UIViewController) -> Bool) -> Self {
        ce._splitViewController_collapseSecondary = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_splitViewController_separateSecondaryFrom(handle: @escaping (UISplitViewController, UIViewController) -> UIViewController?) -> Self {
        ce._splitViewController_separateSecondaryFrom = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_splitViewControllerSupportedInterfaceOrientations(handle: @escaping (UISplitViewController) -> UIInterfaceOrientationMask) -> Self {
        ce._splitViewControllerSupportedInterfaceOrientations = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_splitViewControllerPreferredInterfaceOrientationForPresentation(handle: @escaping (UISplitViewController) -> UIInterfaceOrientation) -> Self {
        ce._splitViewControllerPreferredInterfaceOrientationForPresentation = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UISplitViewController_Delegate: UIViewController_Delegate, UISplitViewControllerDelegate {
    
    var _splitViewController_willChangeTo: ((UISplitViewController, UISplitViewControllerDisplayMode) -> Void)?
    var _targetDisplayModeForAction_in: ((UISplitViewController) -> UISplitViewControllerDisplayMode)?
    var _splitViewController_show: ((UISplitViewController, UIViewController, Any?) -> Bool)?
    var _splitViewController_showDetail: ((UISplitViewController, UIViewController, Any?) -> Bool)?
    var _primaryViewController_forCollapsing: ((UISplitViewController) -> UIViewController?)?
    var _primaryViewController_forExpanding: ((UISplitViewController) -> UIViewController?)?
    var _splitViewController_collapseSecondary: ((UISplitViewController, UIViewController, UIViewController) -> Bool)?
    var _splitViewController_separateSecondaryFrom: ((UISplitViewController, UIViewController) -> UIViewController?)?
    var _splitViewControllerSupportedInterfaceOrientations: ((UISplitViewController) -> UIInterfaceOrientationMask)?
    var _splitViewControllerPreferredInterfaceOrientationForPresentation: ((UISplitViewController) -> UIInterfaceOrientation)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(splitViewController(_:willChangeTo:)) : _splitViewController_willChangeTo,
            #selector(targetDisplayModeForAction(in:)) : _targetDisplayModeForAction_in,
            #selector(splitViewController(_:show:sender:)) : _splitViewController_show,
            #selector(splitViewController(_:showDetail:sender:)) : _splitViewController_showDetail,
            #selector(primaryViewController(forCollapsing:)) : _primaryViewController_forCollapsing,
            #selector(primaryViewController(forExpanding:)) : _primaryViewController_forExpanding,
            #selector(splitViewController(_:collapseSecondary:onto:)) : _splitViewController_collapseSecondary,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(splitViewController(_:separateSecondaryFrom:)) : _splitViewController_separateSecondaryFrom,
            #selector(splitViewControllerSupportedInterfaceOrientations(_:)) : _splitViewControllerSupportedInterfaceOrientations,
            #selector(splitViewControllerPreferredInterfaceOrientationForPresentation(_:)) : _splitViewControllerPreferredInterfaceOrientationForPresentation,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewControllerDisplayMode) {
        _splitViewController_willChangeTo!(svc, displayMode)
    }
    @objc func targetDisplayModeForAction(in svc: UISplitViewController) -> UISplitViewControllerDisplayMode {
        return _targetDisplayModeForAction_in!(svc)
    }
    @objc func splitViewController(_ splitViewController: UISplitViewController, show vc: UIViewController, sender: Any?) -> Bool {
        return _splitViewController_show!(splitViewController, vc, sender)
    }
    @objc func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
        return _splitViewController_showDetail!(splitViewController, vc, sender)
    }
    @objc func primaryViewController(forCollapsing splitViewController: UISplitViewController) -> UIViewController? {
        return _primaryViewController_forCollapsing!(splitViewController)
    }
    @objc func primaryViewController(forExpanding splitViewController: UISplitViewController) -> UIViewController? {
        return _primaryViewController_forExpanding!(splitViewController)
    }
    @objc func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return _splitViewController_collapseSecondary!(splitViewController, secondaryViewController, primaryViewController)
    }
    @objc func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        return _splitViewController_separateSecondaryFrom!(splitViewController, primaryViewController)
    }
    @objc func splitViewControllerSupportedInterfaceOrientations(_ splitViewController: UISplitViewController) -> UIInterfaceOrientationMask {
        return _splitViewControllerSupportedInterfaceOrientations!(splitViewController)
    }
    @objc func splitViewControllerPreferredInterfaceOrientationForPresentation(_ splitViewController: UISplitViewController) -> UIInterfaceOrientation {
        return _splitViewControllerPreferredInterfaceOrientationForPresentation!(splitViewController)
    }
}
