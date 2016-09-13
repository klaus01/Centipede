//
//  CE_UIPrintInteractionController.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension UIPrintInteractionController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIPrintInteractionController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIPrintInteractionController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIPrintInteractionController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is UIPrintInteractionController_Delegate {
                return obj as! UIPrintInteractionController_Delegate
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
    
    internal func getDelegateInstance() -> UIPrintInteractionController_Delegate {
        return UIPrintInteractionController_Delegate()
    }
    
    public func ce_printInteractionControllerParentViewController(handle: ((UIPrintInteractionController) -> UIViewController?)) -> Self {
        ce._printInteractionControllerParentViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_printInteractionController(handle: ((UIPrintInteractionController, [UIPrintPaper]) -> UIPrintPaper)) -> Self {
        ce._printInteractionController = handle
        rebindingDelegate()
        return self
    }
    public func ce_printInteractionControllerWillPresentPrinterOptions(handle: ((UIPrintInteractionController) -> Void)) -> Self {
        ce._printInteractionControllerWillPresentPrinterOptions = handle
        rebindingDelegate()
        return self
    }
    public func ce_printInteractionControllerDidPresentPrinterOptions(handle: ((UIPrintInteractionController) -> Void)) -> Self {
        ce._printInteractionControllerDidPresentPrinterOptions = handle
        rebindingDelegate()
        return self
    }
    public func ce_printInteractionControllerWillDismissPrinterOptions(handle: ((UIPrintInteractionController) -> Void)) -> Self {
        ce._printInteractionControllerWillDismissPrinterOptions = handle
        rebindingDelegate()
        return self
    }
    public func ce_printInteractionControllerDidDismissPrinterOptions(handle: ((UIPrintInteractionController) -> Void)) -> Self {
        ce._printInteractionControllerDidDismissPrinterOptions = handle
        rebindingDelegate()
        return self
    }
    public func ce_printInteractionControllerWillStartJob(handle: ((UIPrintInteractionController) -> Void)) -> Self {
        ce._printInteractionControllerWillStartJob = handle
        rebindingDelegate()
        return self
    }
    public func ce_printInteractionControllerDidFinishJob(handle: ((UIPrintInteractionController) -> Void)) -> Self {
        ce._printInteractionControllerDidFinishJob = handle
        rebindingDelegate()
        return self
    }
    public func ce_printInteractionController_cutLengthFor(handle: ((UIPrintInteractionController, UIPrintPaper) -> CGFloat)) -> Self {
        ce._printInteractionController_cutLengthFor = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPrintInteractionController_Delegate: NSObject, UIPrintInteractionControllerDelegate {
    
    var _printInteractionControllerParentViewController: ((UIPrintInteractionController) -> UIViewController?)?
    var _printInteractionController: ((UIPrintInteractionController, [UIPrintPaper]) -> UIPrintPaper)?
    var _printInteractionControllerWillPresentPrinterOptions: ((UIPrintInteractionController) -> Void)?
    var _printInteractionControllerDidPresentPrinterOptions: ((UIPrintInteractionController) -> Void)?
    var _printInteractionControllerWillDismissPrinterOptions: ((UIPrintInteractionController) -> Void)?
    var _printInteractionControllerDidDismissPrinterOptions: ((UIPrintInteractionController) -> Void)?
    var _printInteractionControllerWillStartJob: ((UIPrintInteractionController) -> Void)?
    var _printInteractionControllerDidFinishJob: ((UIPrintInteractionController) -> Void)?
    var _printInteractionController_cutLengthFor: ((UIPrintInteractionController, UIPrintPaper) -> CGFloat)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(printInteractionControllerParentViewController(_:)) : _printInteractionControllerParentViewController,
            #selector(printInteractionController(_:choosePaper:)) : _printInteractionController,
            #selector(printInteractionControllerWillPresentPrinterOptions(_:)) : _printInteractionControllerWillPresentPrinterOptions,
            #selector(printInteractionControllerDidPresentPrinterOptions(_:)) : _printInteractionControllerDidPresentPrinterOptions,
            #selector(printInteractionControllerWillDismissPrinterOptions(_:)) : _printInteractionControllerWillDismissPrinterOptions,
            #selector(printInteractionControllerDidDismissPrinterOptions(_:)) : _printInteractionControllerDidDismissPrinterOptions,
            #selector(printInteractionControllerWillStartJob(_:)) : _printInteractionControllerWillStartJob,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(printInteractionControllerDidFinishJob(_:)) : _printInteractionControllerDidFinishJob,
            #selector(printInteractionController(_:cutLengthFor:)) : _printInteractionController_cutLengthFor,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func printInteractionControllerParentViewController(_ printInteractionController: UIPrintInteractionController) -> UIViewController? {
        return _printInteractionControllerParentViewController!(printInteractionController)
    }
    @objc func printInteractionController(_ printInteractionController: UIPrintInteractionController, choosePaper paperList: [UIPrintPaper]) -> UIPrintPaper {
        return _printInteractionController!(printInteractionController, paperList)
    }
    @objc func printInteractionControllerWillPresentPrinterOptions(_ printInteractionController: UIPrintInteractionController) {
        _printInteractionControllerWillPresentPrinterOptions!(printInteractionController)
    }
    @objc func printInteractionControllerDidPresentPrinterOptions(_ printInteractionController: UIPrintInteractionController) {
        _printInteractionControllerDidPresentPrinterOptions!(printInteractionController)
    }
    @objc func printInteractionControllerWillDismissPrinterOptions(_ printInteractionController: UIPrintInteractionController) {
        _printInteractionControllerWillDismissPrinterOptions!(printInteractionController)
    }
    @objc func printInteractionControllerDidDismissPrinterOptions(_ printInteractionController: UIPrintInteractionController) {
        _printInteractionControllerDidDismissPrinterOptions!(printInteractionController)
    }
    @objc func printInteractionControllerWillStartJob(_ printInteractionController: UIPrintInteractionController) {
        _printInteractionControllerWillStartJob!(printInteractionController)
    }
    @objc func printInteractionControllerDidFinishJob(_ printInteractionController: UIPrintInteractionController) {
        _printInteractionControllerDidFinishJob!(printInteractionController)
    }
    @objc func printInteractionController(_ printInteractionController: UIPrintInteractionController, cutLengthFor paper: UIPrintPaper) -> CGFloat {
        return _printInteractionController_cutLengthFor!(printInteractionController, paper)
    }
}
