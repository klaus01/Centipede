//
//  CE_NSStream.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import Foundation

public extension NSStream {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NSStream_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NSStream_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: NSStream_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is NSStream_Delegate {
                return obj as! NSStream_Delegate
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
    
    internal func getDelegateInstance() -> NSStream_Delegate {
        return NSStream_Delegate()
    }
    
    public func ce_handleEvent(handle: (aStream: NSStream, eventCode: NSStreamEvent) -> Void) -> Self {
        ce._handleEvent = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSStream_Delegate: NSObject, NSStreamDelegate {
    
    var _handleEvent: ((NSStream, NSStreamEvent) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "stream:handleEvent:" : _handleEvent,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        _handleEvent!(aStream, eventCode)
    }
}
