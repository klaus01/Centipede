//
//  CE_NSCache.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import Foundation

public extension NSCache {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NSCache_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NSCache_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: NSCache_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is NSCache_Delegate {
                return obj as! NSCache_Delegate
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
    
    internal func getDelegateInstance() -> NSCache_Delegate {
        return NSCache_Delegate()
    }
    
    public func ce_willEvictObject(handle: (cache: NSCache, obj: AnyObject) -> Void) -> Self {
        ce._willEvictObject = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSCache_Delegate: NSObject, NSCacheDelegate {
    
    var _willEvictObject: ((NSCache, AnyObject) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "cache:willEvictObject:" : _willEvictObject,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func cache(cache: NSCache, willEvictObject obj: AnyObject) {
        _willEvictObject!(cache, obj)
    }
}
