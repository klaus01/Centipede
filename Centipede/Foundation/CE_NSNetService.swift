//
//  CE_NSNetService.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import Foundation

public extension NSNetService {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NSNetService_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NSNetService_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: NSNetService_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is NSNetService_Delegate {
                return obj as! NSNetService_Delegate
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
    
    internal func getDelegateInstance() -> NSNetService_Delegate {
        return NSNetService_Delegate()
    }
    
    public func ce_willPublish(handle: (sender: NSNetService) -> Void) -> Self {
        ce._willPublish = handle
        rebindingDelegate()
        return self
    }
    public func ce_didPublish(handle: (sender: NSNetService) -> Void) -> Self {
        ce._didPublish = handle
        rebindingDelegate()
        return self
    }
    public func ce_didNotPublish(handle: (sender: NSNetService, errorDict: [NSObject : AnyObject]) -> Void) -> Self {
        ce._didNotPublish = handle
        rebindingDelegate()
        return self
    }
    public func ce_willResolve(handle: (sender: NSNetService) -> Void) -> Self {
        ce._willResolve = handle
        rebindingDelegate()
        return self
    }
    public func ce_didResolveAddress(handle: (sender: NSNetService) -> Void) -> Self {
        ce._didResolveAddress = handle
        rebindingDelegate()
        return self
    }
    public func ce_didNotResolve(handle: (sender: NSNetService, errorDict: [NSObject : AnyObject]) -> Void) -> Self {
        ce._didNotResolve = handle
        rebindingDelegate()
        return self
    }
    public func ce_didStop(handle: (sender: NSNetService) -> Void) -> Self {
        ce._didStop = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateTXTRecordData(handle: (sender: NSNetService, data: NSData) -> Void) -> Self {
        ce._didUpdateTXTRecordData = handle
        rebindingDelegate()
        return self
    }
    public func ce_didAcceptConnectionWithInputStream(handle: (sender: NSNetService, inputStream: NSInputStream, outputStream: NSOutputStream) -> Void) -> Self {
        ce._didAcceptConnectionWithInputStream = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSNetService_Delegate: NSObject, NSNetServiceDelegate {
    
    var _willPublish: ((NSNetService) -> Void)?
    var _didPublish: ((NSNetService) -> Void)?
    var _didNotPublish: ((NSNetService, [NSObject : AnyObject]) -> Void)?
    var _willResolve: ((NSNetService) -> Void)?
    var _didResolveAddress: ((NSNetService) -> Void)?
    var _didNotResolve: ((NSNetService, [NSObject : AnyObject]) -> Void)?
    var _didStop: ((NSNetService) -> Void)?
    var _didUpdateTXTRecordData: ((NSNetService, NSData) -> Void)?
    var _didAcceptConnectionWithInputStream: ((NSNetService, NSInputStream, NSOutputStream) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "netServiceWillPublish:" : _willPublish,
            "netServiceDidPublish:" : _didPublish,
            "netService:didNotPublish:" : _didNotPublish,
            "netServiceWillResolve:" : _willResolve,
            "netServiceDidResolveAddress:" : _didResolveAddress,
            "netService:didNotResolve:" : _didNotResolve,
            "netServiceDidStop:" : _didStop,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "netService:didUpdateTXTRecordData:" : _didUpdateTXTRecordData,
            "netService:didAcceptConnectionWithInputStream:outputStream:" : _didAcceptConnectionWithInputStream,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func netServiceWillPublish(sender: NSNetService) {
        _willPublish!(sender)
    }
    @objc func netServiceDidPublish(sender: NSNetService) {
        _didPublish!(sender)
    }
    @objc func netService(sender: NSNetService, didNotPublish errorDict: [NSObject : AnyObject]) {
        _didNotPublish!(sender, errorDict)
    }
    @objc func netServiceWillResolve(sender: NSNetService) {
        _willResolve!(sender)
    }
    @objc func netServiceDidResolveAddress(sender: NSNetService) {
        _didResolveAddress!(sender)
    }
    @objc func netService(sender: NSNetService, didNotResolve errorDict: [NSObject : AnyObject]) {
        _didNotResolve!(sender, errorDict)
    }
    @objc func netServiceDidStop(sender: NSNetService) {
        _didStop!(sender)
    }
    @objc func netService(sender: NSNetService, didUpdateTXTRecordData data: NSData) {
        _didUpdateTXTRecordData!(sender, data)
    }
    @objc func netService(sender: NSNetService, didAcceptConnectionWithInputStream inputStream: NSInputStream, outputStream: NSOutputStream) {
        _didAcceptConnectionWithInputStream!(sender, inputStream, outputStream)
    }
}
