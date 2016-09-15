//
//  CE_NSMetadataQuery.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import Foundation

extension NSMetadataQuery {
    
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
    
    @discardableResult
    public func ce_metadataQuery_replacementObjectForResultObject(handle: @escaping (NSMetadataQuery, NSMetadataItem) -> Any) -> Self {
        ce._metadataQuery_replacementObjectForResultObject = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_metadataQuery_replacementValueForAttribute(handle: @escaping (NSMetadataQuery, String, Any) -> Any) -> Self {
        ce._metadataQuery_replacementValueForAttribute = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSMetadataQuery_Delegate: NSObject, NSMetadataQueryDelegate {
    
    var _metadataQuery_replacementObjectForResultObject: ((NSMetadataQuery, NSMetadataItem) -> Any)?
    var _metadataQuery_replacementValueForAttribute: ((NSMetadataQuery, String, Any) -> Any)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(metadataQuery(_:replacementObjectForResultObject:)) : _metadataQuery_replacementObjectForResultObject,
            #selector(metadataQuery(_:replacementValueForAttribute:value:)) : _metadataQuery_replacementValueForAttribute,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func metadataQuery(_ query: NSMetadataQuery, replacementObjectForResultObject result: NSMetadataItem) -> Any {
        return _metadataQuery_replacementObjectForResultObject!(query, result)
    }
    @objc func metadataQuery(_ query: NSMetadataQuery, replacementValueForAttribute attrName: String, value attrValue: Any) -> Any {
        return _metadataQuery_replacementValueForAttribute!(query, attrName, attrValue)
    }
}
