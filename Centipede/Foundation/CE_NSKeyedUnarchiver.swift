//
//  CE_NSKeyedUnarchiver.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import Foundation

public extension NSKeyedUnarchiver {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NSKeyedUnarchiver_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NSKeyedUnarchiver_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
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
    
    @discardableResult
    public func ce_unarchiver_cannotDecodeObjectOfClassName(handle: @escaping (NSKeyedUnarchiver, String, [String]) -> AnyClass?) -> Self {
        ce._unarchiver_cannotDecodeObjectOfClassName = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_unarchiver_didDecode(handle: @escaping (NSKeyedUnarchiver, Any?) -> Any?) -> Self {
        ce._unarchiver_didDecode = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_unarchiver_willReplace(handle: @escaping (NSKeyedUnarchiver, Any, Any) -> Void) -> Self {
        ce._unarchiver_willReplace = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_unarchiverWillFinish(handle: @escaping (NSKeyedUnarchiver) -> Void) -> Self {
        ce._unarchiverWillFinish = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_unarchiverDidFinish(handle: @escaping (NSKeyedUnarchiver) -> Void) -> Self {
        ce._unarchiverDidFinish = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSKeyedUnarchiver_Delegate: NSObject, NSKeyedUnarchiverDelegate {
    
    var _unarchiver_cannotDecodeObjectOfClassName: ((NSKeyedUnarchiver, String, [String]) -> AnyClass?)?
    var _unarchiver_didDecode: ((NSKeyedUnarchiver, Any?) -> Any?)?
    var _unarchiver_willReplace: ((NSKeyedUnarchiver, Any, Any) -> Void)?
    var _unarchiverWillFinish: ((NSKeyedUnarchiver) -> Void)?
    var _unarchiverDidFinish: ((NSKeyedUnarchiver) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(unarchiver(_:cannotDecodeObjectOfClassName:originalClasses:)) : _unarchiver_cannotDecodeObjectOfClassName,
            #selector(unarchiver(_:didDecode:)) : _unarchiver_didDecode,
            #selector(unarchiver(_:willReplace:with:)) : _unarchiver_willReplace,
            #selector(unarchiverWillFinish(_:)) : _unarchiverWillFinish,
            #selector(unarchiverDidFinish(_:)) : _unarchiverDidFinish,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func unarchiver(_ unarchiver: NSKeyedUnarchiver, cannotDecodeObjectOfClassName name: String, originalClasses classNames: [String]) -> AnyClass? {
        return _unarchiver_cannotDecodeObjectOfClassName!(unarchiver, name, classNames)
    }
    @objc func unarchiver(_ unarchiver: NSKeyedUnarchiver, didDecode object: Any?) -> Any? {
        return _unarchiver_didDecode!(unarchiver, object)
    }
    @objc func unarchiver(_ unarchiver: NSKeyedUnarchiver, willReplace object: Any, with newObject: Any) {
        _unarchiver_willReplace!(unarchiver, object, newObject)
    }
    @objc func unarchiverWillFinish(_ unarchiver: NSKeyedUnarchiver) {
        _unarchiverWillFinish!(unarchiver)
    }
    @objc func unarchiverDidFinish(_ unarchiver: NSKeyedUnarchiver) {
        _unarchiverDidFinish!(unarchiver)
    }
}
