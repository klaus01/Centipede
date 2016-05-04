//
//  CE_NSKeyedArchiver.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import Foundation

public extension NSKeyedArchiver {
    
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
    
    public func ce_archiver(handle: (archiver: NSKeyedArchiver, object: AnyObject) -> AnyObject?) -> Self {
        ce._archiver = handle
        rebindingDelegate()
        return self
    }
    public func ce_archiverAndDidEncodeObject(handle: (archiver: NSKeyedArchiver, object: AnyObject?) -> Void) -> Self {
        ce._archiverAndDidEncodeObject = handle
        rebindingDelegate()
        return self
    }
    public func ce_archiverAndWillReplaceObject(handle: (archiver: NSKeyedArchiver, object: AnyObject?, newObject: AnyObject?) -> Void) -> Self {
        ce._archiverAndWillReplaceObject = handle
        rebindingDelegate()
        return self
    }
    public func ce_archiverWillFinish(handle: (archiver: NSKeyedArchiver) -> Void) -> Self {
        ce._archiverWillFinish = handle
        rebindingDelegate()
        return self
    }
    public func ce_archiverDidFinish(handle: (archiver: NSKeyedArchiver) -> Void) -> Self {
        ce._archiverDidFinish = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSKeyedArchiver_Delegate: NSObject, NSKeyedArchiverDelegate {
    
    var _archiver: ((NSKeyedArchiver, AnyObject) -> AnyObject?)?
    var _archiverAndDidEncodeObject: ((NSKeyedArchiver, AnyObject?) -> Void)?
    var _archiverAndWillReplaceObject: ((NSKeyedArchiver, AnyObject?, AnyObject?) -> Void)?
    var _archiverWillFinish: ((NSKeyedArchiver) -> Void)?
    var _archiverDidFinish: ((NSKeyedArchiver) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(archiver(_:willEncodeObject:)) : _archiver,
            #selector(archiver(_:didEncodeObject:)) : _archiverAndDidEncodeObject,
            #selector(archiver(_:willReplaceObject:withObject:)) : _archiverAndWillReplaceObject,
            #selector(archiverWillFinish(_:)) : _archiverWillFinish,
            #selector(archiverDidFinish(_:)) : _archiverDidFinish,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func archiver(archiver: NSKeyedArchiver, willEncodeObject object: AnyObject) -> AnyObject? {
        return _archiver!(archiver, object)
    }
    @objc func archiver(archiver: NSKeyedArchiver, didEncodeObject object: AnyObject?) {
        _archiverAndDidEncodeObject!(archiver, object)
    }
    @objc func archiver(archiver: NSKeyedArchiver, willReplaceObject object: AnyObject?, withObject newObject: AnyObject?) {
        _archiverAndWillReplaceObject!(archiver, object, newObject)
    }
    @objc func archiverWillFinish(archiver: NSKeyedArchiver) {
        _archiverWillFinish!(archiver)
    }
    @objc func archiverDidFinish(archiver: NSKeyedArchiver) {
        _archiverDidFinish!(archiver)
    }
}
