//
//  CE_UIPrintInteractionController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
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
        if let obj = self.delegate {
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
    
    public func ce_parentViewController(handle: (printInteractionController: UIPrintInteractionController) -> UIViewController) -> Self {
        ce._parentViewController = handle
        rebindingDelegate()
        return self
    }
    public func ce_choosePaper(handle: (printInteractionController: UIPrintInteractionController, paperList: [UIPrintPaper]) -> UIPrintPaper) -> Self {
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
    
    var _parentViewController: ((UIPrintInteractionController) -> UIViewController)?
    var _choosePaper: ((UIPrintInteractionController, [UIPrintPaper]) -> UIPrintPaper)?
    var _willPresentPrinterOptions: ((UIPrintInteractionController) -> Void)?
    var _didPresentPrinterOptions: ((UIPrintInteractionController) -> Void)?
    var _willDismissPrinterOptions: ((UIPrintInteractionController) -> Void)?
    var _didDismissPrinterOptions: ((UIPrintInteractionController) -> Void)?
    var _willStartJob: ((UIPrintInteractionController) -> Void)?
    var _didFinishJob: ((UIPrintInteractionController) -> Void)?
    var _cutLengthForPaper: ((UIPrintInteractionController, UIPrintPaper) -> CGFloat)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(printInteractionControllerParentViewController(_:)) : _parentViewController,
            #selector(printInteractionController(_:choosePaper:)) : _choosePaper,
            #selector(printInteractionControllerWillPresentPrinterOptions(_:)) : _willPresentPrinterOptions,
            #selector(printInteractionControllerDidPresentPrinterOptions(_:)) : _didPresentPrinterOptions,
            #selector(printInteractionControllerWillDismissPrinterOptions(_:)) : _willDismissPrinterOptions,
            #selector(printInteractionControllerDidDismissPrinterOptions(_:)) : _didDismissPrinterOptions,
            #selector(printInteractionControllerWillStartJob(_:)) : _willStartJob,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(printInteractionControllerDidFinishJob(_:)) : _didFinishJob,
            #selector(printInteractionController(_:cutLengthForPaper:)) : _cutLengthForPaper,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func printInteractionControllerParentViewController(printInteractionController: UIPrintInteractionController) -> UIViewController {
        return _parentViewController!(printInteractionController)
    }
    @objc func printInteractionController(printInteractionController: UIPrintInteractionController, choosePaper paperList: [UIPrintPaper]) -> UIPrintPaper {
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
