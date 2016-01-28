//
//  CE_UIPresentationController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
public extension UIPresentationController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIPresentationController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIPresentationController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIPresentationController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is UIPresentationController_Delegate {
                return obj as! UIPresentationController_Delegate
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
    }
    
    internal func getDelegateInstance() -> UIPresentationController_Delegate {
        return UIPresentationController_Delegate()
    }
    
    public func ce_adaptivePresentationStyleFor(handle: (controller: UIPresentationController) -> UIModalPresentationStyle) -> Self {
        ce._adaptivePresentationStyleFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_adaptivePresentationStyleForAndTraitCollection(handle: (controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle) -> Self {
        ce._adaptivePresentationStyleForAndTraitCollection = handle
        rebindingDelegate()
        return self
    }
    public func ce_viewControllerForAdaptivePresentationStyle(handle: (controller: UIPresentationController, style: UIModalPresentationStyle) -> UIViewController?) -> Self {
        ce._viewControllerForAdaptivePresentationStyle = handle
        rebindingDelegate()
        return self
    }
    public func ce_willPresentWithAdaptiveStyle(handle: (presentationController: UIPresentationController, style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) -> Void) -> Self {
        ce._willPresentWithAdaptiveStyle = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPresentationController_Delegate: NSObject, UIAdaptivePresentationControllerDelegate {
    
    var _adaptivePresentationStyleFor: ((UIPresentationController) -> UIModalPresentationStyle)?
    var _adaptivePresentationStyleForAndTraitCollection: ((UIPresentationController, UITraitCollection) -> UIModalPresentationStyle)?
    var _viewControllerForAdaptivePresentationStyle: ((UIPresentationController, UIModalPresentationStyle) -> UIViewController?)?
    var _willPresentWithAdaptiveStyle: ((UIPresentationController, UIModalPresentationStyle, UIViewControllerTransitionCoordinator?) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "adaptivePresentationStyleForPresentationController:" : _adaptivePresentationStyleFor,
            "adaptivePresentationStyleForPresentationController:traitCollection:" : _adaptivePresentationStyleForAndTraitCollection,
            "presentationController:viewControllerForAdaptivePresentationStyle:" : _viewControllerForAdaptivePresentationStyle,
            "presentationController:willPresentWithAdaptiveStyle:transitionCoordinator:" : _willPresentWithAdaptiveStyle,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return _adaptivePresentationStyleFor!(controller)
    }
    @objc func adaptivePresentationStyleForPresentationController(controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return _adaptivePresentationStyleForAndTraitCollection!(controller, traitCollection)
    }
    @objc func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        return _viewControllerForAdaptivePresentationStyle!(controller, style)
    }
    @objc func presentationController(presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
        _willPresentWithAdaptiveStyle!(presentationController, style, transitionCoordinator)
    }
}
