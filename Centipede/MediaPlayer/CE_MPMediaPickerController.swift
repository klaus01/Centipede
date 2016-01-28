//
//  CE_MPMediaPickerController.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
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
    
    public func ce_mediaPicker(handle: (mediaPicker: MPMediaPickerController, mediaItemCollection: MPMediaItemCollection) -> Void) -> Self {
        ce._mediaPicker = handle
        rebindingDelegate()
        return self
    }
    public func ce_mediaPickerDidCancel(handle: (mediaPicker: MPMediaPickerController) -> Void) -> Self {
        ce._mediaPickerDidCancel = handle
        rebindingDelegate()
        return self
    }
    
}

internal class MPMediaPickerController_Delegate: UIViewController_Delegate, MPMediaPickerControllerDelegate {
    
    var _mediaPicker: ((MPMediaPickerController, MPMediaItemCollection) -> Void)?
    var _mediaPickerDidCancel: ((MPMediaPickerController) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "mediaPicker:didPickMediaItems:" : _mediaPicker,
            "mediaPickerDidCancel:" : _mediaPickerDidCancel,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        _mediaPicker!(mediaPicker, mediaItemCollection)
    }
    @objc func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
        _mediaPickerDidCancel!(mediaPicker)
    }
}
