//
//  CE_UIPrinterPickerController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UIPrinterPickerController {
    
    private var ce: UIPrinterPickerController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIPrinterPickerController_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UIPrinterPickerController_Delegate {
                return delegate as! UIPrinterPickerController_Delegate
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
    }
    
    internal func getDelegateInstance() -> UIPrinterPickerController_Delegate {
        return UIPrinterPickerController_Delegate()
    }
    
    public func ce_parentViewController(handle: (printerPickerController: UIPrinterPickerController) -> UIViewController!) -> Self {
        ce._parentViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldShowPrinter(handle: (printerPickerController: UIPrinterPickerController, printer: UIPrinter) -> Bool) -> Self {
        ce._shouldShowPrinter = handle
        rebindingDelegate()
        return self
    }
    public func ce_willPresent(handle: (printerPickerController: UIPrinterPickerController) -> Void) -> Self {
        ce._willPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_didPresent(handle: (printerPickerController: UIPrinterPickerController) -> Void) -> Self {
        ce._didPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_willDismiss(handle: (printerPickerController: UIPrinterPickerController) -> Void) -> Self {
        ce._willDismiss = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDismiss(handle: (printerPickerController: UIPrinterPickerController) -> Void) -> Self {
        ce._didDismiss = handle
        rebindingDelegate()
        return self
    }
    public func ce_didSelectPrinter(handle: (printerPickerController: UIPrinterPickerController) -> Void) -> Self {
        ce._didSelectPrinter = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPrinterPickerController_Delegate: NSObject, UIPrinterPickerControllerDelegate {
    
    var _parentViewController: ((UIPrinterPickerController) -> UIViewController!)?
    var _shouldShowPrinter: ((UIPrinterPickerController, UIPrinter) -> Bool)?
    var _willPresent: ((UIPrinterPickerController) -> Void)?
    var _didPresent: ((UIPrinterPickerController) -> Void)?
    var _willDismiss: ((UIPrinterPickerController) -> Void)?
    var _didDismiss: ((UIPrinterPickerController) -> Void)?
    var _didSelectPrinter: ((UIPrinterPickerController) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "printerPickerControllerParentViewController:" : _parentViewController,
            "printerPickerController:shouldShowPrinter:" : _shouldShowPrinter,
            "printerPickerControllerWillPresent:" : _willPresent,
            "printerPickerControllerDidPresent:" : _didPresent,
            "printerPickerControllerWillDismiss:" : _willDismiss,
            "printerPickerControllerDidDismiss:" : _didDismiss,
            "printerPickerControllerDidSelectPrinter:" : _didSelectPrinter,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func printerPickerControllerParentViewController(printerPickerController: UIPrinterPickerController) -> UIViewController! {
        return _parentViewController!(printerPickerController)
    }
    @objc func printerPickerController(printerPickerController: UIPrinterPickerController, shouldShowPrinter printer: UIPrinter) -> Bool {
        return _shouldShowPrinter!(printerPickerController, printer)
    }
    @objc func printerPickerControllerWillPresent(printerPickerController: UIPrinterPickerController) {
        _willPresent!(printerPickerController)
    }
    @objc func printerPickerControllerDidPresent(printerPickerController: UIPrinterPickerController) {
        _didPresent!(printerPickerController)
    }
    @objc func printerPickerControllerWillDismiss(printerPickerController: UIPrinterPickerController) {
        _willDismiss!(printerPickerController)
    }
    @objc func printerPickerControllerDidDismiss(printerPickerController: UIPrinterPickerController) {
        _didDismiss!(printerPickerController)
    }
    @objc func printerPickerControllerDidSelectPrinter(printerPickerController: UIPrinterPickerController) {
        _didSelectPrinter!(printerPickerController)
    }
}
