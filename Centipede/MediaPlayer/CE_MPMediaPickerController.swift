//
//  CE_MPMediaPickerController.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import MediaPlayer

public extension MPMediaPickerController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: MPMediaPickerController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? MPMediaPickerController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: MPMediaPickerController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is MPMediaPickerController_Delegate {
                return obj as! MPMediaPickerController_Delegate
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
    
    internal override func getDelegateInstance() -> MPMediaPickerController_Delegate {
        return MPMediaPickerController_Delegate()
    }
    
    @discardableResult
    public func ce_mediaPicker_didPickMediaItems(handle: @escaping (MPMediaPickerController, MPMediaItemCollection) -> Void) -> Self {
        ce._mediaPicker_didPickMediaItems = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_mediaPickerDidCancel(handle: @escaping (MPMediaPickerController) -> Void) -> Self {
        ce._mediaPickerDidCancel = handle
        rebindingDelegate()
        return self
    }
    
}

internal class MPMediaPickerController_Delegate: UIViewController_Delegate, MPMediaPickerControllerDelegate {
    
    var _mediaPicker_didPickMediaItems: ((MPMediaPickerController, MPMediaItemCollection) -> Void)?
    var _mediaPickerDidCancel: ((MPMediaPickerController) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(mediaPicker(_:didPickMediaItems:)) : _mediaPicker_didPickMediaItems,
            #selector(mediaPickerDidCancel(_:)) : _mediaPickerDidCancel,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        _mediaPicker_didPickMediaItems!(mediaPicker, mediaItemCollection)
    }
    @objc func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        _mediaPickerDidCancel!(mediaPicker)
    }
}
