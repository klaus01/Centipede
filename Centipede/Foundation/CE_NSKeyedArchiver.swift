//
//  CE_NSKeyedArchiver.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import Foundation

extension NSKeyedArchiver {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NSKeyedArchiver_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NSKeyedArchiver_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: NSKeyedArchiver_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is NSKeyedArchiver_Delegate {
                return obj as! NSKeyedArchiver_Delegate
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
    
    internal func getDelegateInstance() -> NSKeyedArchiver_Delegate {
        return NSKeyedArchiver_Delegate()
    }
    
    @discardableResult
    public func ce_archiver_willEncode(handle: @escaping (NSKeyedArchiver, Any) -> Any?) -> Self {
        ce._archiver_willEncode = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_archiver_didEncode(handle: @escaping (NSKeyedArchiver, Any?) -> Void) -> Self {
        ce._archiver_didEncode = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_archiver_willReplace(handle: @escaping (NSKeyedArchiver, Any?, Any?) -> Void) -> Self {
        ce._archiver_willReplace = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_archiverWillFinish(handle: @escaping (NSKeyedArchiver) -> Void) -> Self {
        ce._archiverWillFinish = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_archiverDidFinish(handle: @escaping (NSKeyedArchiver) -> Void) -> Self {
        ce._archiverDidFinish = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSKeyedArchiver_Delegate: NSObject, NSKeyedArchiverDelegate {
    
    var _archiver_willEncode: ((NSKeyedArchiver, Any) -> Any?)?
    var _archiver_didEncode: ((NSKeyedArchiver, Any?) -> Void)?
    var _archiver_willReplace: ((NSKeyedArchiver, Any?, Any?) -> Void)?
    var _archiverWillFinish: ((NSKeyedArchiver) -> Void)?
    var _archiverDidFinish: ((NSKeyedArchiver) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(archiver(_:willEncode:)) : _archiver_willEncode,
            #selector(archiver(_:didEncode:)) : _archiver_didEncode,
            #selector(archiver(_:willReplace:with:)) : _archiver_willReplace,
            #selector(archiverWillFinish(_:)) : _archiverWillFinish,
            #selector(archiverDidFinish(_:)) : _archiverDidFinish,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func archiver(_ archiver: NSKeyedArchiver, willEncode object: Any) -> Any? {
        return _archiver_willEncode!(archiver, object)
    }
    @objc func archiver(_ archiver: NSKeyedArchiver, didEncode object: Any?) {
        _archiver_didEncode!(archiver, object)
    }
    @objc func archiver(_ archiver: NSKeyedArchiver, willReplace object: Any?, with newObject: Any?) {
        _archiver_willReplace!(archiver, object, newObject)
    }
    @objc func archiverWillFinish(_ archiver: NSKeyedArchiver) {
        _archiverWillFinish!(archiver)
    }
    @objc func archiverDidFinish(_ archiver: NSKeyedArchiver) {
        _archiverDidFinish!(archiver)
    }
}
