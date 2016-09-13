//
//  CE_Stream.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import Foundation

public extension Stream {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: Stream_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? Stream_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: Stream_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is Stream_Delegate {
                return obj as! Stream_Delegate
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
    
    internal func getDelegateInstance() -> Stream_Delegate {
        return Stream_Delegate()
    }
    
    public func ce_s(handle: ((Stream, Stream) -> Void)) -> Self {
        ce._s = handle
        rebindingDelegate()
        return self
    }
    
}

internal class Stream_Delegate: NSObject, StreamDelegate {
    
    var _s: ((Stream, Stream) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(stream(_:handle:)) : _s,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func stream(_ aStream: Stream, handle eventCode: Stream) {
        _s!(aStream, eventCode)
    }
}
