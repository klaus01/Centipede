//
//  CE_FileManager.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import Foundation

public extension FileManager {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: FileManager_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? FileManager_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: FileManager_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is FileManager_Delegate {
                return obj as! FileManager_Delegate
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
    
    internal func getDelegateInstance() -> FileManager_Delegate {
        return FileManager_Delegate()
    }
    
    public func ce_f(handle: ((FileManager, String, String) -> Bool)) -> Self {
        ce._f = handle
        rebindingDelegate()
        return self
    }
    public func ce_f_shouldCopyItemAt(handle: ((FileManager, URL, URL) -> Bool)) -> Self {
        ce._f_shouldCopyItemAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_f_shouldProceedAfterError(handle: ((FileManager, Error, String, String) -> Bool)) -> Self {
        ce._f_shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_f_shouldProceedAfterError_shouldProceedAfterError(handle: ((FileManager, Error, URL, URL) -> Bool)) -> Self {
        ce._f_shouldProceedAfterError_shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_f_shouldMoveItemAtPath(handle: ((FileManager, String, String) -> Bool)) -> Self {
        ce._f_shouldMoveItemAtPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_f_shouldMoveItemAt(handle: ((FileManager, URL, URL) -> Bool)) -> Self {
        ce._f_shouldMoveItemAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError(handle: ((FileManager, Error, String, String) -> Bool)) -> Self {
        ce._f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError(handle: ((FileManager, Error, URL, URL) -> Bool)) -> Self {
        ce._f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_f_shouldLinkItemAtPath(handle: ((FileManager, String, String) -> Bool)) -> Self {
        ce._f_shouldLinkItemAtPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_f_shouldLinkItemAt(handle: ((FileManager, URL, URL) -> Bool)) -> Self {
        ce._f_shouldLinkItemAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError(handle: ((FileManager, Error, String, String) -> Bool)) -> Self {
        ce._f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError(handle: ((FileManager, Error, URL, URL) -> Bool)) -> Self {
        ce._f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_f_shouldRemoveItemAtPath(handle: ((FileManager, String) -> Bool)) -> Self {
        ce._f_shouldRemoveItemAtPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_f_shouldRemoveItemAt(handle: ((FileManager, URL) -> Bool)) -> Self {
        ce._f_shouldRemoveItemAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError(handle: ((FileManager, Error, String) -> Bool)) -> Self {
        ce._f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError(handle: ((FileManager, Error, URL) -> Bool)) -> Self {
        ce._f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    
}

internal class FileManager_Delegate: NSObject, FileManagerDelegate {
    
    var _f: ((FileManager, String, String) -> Bool)?
    var _f_shouldCopyItemAt: ((FileManager, URL, URL) -> Bool)?
    var _f_shouldProceedAfterError: ((FileManager, Error, String, String) -> Bool)?
    var _f_shouldProceedAfterError_shouldProceedAfterError: ((FileManager, Error, URL, URL) -> Bool)?
    var _f_shouldMoveItemAtPath: ((FileManager, String, String) -> Bool)?
    var _f_shouldMoveItemAt: ((FileManager, URL, URL) -> Bool)?
    var _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError: ((FileManager, Error, String, String) -> Bool)?
    var _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError: ((FileManager, Error, URL, URL) -> Bool)?
    var _f_shouldLinkItemAtPath: ((FileManager, String, String) -> Bool)?
    var _f_shouldLinkItemAt: ((FileManager, URL, URL) -> Bool)?
    var _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError: ((FileManager, Error, String, String) -> Bool)?
    var _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError: ((FileManager, Error, URL, URL) -> Bool)?
    var _f_shouldRemoveItemAtPath: ((FileManager, String) -> Bool)?
    var _f_shouldRemoveItemAt: ((FileManager, URL) -> Bool)?
    var _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError: ((FileManager, Error, String) -> Bool)?
    var _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError: ((FileManager, Error, URL) -> Bool)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(fileManager(_:shouldCopyItemAtPath:toPath:)) : _f,
            #selector(fileManager(_:shouldCopyItemAt:to:)) : _f_shouldCopyItemAt,
            #selector(fileManager(_:shouldProceedAfterError:copyingItemAtPath:toPath:)) : _f_shouldProceedAfterError,
            #selector(fileManager(_:shouldProceedAfterError:copyingItemAt:to:)) : _f_shouldProceedAfterError_shouldProceedAfterError,
            #selector(fileManager(_:shouldMoveItemAtPath:toPath:)) : _f_shouldMoveItemAtPath,
            #selector(fileManager(_:shouldMoveItemAt:to:)) : _f_shouldMoveItemAt,
            #selector(fileManager(_:shouldProceedAfterError:movingItemAtPath:toPath:)) : _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(fileManager(_:shouldProceedAfterError:movingItemAt:to:)) : _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError,
            #selector(fileManager(_:shouldLinkItemAtPath:toPath:)) : _f_shouldLinkItemAtPath,
            #selector(fileManager(_:shouldLinkItemAt:to:)) : _f_shouldLinkItemAt,
            #selector(fileManager(_:shouldProceedAfterError:linkingItemAtPath:toPath:)) : _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError,
            #selector(fileManager(_:shouldProceedAfterError:linkingItemAt:to:)) : _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError,
            #selector(fileManager(_:shouldRemoveItemAtPath:)) : _f_shouldRemoveItemAtPath,
            #selector(fileManager(_:shouldRemoveItemAt:)) : _f_shouldRemoveItemAt,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        let funcDic3: [Selector : Any?] = [
            #selector(fileManager(_:shouldProceedAfterError:removingItemAtPath:)) : _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError,
            #selector(fileManager(_:shouldProceedAfterError:removingItemAt:)) : _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError,
        ]
        if let f = funcDic3[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func fileManager(_ fileManager: FileManager, shouldCopyItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _f!(fileManager, srcPath, dstPath)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldCopyItemAt srcURL: URL, to dstURL: URL) -> Bool {
        return _f_shouldCopyItemAt!(fileManager, srcURL, dstURL)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, copyingItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _f_shouldProceedAfterError!(fileManager, error, srcPath, dstPath)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, copyingItemAt srcURL: URL, to dstURL: URL) -> Bool {
        return _f_shouldProceedAfterError_shouldProceedAfterError!(fileManager, error, srcURL, dstURL)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldMoveItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _f_shouldMoveItemAtPath!(fileManager, srcPath, dstPath)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldMoveItemAt srcURL: URL, to dstURL: URL) -> Bool {
        return _f_shouldMoveItemAt!(fileManager, srcURL, dstURL)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, movingItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError!(fileManager, error, srcPath, dstPath)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, movingItemAt srcURL: URL, to dstURL: URL) -> Bool {
        return _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError!(fileManager, error, srcURL, dstURL)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldLinkItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _f_shouldLinkItemAtPath!(fileManager, srcPath, dstPath)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldLinkItemAt srcURL: URL, to dstURL: URL) -> Bool {
        return _f_shouldLinkItemAt!(fileManager, srcURL, dstURL)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, linkingItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError!(fileManager, error, srcPath, dstPath)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, linkingItemAt srcURL: URL, to dstURL: URL) -> Bool {
        return _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError!(fileManager, error, srcURL, dstURL)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldRemoveItemAtPath path: String) -> Bool {
        return _f_shouldRemoveItemAtPath!(fileManager, path)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldRemoveItemAt URL: URL) -> Bool {
        return _f_shouldRemoveItemAt!(fileManager, URL)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, removingItemAtPath path: String) -> Bool {
        return _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError!(fileManager, error, path)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, removingItemAt URL: URL) -> Bool {
        return _f_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError!(fileManager, error, URL)
    }
}
