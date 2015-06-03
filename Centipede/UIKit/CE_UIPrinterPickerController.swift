//
//  CE_UIPrinterPickerController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UIPrinterPickerController {
    
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
    
    public func ce_ParentViewController(handle: (printerPickerController: UIPrinterPickerController) -> UIViewController!) -> Self {
        ce.ParentViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldShowPrinter(handle: (printerPickerController: UIPrinterPickerController, printer: UIPrinter) -> Bool) -> Self {
        ce.ShouldShowPrinter = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillPresent(handle: (printerPickerController: UIPrinterPickerController) -> Void) -> Self {
        ce.WillPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidPresent(handle: (printerPickerController: UIPrinterPickerController) -> Void) -> Self {
        ce.DidPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillDismiss(handle: (printerPickerController: UIPrinterPickerController) -> Void) -> Self {
        ce.WillDismiss = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidDismiss(handle: (printerPickerController: UIPrinterPickerController) -> Void) -> Self {
        ce.DidDismiss = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidSelectPrinter(handle: (printerPickerController: UIPrinterPickerController) -> Void) -> Self {
        ce.DidSelectPrinter = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPrinterPickerController_Delegate: NSObject, UIPrinterPickerControllerDelegate {
    
    var ParentViewController: ((UIPrinterPickerController) -> UIViewController!)?
    var ShouldShowPrinter: ((UIPrinterPickerController, UIPrinter) -> Bool)?
    var WillPresent: ((UIPrinterPickerController) -> Void)?
    var DidPresent: ((UIPrinterPickerController) -> Void)?
    var WillDismiss: ((UIPrinterPickerController) -> Void)?
    var DidDismiss: ((UIPrinterPickerController) -> Void)?
    var DidSelectPrinter: ((UIPrinterPickerController) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "printerPickerControllerParentViewController:" : ParentViewController,
            "printerPickerController:shouldShowPrinter:" : ShouldShowPrinter,
            "printerPickerControllerWillPresent:" : WillPresent,
            "printerPickerControllerDidPresent:" : DidPresent,
            "printerPickerControllerWillDismiss:" : WillDismiss,
            "printerPickerControllerDidDismiss:" : DidDismiss,
            "printerPickerControllerDidSelectPrinter:" : DidSelectPrinter,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func printerPickerControllerParentViewController(printerPickerController: UIPrinterPickerController) -> UIViewController! {
        return ParentViewController!(printerPickerController)
    }
    @objc func printerPickerController(printerPickerController: UIPrinterPickerController, shouldShowPrinter printer: UIPrinter) -> Bool {
        return ShouldShowPrinter!(printerPickerController, printer)
    }
    @objc func printerPickerControllerWillPresent(printerPickerController: UIPrinterPickerController) {
        WillPresent!(printerPickerController)
    }
    @objc func printerPickerControllerDidPresent(printerPickerController: UIPrinterPickerController) {
        DidPresent!(printerPickerController)
    }
    @objc func printerPickerControllerWillDismiss(printerPickerController: UIPrinterPickerController) {
        WillDismiss!(printerPickerController)
    }
    @objc func printerPickerControllerDidDismiss(printerPickerController: UIPrinterPickerController) {
        DidDismiss!(printerPickerController)
    }
    @objc func printerPickerControllerDidSelectPrinter(printerPickerController: UIPrinterPickerController) {
        DidSelectPrinter!(printerPickerController)
    }
}
