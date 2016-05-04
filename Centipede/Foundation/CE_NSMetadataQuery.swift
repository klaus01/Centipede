//
//  CE_NSMetadataQuery.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import Foundation

public extension NSMetadataQuery {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NSMetadataQuery_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NSMetadataQuery_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: NSMetadataQuery_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is NSMetadataQuery_Delegate {
                return obj as! NSMetadataQuery_Delegate
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
    
    internal func getDelegateInstance() -> NSMetadataQuery_Delegate {
        return NSMetadataQuery_Delegate()
    }
    
    public func ce_replacementObjectForResultObject(handle: (query: NSMetadataQuery, result: NSMetadataItem) -> AnyObject) -> Self {
        ce._replacementObjectForResultObject = handle
        rebindingDelegate()
        return self
    }
    public func ce_replacementValueForAttribute(handle: (query: NSMetadataQuery, attrName: String, attrValue: AnyObject) -> AnyObject) -> Self {
        ce._replacementValueForAttribute = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSMetadataQuery_Delegate: NSObject, NSMetadataQueryDelegate {
    
    var _replacementObjectForResultObject: ((NSMetadataQuery, NSMetadataItem) -> AnyObject)?
    var _replacementValueForAttribute: ((NSMetadataQuery, String, AnyObject) -> AnyObject)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(metadataQuery(_:replacementObjectForResultObject:)) : _replacementObjectForResultObject,
            #selector(metadataQuery(_:replacementValueForAttribute:value:)) : _replacementValueForAttribute,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func metadataQuery(query: NSMetadataQuery, replacementObjectForResultObject result: NSMetadataItem) -> AnyObject {
        return _replacementObjectForResultObject!(query, result)
    }
    @objc func metadataQuery(query: NSMetadataQuery, replacementValueForAttribute attrName: String, value attrValue: AnyObject) -> AnyObject {
        return _replacementValueForAttribute!(query, attrName, attrValue)
    }
}
