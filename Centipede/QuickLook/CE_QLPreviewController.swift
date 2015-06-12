//
//  CE_QLPreviewController.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import QuickLook

public extension QLPreviewController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: QLPreviewController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? QLPreviewController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: QLPreviewController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is QLPreviewController_Delegate {
                return obj as! QLPreviewController_Delegate
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
        self.dataSource = nil
        self.dataSource = delegate
    }
    
    internal override func getDelegateInstance() -> QLPreviewController_Delegate {
        return QLPreviewController_Delegate()
    }
    
    public func ce_numberOfPreviewItemsIn(handle: (controller: QLPreviewController) -> Int) -> Self {
        ce._numberOfPreviewItemsIn = handle
        rebindingDelegate()
        return self
    }
    public func ce_previewItemAtIndex(handle: (controller: QLPreviewController, index: Int) -> QLPreviewItem!) -> Self {
        ce._previewItemAtIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_willDismiss(handle: (controller: QLPreviewController) -> Void) -> Self {
        ce._willDismiss = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDismiss(handle: (controller: QLPreviewController) -> Void) -> Self {
        ce._didDismiss = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldOpenURL(handle: (controller: QLPreviewController, url: NSURL!, item: QLPreviewItem!) -> Bool) -> Self {
        ce._shouldOpenURL = handle
        rebindingDelegate()
        return self
    }
    public func ce_frameForPreviewItem(handle: (controller: QLPreviewController, item: QLPreviewItem!, view: AutoreleasingUnsafeMutablePointer<UIView?>) -> CGRect) -> Self {
        ce._frameForPreviewItem = handle
        rebindingDelegate()
        return self
    }
    public func ce_transitionImageForPreviewItem(handle: (controller: QLPreviewController, item: QLPreviewItem!, contentRect: UnsafeMutablePointer<CGRect>) -> UIImage!) -> Self {
        ce._transitionImageForPreviewItem = handle
        rebindingDelegate()
        return self
    }
    
}

internal class QLPreviewController_Delegate: UIViewController_Delegate, QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    
    var _numberOfPreviewItemsIn: ((QLPreviewController) -> Int)?
    var _previewItemAtIndex: ((QLPreviewController, Int) -> QLPreviewItem!)?
    var _willDismiss: ((QLPreviewController) -> Void)?
    var _didDismiss: ((QLPreviewController) -> Void)?
    var _shouldOpenURL: ((QLPreviewController, NSURL!, QLPreviewItem!) -> Bool)?
    var _frameForPreviewItem: ((QLPreviewController, QLPreviewItem!, AutoreleasingUnsafeMutablePointer<UIView?>) -> CGRect)?
    var _transitionImageForPreviewItem: ((QLPreviewController, QLPreviewItem!, UnsafeMutablePointer<CGRect>) -> UIImage!)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "numberOfPreviewItemsInPreviewController:" : _numberOfPreviewItemsIn,
            "previewController:previewItemAtIndex:" : _previewItemAtIndex,
            "previewControllerWillDismiss:" : _willDismiss,
            "previewControllerDidDismiss:" : _didDismiss,
            "previewController:shouldOpenURL:forPreviewItem:" : _shouldOpenURL,
            "previewController:frameForPreviewItem:inSourceView:" : _frameForPreviewItem,
            "previewController:transitionImageForPreviewItem:contentRect:" : _transitionImageForPreviewItem,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func numberOfPreviewItemsInPreviewController(controller: QLPreviewController) -> Int {
        return _numberOfPreviewItemsIn!(controller)
    }
    @objc func previewController(controller: QLPreviewController, previewItemAtIndex index: Int) -> QLPreviewItem! {
        return _previewItemAtIndex!(controller, index)
    }
    @objc func previewControllerWillDismiss(controller: QLPreviewController) {
        _willDismiss!(controller)
    }
    @objc func previewControllerDidDismiss(controller: QLPreviewController) {
        _didDismiss!(controller)
    }
    @objc func previewController(controller: QLPreviewController, shouldOpenURL url: NSURL!, forPreviewItem item: QLPreviewItem!) -> Bool {
        return _shouldOpenURL!(controller, url, item)
    }
    @objc func previewController(controller: QLPreviewController, frameForPreviewItem item: QLPreviewItem!, inSourceView view: AutoreleasingUnsafeMutablePointer<UIView?>) -> CGRect {
        return _frameForPreviewItem!(controller, item, view)
    }
    @objc func previewController(controller: QLPreviewController, transitionImageForPreviewItem item: QLPreviewItem!, contentRect: UnsafeMutablePointer<CGRect>) -> UIImage! {
        return _transitionImageForPreviewItem!(controller, item, contentRect)
    }
}
