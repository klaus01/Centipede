//
//  CE_UIPrintInteractionController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UIPrintInteractionController {
    
    private var ce: UIPrintInteractionController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIPrintInteractionController_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UIPrintInteractionController_Delegate {
                return delegate as! UIPrintInteractionController_Delegate
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
    
    internal func getDelegateInstance() -> UIPrintInteractionController_Delegate {
        return UIPrintInteractionController_Delegate()
    }
    
    public func ce_parentViewController(handle: (printInteractionController: UIPrintInteractionController) -> UIViewController?) -> Self {
        ce._parentViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_choosePaper(handle: (printInteractionController: UIPrintInteractionController, paperList: [AnyObject]) -> UIPrintPaper?) -> Self {
        ce._choosePaper = handle
        rebindingDelegate()
        return self
    }
    public func ce_willPresentPrinterOptions(handle: (printInteractionController: UIPrintInteractionController) -> Void) -> Self {
        ce._willPresentPrinterOptions = handle
        rebindingDelegate()
        return self
    }
    public func ce_didPresentPrinterOptions(handle: (printInteractionController: UIPrintInteractionController) -> Void) -> Self {
        ce._didPresentPrinterOptions = handle
        rebindingDelegate()
        return self
    }
    public func ce_willDismissPrinterOptions(handle: (printInteractionController: UIPrintInteractionController) -> Void) -> Self {
        ce._willDismissPrinterOptions = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDismissPrinterOptions(handle: (printInteractionController: UIPrintInteractionController) -> Void) -> Self {
        ce._didDismissPrinterOptions = handle
        rebindingDelegate()
        return self
    }
    public func ce_willStartJob(handle: (printInteractionController: UIPrintInteractionController) -> Void) -> Self {
        ce._willStartJob = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFinishJob(handle: (printInteractionController: UIPrintInteractionController) -> Void) -> Self {
        ce._didFinishJob = handle
        rebindingDelegate()
        return self
    }
    public func ce_cutLengthForPaper(handle: (printInteractionController: UIPrintInteractionController, paper: UIPrintPaper) -> CGFloat) -> Self {
        ce._cutLengthForPaper = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPrintInteractionController_Delegate: NSObject, UIPrintInteractionControllerDelegate {
    
    var _parentViewController: ((UIPrintInteractionController) -> UIViewController?)?
    var _choosePaper: ((UIPrintInteractionController, [AnyObject]) -> UIPrintPaper?)?
    var _willPresentPrinterOptions: ((UIPrintInteractionController) -> Void)?
    var _didPresentPrinterOptions: ((UIPrintInteractionController) -> Void)?
    var _willDismissPrinterOptions: ((UIPrintInteractionController) -> Void)?
    var _didDismissPrinterOptions: ((UIPrintInteractionController) -> Void)?
    var _willStartJob: ((UIPrintInteractionController) -> Void)?
    var _didFinishJob: ((UIPrintInteractionController) -> Void)?
    var _cutLengthForPaper: ((UIPrintInteractionController, UIPrintPaper) -> CGFloat)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "printInteractionControllerParentViewController:" : _parentViewController,
            "printInteractionController:choosePaper:" : _choosePaper,
            "printInteractionControllerWillPresentPrinterOptions:" : _willPresentPrinterOptions,
            "printInteractionControllerDidPresentPrinterOptions:" : _didPresentPrinterOptions,
            "printInteractionControllerWillDismissPrinterOptions:" : _willDismissPrinterOptions,
            "printInteractionControllerDidDismissPrinterOptions:" : _didDismissPrinterOptions,
            "printInteractionControllerWillStartJob:" : _willStartJob,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "printInteractionControllerDidFinishJob:" : _didFinishJob,
            "printInteractionController:cutLengthForPaper:" : _cutLengthForPaper,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func printInteractionControllerParentViewController(printInteractionController: UIPrintInteractionController) -> UIViewController? {
        return _parentViewController!(printInteractionController)
    }
    @objc func printInteractionController(printInteractionController: UIPrintInteractionController, choosePaper paperList: [AnyObject]) -> UIPrintPaper? {
        return _choosePaper!(printInteractionController, paperList)
    }
    @objc func printInteractionControllerWillPresentPrinterOptions(printInteractionController: UIPrintInteractionController) {
        _willPresentPrinterOptions!(printInteractionController)
    }
    @objc func printInteractionControllerDidPresentPrinterOptions(printInteractionController: UIPrintInteractionController) {
        _didPresentPrinterOptions!(printInteractionController)
    }
    @objc func printInteractionControllerWillDismissPrinterOptions(printInteractionController: UIPrintInteractionController) {
        _willDismissPrinterOptions!(printInteractionController)
    }
    @objc func printInteractionControllerDidDismissPrinterOptions(printInteractionController: UIPrintInteractionController) {
        _didDismissPrinterOptions!(printInteractionController)
    }
    @objc func printInteractionControllerWillStartJob(printInteractionController: UIPrintInteractionController) {
        _willStartJob!(printInteractionController)
    }
    @objc func printInteractionControllerDidFinishJob(printInteractionController: UIPrintInteractionController) {
        _didFinishJob!(printInteractionController)
    }
    @objc func printInteractionController(printInteractionController: UIPrintInteractionController, cutLengthForPaper paper: UIPrintPaper) -> CGFloat {
        return _cutLengthForPaper!(printInteractionController, paper)
    }
}
