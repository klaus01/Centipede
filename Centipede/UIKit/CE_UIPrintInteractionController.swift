//
//  CE_UIPrintInteractionController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UIPrintInteractionController {
    
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
    
    public func ce_ParentViewController(handle: (printInteractionController: UIPrintInteractionController) -> UIViewController?) -> Self {
        ce.ParentViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_ChoosePaper(handle: (printInteractionController: UIPrintInteractionController, paperList: [AnyObject]) -> UIPrintPaper?) -> Self {
        ce.ChoosePaper = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillPresentPrinterOptions(handle: (printInteractionController: UIPrintInteractionController) -> Void) -> Self {
        ce.WillPresentPrinterOptions = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidPresentPrinterOptions(handle: (printInteractionController: UIPrintInteractionController) -> Void) -> Self {
        ce.DidPresentPrinterOptions = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillDismissPrinterOptions(handle: (printInteractionController: UIPrintInteractionController) -> Void) -> Self {
        ce.WillDismissPrinterOptions = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidDismissPrinterOptions(handle: (printInteractionController: UIPrintInteractionController) -> Void) -> Self {
        ce.DidDismissPrinterOptions = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillStartJob(handle: (printInteractionController: UIPrintInteractionController) -> Void) -> Self {
        ce.WillStartJob = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidFinishJob(handle: (printInteractionController: UIPrintInteractionController) -> Void) -> Self {
        ce.DidFinishJob = handle
        rebindingDelegate()
        return self
    }
    public func ce_CutLengthForPaper(handle: (printInteractionController: UIPrintInteractionController, paper: UIPrintPaper) -> CGFloat) -> Self {
        ce.CutLengthForPaper = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPrintInteractionController_Delegate: NSObject, UIPrintInteractionControllerDelegate {
    
    var ParentViewController: ((UIPrintInteractionController) -> UIViewController?)?
    var ChoosePaper: ((UIPrintInteractionController, [AnyObject]) -> UIPrintPaper?)?
    var WillPresentPrinterOptions: ((UIPrintInteractionController) -> Void)?
    var DidPresentPrinterOptions: ((UIPrintInteractionController) -> Void)?
    var WillDismissPrinterOptions: ((UIPrintInteractionController) -> Void)?
    var DidDismissPrinterOptions: ((UIPrintInteractionController) -> Void)?
    var WillStartJob: ((UIPrintInteractionController) -> Void)?
    var DidFinishJob: ((UIPrintInteractionController) -> Void)?
    var CutLengthForPaper: ((UIPrintInteractionController, UIPrintPaper) -> CGFloat)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "printInteractionControllerParentViewController:" : ParentViewController,
            "printInteractionController:choosePaper:" : ChoosePaper,
            "printInteractionControllerWillPresentPrinterOptions:" : WillPresentPrinterOptions,
            "printInteractionControllerDidPresentPrinterOptions:" : DidPresentPrinterOptions,
            "printInteractionControllerWillDismissPrinterOptions:" : WillDismissPrinterOptions,
            "printInteractionControllerDidDismissPrinterOptions:" : DidDismissPrinterOptions,
            "printInteractionControllerWillStartJob:" : WillStartJob,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "printInteractionControllerDidFinishJob:" : DidFinishJob,
            "printInteractionController:cutLengthForPaper:" : CutLengthForPaper,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func printInteractionControllerParentViewController(printInteractionController: UIPrintInteractionController) -> UIViewController? {
        return ParentViewController!(printInteractionController)
    }
    @objc func printInteractionController(printInteractionController: UIPrintInteractionController, choosePaper paperList: [AnyObject]) -> UIPrintPaper? {
        return ChoosePaper!(printInteractionController, paperList)
    }
    @objc func printInteractionControllerWillPresentPrinterOptions(printInteractionController: UIPrintInteractionController) {
        WillPresentPrinterOptions!(printInteractionController)
    }
    @objc func printInteractionControllerDidPresentPrinterOptions(printInteractionController: UIPrintInteractionController) {
        DidPresentPrinterOptions!(printInteractionController)
    }
    @objc func printInteractionControllerWillDismissPrinterOptions(printInteractionController: UIPrintInteractionController) {
        WillDismissPrinterOptions!(printInteractionController)
    }
    @objc func printInteractionControllerDidDismissPrinterOptions(printInteractionController: UIPrintInteractionController) {
        DidDismissPrinterOptions!(printInteractionController)
    }
    @objc func printInteractionControllerWillStartJob(printInteractionController: UIPrintInteractionController) {
        WillStartJob!(printInteractionController)
    }
    @objc func printInteractionControllerDidFinishJob(printInteractionController: UIPrintInteractionController) {
        DidFinishJob!(printInteractionController)
    }
    @objc func printInteractionController(printInteractionController: UIPrintInteractionController, cutLengthForPaper paper: UIPrintPaper) -> CGFloat {
        return CutLengthForPaper!(printInteractionController, paper)
    }
}
