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
    
    public func ce_fileManager_shouldCopyItemAtPath(handle: ((FileManager, String, String) -> Bool)) -> Self {
        ce._fileManager_shouldCopyItemAtPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_fileManager_shouldCopyItemAt(handle: ((FileManager, URL, URL) -> Bool)) -> Self {
        ce._fileManager_shouldCopyItemAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_fileManager_shouldProceedAfterError(handle: ((FileManager, Error, String, String) -> Bool)) -> Self {
        ce._fileManager_shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_fileManager_shouldProceedAfterError_shouldProceedAfterError(handle: ((FileManager, Error, URL, URL) -> Bool)) -> Self {
        ce._fileManager_shouldProceedAfterError_shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_fileManager_shouldMoveItemAtPath(handle: ((FileManager, String, String) -> Bool)) -> Self {
        ce._fileManager_shouldMoveItemAtPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_fileManager_shouldMoveItemAt(handle: ((FileManager, URL, URL) -> Bool)) -> Self {
        ce._fileManager_shouldMoveItemAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError(handle: ((FileManager, Error, String, String) -> Bool)) -> Self {
        ce._fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError(handle: ((FileManager, Error, URL, URL) -> Bool)) -> Self {
        ce._fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_fileManager_shouldLinkItemAtPath(handle: ((FileManager, String, String) -> Bool)) -> Self {
        ce._fileManager_shouldLinkItemAtPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_fileManager_shouldLinkItemAt(handle: ((FileManager, URL, URL) -> Bool)) -> Self {
        ce._fileManager_shouldLinkItemAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError(handle: ((FileManager, Error, String, String) -> Bool)) -> Self {
        ce._fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError(handle: ((FileManager, Error, URL, URL) -> Bool)) -> Self {
        ce._fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_fileManager_shouldRemoveItemAtPath(handle: ((FileManager, String) -> Bool)) -> Self {
        ce._fileManager_shouldRemoveItemAtPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_fileManager_shouldRemoveItemAt(handle: ((FileManager, URL) -> Bool)) -> Self {
        ce._fileManager_shouldRemoveItemAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError(handle: ((FileManager, Error, String) -> Bool)) -> Self {
        ce._fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    public func ce_fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError(handle: ((FileManager, Error, URL) -> Bool)) -> Self {
        ce._fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError = handle
        rebindingDelegate()
        return self
    }
    
}

internal class FileManager_Delegate: NSObject, FileManagerDelegate {
    
    var _fileManager_shouldCopyItemAtPath: ((FileManager, String, String) -> Bool)?
    var _fileManager_shouldCopyItemAt: ((FileManager, URL, URL) -> Bool)?
    var _fileManager_shouldProceedAfterError: ((FileManager, Error, String, String) -> Bool)?
    var _fileManager_shouldProceedAfterError_shouldProceedAfterError: ((FileManager, Error, URL, URL) -> Bool)?
    var _fileManager_shouldMoveItemAtPath: ((FileManager, String, String) -> Bool)?
    var _fileManager_shouldMoveItemAt: ((FileManager, URL, URL) -> Bool)?
    var _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError: ((FileManager, Error, String, String) -> Bool)?
    var _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError: ((FileManager, Error, URL, URL) -> Bool)?
    var _fileManager_shouldLinkItemAtPath: ((FileManager, String, String) -> Bool)?
    var _fileManager_shouldLinkItemAt: ((FileManager, URL, URL) -> Bool)?
    var _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError: ((FileManager, Error, String, String) -> Bool)?
    var _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError: ((FileManager, Error, URL, URL) -> Bool)?
    var _fileManager_shouldRemoveItemAtPath: ((FileManager, String) -> Bool)?
    var _fileManager_shouldRemoveItemAt: ((FileManager, URL) -> Bool)?
    var _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError: ((FileManager, Error, String) -> Bool)?
    var _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError: ((FileManager, Error, URL) -> Bool)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(fileManager(_:shouldCopyItemAtPath:toPath:)) : _fileManager_shouldCopyItemAtPath,
            #selector(fileManager(_:shouldCopyItemAt:to:)) : _fileManager_shouldCopyItemAt,
            #selector(fileManager(_:shouldProceedAfterError:copyingItemAtPath:toPath:)) : _fileManager_shouldProceedAfterError,
            #selector(fileManager(_:shouldProceedAfterError:copyingItemAt:to:)) : _fileManager_shouldProceedAfterError_shouldProceedAfterError,
            #selector(fileManager(_:shouldMoveItemAtPath:toPath:)) : _fileManager_shouldMoveItemAtPath,
            #selector(fileManager(_:shouldMoveItemAt:to:)) : _fileManager_shouldMoveItemAt,
            #selector(fileManager(_:shouldProceedAfterError:movingItemAtPath:toPath:)) : _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(fileManager(_:shouldProceedAfterError:movingItemAt:to:)) : _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError,
            #selector(fileManager(_:shouldLinkItemAtPath:toPath:)) : _fileManager_shouldLinkItemAtPath,
            #selector(fileManager(_:shouldLinkItemAt:to:)) : _fileManager_shouldLinkItemAt,
            #selector(fileManager(_:shouldProceedAfterError:linkingItemAtPath:toPath:)) : _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError,
            #selector(fileManager(_:shouldProceedAfterError:linkingItemAt:to:)) : _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError,
            #selector(fileManager(_:shouldRemoveItemAtPath:)) : _fileManager_shouldRemoveItemAtPath,
            #selector(fileManager(_:shouldRemoveItemAt:)) : _fileManager_shouldRemoveItemAt,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        let funcDic3: [Selector : Any?] = [
            #selector(fileManager(_:shouldProceedAfterError:removingItemAtPath:)) : _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError,
            #selector(fileManager(_:shouldProceedAfterError:removingItemAt:)) : _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError,
        ]
        if let f = funcDic3[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func fileManager(_ fileManager: FileManager, shouldCopyItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _fileManager_shouldCopyItemAtPath!(fileManager, srcPath, dstPath)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldCopyItemAt srcURL: URL, to dstURL: URL) -> Bool {
        return _fileManager_shouldCopyItemAt!(fileManager, srcURL, dstURL)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, copyingItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _fileManager_shouldProceedAfterError!(fileManager, error, srcPath, dstPath)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, copyingItemAt srcURL: URL, to dstURL: URL) -> Bool {
        return _fileManager_shouldProceedAfterError_shouldProceedAfterError!(fileManager, error, srcURL, dstURL)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldMoveItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _fileManager_shouldMoveItemAtPath!(fileManager, srcPath, dstPath)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldMoveItemAt srcURL: URL, to dstURL: URL) -> Bool {
        return _fileManager_shouldMoveItemAt!(fileManager, srcURL, dstURL)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, movingItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError!(fileManager, error, srcPath, dstPath)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, movingItemAt srcURL: URL, to dstURL: URL) -> Bool {
        return _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError!(fileManager, error, srcURL, dstURL)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldLinkItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _fileManager_shouldLinkItemAtPath!(fileManager, srcPath, dstPath)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldLinkItemAt srcURL: URL, to dstURL: URL) -> Bool {
        return _fileManager_shouldLinkItemAt!(fileManager, srcURL, dstURL)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, linkingItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError!(fileManager, error, srcPath, dstPath)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, linkingItemAt srcURL: URL, to dstURL: URL) -> Bool {
        return _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError!(fileManager, error, srcURL, dstURL)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldRemoveItemAtPath path: String) -> Bool {
        return _fileManager_shouldRemoveItemAtPath!(fileManager, path)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldRemoveItemAt URL: URL) -> Bool {
        return _fileManager_shouldRemoveItemAt!(fileManager, URL)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, removingItemAtPath path: String) -> Bool {
        return _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError!(fileManager, error, path)
    }
    @objc func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, removingItemAt URL: URL) -> Bool {
        return _fileManager_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError_shouldProceedAfterError!(fileManager, error, URL)
    }
}
