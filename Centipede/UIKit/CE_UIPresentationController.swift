//
//  CE_UIPresentationController.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

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
        if let obj: AnyObject = self.delegate {
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
    
    public func ce_adaptivePresentationStyle(handle: ((UIPresentationController) -> UIModalPresentationStyle)) -> Self {
        ce._adaptivePresentationStyle = handle
        rebindingDelegate()
        return self
    }
    public func ce_adaptivePresentationStyle_for(handle: ((UIPresentationController, UITraitCollection) -> UIModalPresentationStyle)) -> Self {
        ce._adaptivePresentationStyle_for = handle
        rebindingDelegate()
        return self
    }
    public func ce_presentationController(handle: ((UIPresentationController, UIModalPresentationStyle) -> UIViewController?)) -> Self {
        ce._presentationController = handle
        rebindingDelegate()
        return self
    }
    public func ce_presentationController_willPresentWithAdaptiveStyle(handle: ((UIPresentationController, UIModalPresentationStyle, UIViewControllerTransitionCoordinator?) -> Void)) -> Self {
        ce._presentationController_willPresentWithAdaptiveStyle = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPresentationController_Delegate: NSObject, UIAdaptivePresentationControllerDelegate {
    
    var _adaptivePresentationStyle: ((UIPresentationController) -> UIModalPresentationStyle)?
    var _adaptivePresentationStyle_for: ((UIPresentationController, UITraitCollection) -> UIModalPresentationStyle)?
    var _presentationController: ((UIPresentationController, UIModalPresentationStyle) -> UIViewController?)?
    var _presentationController_willPresentWithAdaptiveStyle: ((UIPresentationController, UIModalPresentationStyle, UIViewControllerTransitionCoordinator?) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(adaptivePresentationStyle(for:)) : _adaptivePresentationStyle,
            #selector(adaptivePresentationStyle(for:traitCollection:)) : _adaptivePresentationStyle_for,
            #selector(presentationController(_:viewControllerForAdaptivePresentationStyle:)) : _presentationController,
            #selector(presentationController(_:willPresentWithAdaptiveStyle:transitionCoordinator:)) : _presentationController_willPresentWithAdaptiveStyle,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return _adaptivePresentationStyle!(controller)
    }
    @objc func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return _adaptivePresentationStyle_for!(controller, traitCollection)
    }
    @objc func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        return _presentationController!(controller, style)
    }
    @objc func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
        _presentationController_willPresentWithAdaptiveStyle!(presentationController, style, transitionCoordinator)
    }
}
