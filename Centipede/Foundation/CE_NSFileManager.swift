//
//  CE_NSFileManager.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import Foundation

public extension NSFileManager {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NSFileManager_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NSFileManager_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: NSFileManager_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is NSFileManager_Delegate {
                return obj as! NSFileManager_Delegate
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
    
    internal func getDelegateInstance() -> NSFileManager_Delegate {
        return NSFileManager_Delegate()
    }
    
    public func ce_shouldCopyItemAtPath(handle: (fileManager: NSFileManager, srcPath: String, dstPath: String) -> Bool) -> Self {
        ce._shouldCopyItemAtPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldCopyItemAtURL(handle: (fileManager: NSFileManager, srcURL: NSURL, dstURL: NSURL) -> Bool) -> Self {
        ce._shouldCopyItemAtURL = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldProceedAfterError(handle: (fileManager: NSFileManager, error: NSError, srcPath: String, dstPath: String) -> Bool) -> Self {
        ce._shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldProceedAfterErrorAndShouldProceedAfterError(handle: (fileManager: NSFileManager, error: NSError, srcURL: NSURL, dstURL: NSURL) -> Bool) -> Self {
        ce._shouldProceedAfterErrorAndShouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldMoveItemAtPath(handle: (fileManager: NSFileManager, srcPath: String, dstPath: String) -> Bool) -> Self {
        ce._shouldMoveItemAtPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldMoveItemAtURL(handle: (fileManager: NSFileManager, srcURL: NSURL, dstURL: NSURL) -> Bool) -> Self {
        ce._shouldMoveItemAtURL = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError(handle: (fileManager: NSFileManager, error: NSError, srcPath: String, dstPath: String) -> Bool) -> Self {
        ce._shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError(handle: (fileManager: NSFileManager, error: NSError, srcURL: NSURL, dstURL: NSURL) -> Bool) -> Self {
        ce._shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldLinkItemAtPath(handle: (fileManager: NSFileManager, srcPath: String, dstPath: String) -> Bool) -> Self {
        ce._shouldLinkItemAtPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldLinkItemAtURL(handle: (fileManager: NSFileManager, srcURL: NSURL, dstURL: NSURL) -> Bool) -> Self {
        ce._shouldLinkItemAtURL = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError(handle: (fileManager: NSFileManager, error: NSError, srcPath: String, dstPath: String) -> Bool) -> Self {
        ce._shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError(handle: (fileManager: NSFileManager, error: NSError, srcURL: NSURL, dstURL: NSURL) -> Bool) -> Self {
        ce._shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldRemoveItemAtPath(handle: (fileManager: NSFileManager, path: String) -> Bool) -> Self {
        ce._shouldRemoveItemAtPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldRemoveItemAtURL(handle: (fileManager: NSFileManager, URL: NSURL) -> Bool) -> Self {
        ce._shouldRemoveItemAtURL = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError(handle: (fileManager: NSFileManager, error: NSError, path: String) -> Bool) -> Self {
        ce._shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError(handle: (fileManager: NSFileManager, error: NSError, URL: NSURL) -> Bool) -> Self {
        ce._shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSFileManager_Delegate: NSObject, NSFileManagerDelegate {
    
    var _shouldCopyItemAtPath: ((NSFileManager, String, String) -> Bool)?
    var _shouldCopyItemAtURL: ((NSFileManager, NSURL, NSURL) -> Bool)?
    var _shouldProceedAfterError: ((NSFileManager, NSError, String, String) -> Bool)?
    var _shouldProceedAfterErrorAndShouldProceedAfterError: ((NSFileManager, NSError, NSURL, NSURL) -> Bool)?
    var _shouldMoveItemAtPath: ((NSFileManager, String, String) -> Bool)?
    var _shouldMoveItemAtURL: ((NSFileManager, NSURL, NSURL) -> Bool)?
    var _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError: ((NSFileManager, NSError, String, String) -> Bool)?
    var _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError: ((NSFileManager, NSError, NSURL, NSURL) -> Bool)?
    var _shouldLinkItemAtPath: ((NSFileManager, String, String) -> Bool)?
    var _shouldLinkItemAtURL: ((NSFileManager, NSURL, NSURL) -> Bool)?
    var _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError: ((NSFileManager, NSError, String, String) -> Bool)?
    var _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError: ((NSFileManager, NSError, NSURL, NSURL) -> Bool)?
    var _shouldRemoveItemAtPath: ((NSFileManager, String) -> Bool)?
    var _shouldRemoveItemAtURL: ((NSFileManager, NSURL) -> Bool)?
    var _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError: ((NSFileManager, NSError, String) -> Bool)?
    var _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError: ((NSFileManager, NSError, NSURL) -> Bool)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "fileManager:shouldCopyItemAtPath:toPath:" : _shouldCopyItemAtPath,
            "fileManager:shouldCopyItemAtURL:toURL:" : _shouldCopyItemAtURL,
            "fileManager:shouldProceedAfterError:copyingItemAtPath:toPath:" : _shouldProceedAfterError,
            "fileManager:shouldProceedAfterError:copyingItemAtURL:toURL:" : _shouldProceedAfterErrorAndShouldProceedAfterError,
            "fileManager:shouldMoveItemAtPath:toPath:" : _shouldMoveItemAtPath,
            "fileManager:shouldMoveItemAtURL:toURL:" : _shouldMoveItemAtURL,
            "fileManager:shouldProceedAfterError:movingItemAtPath:toPath:" : _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "fileManager:shouldProceedAfterError:movingItemAtURL:toURL:" : _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError,
            "fileManager:shouldLinkItemAtPath:toPath:" : _shouldLinkItemAtPath,
            "fileManager:shouldLinkItemAtURL:toURL:" : _shouldLinkItemAtURL,
            "fileManager:shouldProceedAfterError:linkingItemAtPath:toPath:" : _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError,
            "fileManager:shouldProceedAfterError:linkingItemAtURL:toURL:" : _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError,
            "fileManager:shouldRemoveItemAtPath:" : _shouldRemoveItemAtPath,
            "fileManager:shouldRemoveItemAtURL:" : _shouldRemoveItemAtURL,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        let funcDic3: [Selector : Any?] = [
            "fileManager:shouldProceedAfterError:removingItemAtPath:" : _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError,
            "fileManager:shouldProceedAfterError:removingItemAtURL:" : _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError,
        ]
        if let f = funcDic3[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func fileManager(fileManager: NSFileManager, shouldCopyItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _shouldCopyItemAtPath!(fileManager, srcPath, dstPath)
    }
    @objc func fileManager(fileManager: NSFileManager, shouldCopyItemAtURL srcURL: NSURL, toURL dstURL: NSURL) -> Bool {
        return _shouldCopyItemAtURL!(fileManager, srcURL, dstURL)
    }
    @objc func fileManager(fileManager: NSFileManager, shouldProceedAfterError error: NSError, copyingItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _shouldProceedAfterError!(fileManager, error, srcPath, dstPath)
    }
    @objc func fileManager(fileManager: NSFileManager, shouldProceedAfterError error: NSError, copyingItemAtURL srcURL: NSURL, toURL dstURL: NSURL) -> Bool {
        return _shouldProceedAfterErrorAndShouldProceedAfterError!(fileManager, error, srcURL, dstURL)
    }
    @objc func fileManager(fileManager: NSFileManager, shouldMoveItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _shouldMoveItemAtPath!(fileManager, srcPath, dstPath)
    }
    @objc func fileManager(fileManager: NSFileManager, shouldMoveItemAtURL srcURL: NSURL, toURL dstURL: NSURL) -> Bool {
        return _shouldMoveItemAtURL!(fileManager, srcURL, dstURL)
    }
    @objc func fileManager(fileManager: NSFileManager, shouldProceedAfterError error: NSError, movingItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError!(fileManager, error, srcPath, dstPath)
    }
    @objc func fileManager(fileManager: NSFileManager, shouldProceedAfterError error: NSError, movingItemAtURL srcURL: NSURL, toURL dstURL: NSURL) -> Bool {
        return _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError!(fileManager, error, srcURL, dstURL)
    }
    @objc func fileManager(fileManager: NSFileManager, shouldLinkItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _shouldLinkItemAtPath!(fileManager, srcPath, dstPath)
    }
    @objc func fileManager(fileManager: NSFileManager, shouldLinkItemAtURL srcURL: NSURL, toURL dstURL: NSURL) -> Bool {
        return _shouldLinkItemAtURL!(fileManager, srcURL, dstURL)
    }
    @objc func fileManager(fileManager: NSFileManager, shouldProceedAfterError error: NSError, linkingItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError!(fileManager, error, srcPath, dstPath)
    }
    @objc func fileManager(fileManager: NSFileManager, shouldProceedAfterError error: NSError, linkingItemAtURL srcURL: NSURL, toURL dstURL: NSURL) -> Bool {
        return _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError!(fileManager, error, srcURL, dstURL)
    }
    @objc func fileManager(fileManager: NSFileManager, shouldRemoveItemAtPath path: String) -> Bool {
        return _shouldRemoveItemAtPath!(fileManager, path)
    }
    @objc func fileManager(fileManager: NSFileManager, shouldRemoveItemAtURL URL: NSURL) -> Bool {
        return _shouldRemoveItemAtURL!(fileManager, URL)
    }
    @objc func fileManager(fileManager: NSFileManager, shouldProceedAfterError error: NSError, removingItemAtPath path: String) -> Bool {
        return _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError!(fileManager, error, path)
    }
    @objc func fileManager(fileManager: NSFileManager, shouldProceedAfterError error: NSError, removingItemAtURL URL: NSURL) -> Bool {
        return _shouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterErrorAndShouldProceedAfterError!(fileManager, error, URL)
    }
}
