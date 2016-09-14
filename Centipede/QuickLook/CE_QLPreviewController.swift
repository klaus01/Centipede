//
//  CE_QLPreviewController.swift
//  Centipede
//
//  Created by kelei on 2016/9/14.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import QuickLook

public extension QLPreviewController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: QLPreviewController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? QLPreviewController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
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
    
    public func ce_numberOfPreviewItems_in(handle: @escaping (QLPreviewController) -> Int) -> Self {
        ce._numberOfPreviewItems_in = handle
        rebindingDelegate()
        return self
    }
    public func ce_previewController_previewItemAt(handle: @escaping (QLPreviewController, Int) -> QLPreviewItem) -> Self {
        ce._previewController_previewItemAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_previewControllerWillDismiss(handle: @escaping (QLPreviewController) -> Void) -> Self {
        ce._previewControllerWillDismiss = handle
        rebindingDelegate()
        return self
    }
    public func ce_previewControllerDidDismiss(handle: @escaping (QLPreviewController) -> Void) -> Self {
        ce._previewControllerDidDismiss = handle
        rebindingDelegate()
        return self
    }
    public func ce_previewController_shouldOpen(handle: @escaping (QLPreviewController, URL, QLPreviewItem) -> Bool) -> Self {
        ce._previewController_shouldOpen = handle
        rebindingDelegate()
        return self
    }
    public func ce_previewController_frameFor(handle: @escaping (QLPreviewController, QLPreviewItem, AutoreleasingUnsafeMutablePointer<UIView?>) -> CGRect) -> Self {
        ce._previewController_frameFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_previewController_transitionImageFor(handle: @escaping (QLPreviewController, QLPreviewItem, UnsafeMutablePointer<CGRect>) -> UIImage) -> Self {
        ce._previewController_transitionImageFor = handle
        rebindingDelegate()
        return self
    }
    
}

internal class QLPreviewController_Delegate: UIViewController_Delegate, QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    
    var _numberOfPreviewItems_in: ((QLPreviewController) -> Int)?
    var _previewController_previewItemAt: ((QLPreviewController, Int) -> QLPreviewItem)?
    var _previewControllerWillDismiss: ((QLPreviewController) -> Void)?
    var _previewControllerDidDismiss: ((QLPreviewController) -> Void)?
    var _previewController_shouldOpen: ((QLPreviewController, URL, QLPreviewItem) -> Bool)?
    var _previewController_frameFor: ((QLPreviewController, QLPreviewItem, AutoreleasingUnsafeMutablePointer<UIView?>) -> CGRect)?
    var _previewController_transitionImageFor: ((QLPreviewController, QLPreviewItem, UnsafeMutablePointer<CGRect>) -> UIImage)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(numberOfPreviewItems(in:)) : _numberOfPreviewItems_in,
            #selector(previewController(_:previewItemAt:)) : _previewController_previewItemAt,
            #selector(previewControllerWillDismiss(_:)) : _previewControllerWillDismiss,
            #selector(previewControllerDidDismiss(_:)) : _previewControllerDidDismiss,
            #selector(previewController(_:shouldOpen:for:)) : _previewController_shouldOpen,
            #selector(previewController(_:frameFor:inSourceView:)) : _previewController_frameFor,
            #selector(previewController(_:transitionImageFor:contentRect:)) : _previewController_transitionImageFor,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return _numberOfPreviewItems_in!(controller)
    }
    @objc func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return _previewController_previewItemAt!(controller, index)
    }
    @objc func previewControllerWillDismiss(_ controller: QLPreviewController) {
        _previewControllerWillDismiss!(controller)
    }
    @objc func previewControllerDidDismiss(_ controller: QLPreviewController) {
        _previewControllerDidDismiss!(controller)
    }
    @objc func previewController(_ controller: QLPreviewController, shouldOpen url: URL, for item: QLPreviewItem) -> Bool {
        return _previewController_shouldOpen!(controller, url, item)
    }
    @objc func previewController(_ controller: QLPreviewController, frameFor item: QLPreviewItem, inSourceView view: AutoreleasingUnsafeMutablePointer<UIView?>) -> CGRect {
        return _previewController_frameFor!(controller, item, view)
    }
    @objc func previewController(_ controller: QLPreviewController, transitionImageFor item: QLPreviewItem, contentRect: UnsafeMutablePointer<CGRect>) -> UIImage {
        return _previewController_transitionImageFor!(controller, item, contentRect)
    }
}
