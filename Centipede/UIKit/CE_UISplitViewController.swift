//
//  CE_UISplitViewController.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
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
    
    public func ce_splitViewController(handle: ((UISplitViewController, UISplitViewControllerDisplayMode) -> Void)) -> Self {
        ce._splitViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_targetDisplayModeForAction(handle: ((UISplitViewController) -> UISplitViewControllerDisplayMode)) -> Self {
        ce._targetDisplayModeForAction = handle
        rebindingDelegate()
        return self
    }
    public func ce_splitViewController_show(handle: ((UISplitViewController, UIViewController, Any?) -> Bool)) -> Self {
        ce._splitViewController_show = handle
        rebindingDelegate()
        return self
    }
    public func ce_splitViewController_showDetail(handle: ((UISplitViewController, UIViewController, Any?) -> Bool)) -> Self {
        ce._splitViewController_showDetail = handle
        rebindingDelegate()
        return self
    }
    public func ce_primaryViewController(handle: ((UISplitViewController) -> UIViewController?)) -> Self {
        ce._primaryViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_primaryViewController_forExpanding(handle: ((UISplitViewController) -> UIViewController?)) -> Self {
        ce._primaryViewController_forExpanding = handle
        rebindingDelegate()
        return self
    }
    public func ce_splitViewController_collapseSecondary(handle: ((UISplitViewController, UIViewController, UIViewController) -> Bool)) -> Self {
        ce._splitViewController_collapseSecondary = handle
        rebindingDelegate()
        return self
    }
    public func ce_splitViewController_separateSecondaryFrom(handle: ((UISplitViewController, UIViewController) -> UIViewController?)) -> Self {
        ce._splitViewController_separateSecondaryFrom = handle
        rebindingDelegate()
        return self
    }
    public func ce_splitViewControllerSupportedInterfaceOrientations(handle: ((UISplitViewController) -> UIInterfaceOrientationMask)) -> Self {
        ce._splitViewControllerSupportedInterfaceOrientations = handle
        rebindingDelegate()
        return self
    }
    public func ce_splitViewControllerPreferredInterfaceOrientationForPresentation(handle: ((UISplitViewController) -> UIInterfaceOrientation)) -> Self {
        ce._splitViewControllerPreferredInterfaceOrientationForPresentation = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UISplitViewController_Delegate: UIViewController_Delegate, UISplitViewControllerDelegate {
    
    var _splitViewController: ((UISplitViewController, UISplitViewControllerDisplayMode) -> Void)?
    var _targetDisplayModeForAction: ((UISplitViewController) -> UISplitViewControllerDisplayMode)?
    var _splitViewController_show: ((UISplitViewController, UIViewController, Any?) -> Bool)?
    var _splitViewController_showDetail: ((UISplitViewController, UIViewController, Any?) -> Bool)?
    var _primaryViewController: ((UISplitViewController) -> UIViewController?)?
    var _primaryViewController_forExpanding: ((UISplitViewController) -> UIViewController?)?
    var _splitViewController_collapseSecondary: ((UISplitViewController, UIViewController, UIViewController) -> Bool)?
    var _splitViewController_separateSecondaryFrom: ((UISplitViewController, UIViewController) -> UIViewController?)?
    var _splitViewControllerSupportedInterfaceOrientations: ((UISplitViewController) -> UIInterfaceOrientationMask)?
    var _splitViewControllerPreferredInterfaceOrientationForPresentation: ((UISplitViewController) -> UIInterfaceOrientation)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(splitViewController(_:willChangeTo:)) : _splitViewController,
            #selector(targetDisplayModeForAction(in:)) : _targetDisplayModeForAction,
            #selector(splitViewController(_:show:sender:)) : _splitViewController_show,
            #selector(splitViewController(_:showDetail:sender:)) : _splitViewController_showDetail,
            #selector(primaryViewController(forCollapsing:)) : _primaryViewController,
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
        _splitViewController!(svc, displayMode)
    }
    @objc func targetDisplayModeForAction(in svc: UISplitViewController) -> UISplitViewControllerDisplayMode {
        return _targetDisplayModeForAction!(svc)
    }
    @objc func splitViewController(_ splitViewController: UISplitViewController, show vc: UIViewController, sender: Any?) -> Bool {
        return _splitViewController_show!(splitViewController, vc, sender)
    }
    @objc func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
        return _splitViewController_showDetail!(splitViewController, vc, sender)
    }
    @objc func primaryViewController(forCollapsing splitViewController: UISplitViewController) -> UIViewController? {
        return _primaryViewController!(splitViewController)
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
