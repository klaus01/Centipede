//
//  CE_NSKeyedUnarchiver.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import Foundation

public extension NSKeyedUnarchiver {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NSKeyedUnarchiver_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NSKeyedUnarchiver_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: NSKeyedUnarchiver_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is NSKeyedUnarchiver_Delegate {
                return obj as! NSKeyedUnarchiver_Delegate
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
    
    internal func getDelegateInstance() -> NSKeyedUnarchiver_Delegate {
        return NSKeyedUnarchiver_Delegate()
    }
    
    public func ce_unarchiver(handle: (unarchiver: NSKeyedUnarchiver, name: String, classNames: [AnyObject]) -> AnyClass) -> Self {
        ce._unarchiver = handle
        rebindingDelegate()
        return self
    }
    public func ce_unarchiverAndDidDecodeObject(handle: (unarchiver: NSKeyedUnarchiver, object: AnyObject?) -> AnyObject?) -> Self {
        ce._unarchiverAndDidDecodeObject = handle
        rebindingDelegate()
        return self
    }
    public func ce_unarchiverAndWillReplaceObject(handle: (unarchiver: NSKeyedUnarchiver, object: AnyObject, newObject: AnyObject) -> Void) -> Self {
        ce._unarchiverAndWillReplaceObject = handle
        rebindingDelegate()
        return self
    }
    public func ce_unarchiverWillFinish(handle: (unarchiver: NSKeyedUnarchiver) -> Void) -> Self {
        ce._unarchiverWillFinish = handle
        rebindingDelegate()
        return self
    }
    public func ce_unarchiverDidFinish(handle: (unarchiver: NSKeyedUnarchiver) -> Void) -> Self {
        ce._unarchiverDidFinish = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSKeyedUnarchiver_Delegate: NSObject, NSKeyedUnarchiverDelegate {
    
    var _unarchiver: ((NSKeyedUnarchiver, String, [AnyObject]) -> AnyClass)?
    var _unarchiverAndDidDecodeObject: ((NSKeyedUnarchiver, AnyObject?) -> AnyObject?)?
    var _unarchiverAndWillReplaceObject: ((NSKeyedUnarchiver, AnyObject, AnyObject) -> Void)?
    var _unarchiverWillFinish: ((NSKeyedUnarchiver) -> Void)?
    var _unarchiverDidFinish: ((NSKeyedUnarchiver) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "unarchiver:cannotDecodeObjectOfClassName:originalClasses:" : _unarchiver,
            "unarchiver:didDecodeObject:" : _unarchiverAndDidDecodeObject,
            "unarchiver:willReplaceObject:withObject:" : _unarchiverAndWillReplaceObject,
            "unarchiverWillFinish:" : _unarchiverWillFinish,
            "unarchiverDidFinish:" : _unarchiverDidFinish,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func unarchiver(unarchiver: NSKeyedUnarchiver, cannotDecodeObjectOfClassName name: String, originalClasses classNames: [AnyObject]) -> AnyClass {
        return _unarchiver!(unarchiver, name, classNames)
    }
    @objc func unarchiver(unarchiver: NSKeyedUnarchiver, didDecodeObject object: AnyObject?) -> AnyObject? {
        return _unarchiverAndDidDecodeObject!(unarchiver, object)
    }
    @objc func unarchiver(unarchiver: NSKeyedUnarchiver, willReplaceObject object: AnyObject, withObject newObject: AnyObject) {
        _unarchiverAndWillReplaceObject!(unarchiver, object, newObject)
    }
    @objc func unarchiverWillFinish(unarchiver: NSKeyedUnarchiver) {
        _unarchiverWillFinish!(unarchiver)
    }
    @objc func unarchiverDidFinish(unarchiver: NSKeyedUnarchiver) {
        _unarchiverDidFinish!(unarchiver)
    }
}
