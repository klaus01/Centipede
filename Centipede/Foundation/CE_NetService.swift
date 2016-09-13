//
//  CE_NetService.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import Foundation

public extension NetService {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NetService_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NetService_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: NetService_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is NetService_Delegate {
                return obj as! NetService_Delegate
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
    
    internal func getDelegateInstance() -> NetService_Delegate {
        return NetService_Delegate()
    }
    
    public func ce_netServiceWillPublish(handle: ((NetService) -> Void)) -> Self {
        ce._netServiceWillPublish = handle
        rebindingDelegate()
        return self
    }
    public func ce_netServiceDidPublish(handle: ((NetService) -> Void)) -> Self {
        ce._netServiceDidPublish = handle
        rebindingDelegate()
        return self
    }
    public func ce_netService_didNotPublish(handle: ((NetService, [String : NSNumber]) -> Void)) -> Self {
        ce._netService_didNotPublish = handle
        rebindingDelegate()
        return self
    }
    public func ce_netServiceWillResolve(handle: ((NetService) -> Void)) -> Self {
        ce._netServiceWillResolve = handle
        rebindingDelegate()
        return self
    }
    public func ce_netServiceDidResolveAddress(handle: ((NetService) -> Void)) -> Self {
        ce._netServiceDidResolveAddress = handle
        rebindingDelegate()
        return self
    }
    public func ce_netService_didNotResolve(handle: ((NetService, [String : NSNumber]) -> Void)) -> Self {
        ce._netService_didNotResolve = handle
        rebindingDelegate()
        return self
    }
    public func ce_netServiceDidStop(handle: ((NetService) -> Void)) -> Self {
        ce._netServiceDidStop = handle
        rebindingDelegate()
        return self
    }
    public func ce_netService_didUpdateTXTRecord(handle: ((NetService, Data) -> Void)) -> Self {
        ce._netService_didUpdateTXTRecord = handle
        rebindingDelegate()
        return self
    }
    public func ce_netService_didAcceptConnectionWith(handle: ((NetService, InputStream, OutputStream) -> Void)) -> Self {
        ce._netService_didAcceptConnectionWith = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NetService_Delegate: NSObject, NetServiceDelegate {
    
    var _netServiceWillPublish: ((NetService) -> Void)?
    var _netServiceDidPublish: ((NetService) -> Void)?
    var _netService_didNotPublish: ((NetService, [String : NSNumber]) -> Void)?
    var _netServiceWillResolve: ((NetService) -> Void)?
    var _netServiceDidResolveAddress: ((NetService) -> Void)?
    var _netService_didNotResolve: ((NetService, [String : NSNumber]) -> Void)?
    var _netServiceDidStop: ((NetService) -> Void)?
    var _netService_didUpdateTXTRecord: ((NetService, Data) -> Void)?
    var _netService_didAcceptConnectionWith: ((NetService, InputStream, OutputStream) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(netServiceWillPublish(_:)) : _netServiceWillPublish,
            #selector(netServiceDidPublish(_:)) : _netServiceDidPublish,
            #selector(netService(_:didNotPublish:)) : _netService_didNotPublish,
            #selector(netServiceWillResolve(_:)) : _netServiceWillResolve,
            #selector(netServiceDidResolveAddress(_:)) : _netServiceDidResolveAddress,
            #selector(netService(_:didNotResolve:)) : _netService_didNotResolve,
            #selector(netServiceDidStop(_:)) : _netServiceDidStop,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(netService(_:didUpdateTXTRecord:)) : _netService_didUpdateTXTRecord,
            #selector(netService(_:didAcceptConnectionWith:outputStream:)) : _netService_didAcceptConnectionWith,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func netServiceWillPublish(_ sender: NetService) {
        _netServiceWillPublish!(sender)
    }
    @objc func netServiceDidPublish(_ sender: NetService) {
        _netServiceDidPublish!(sender)
    }
    @objc func netService(_ sender: NetService, didNotPublish errorDict: [String : NSNumber]) {
        _netService_didNotPublish!(sender, errorDict)
    }
    @objc func netServiceWillResolve(_ sender: NetService) {
        _netServiceWillResolve!(sender)
    }
    @objc func netServiceDidResolveAddress(_ sender: NetService) {
        _netServiceDidResolveAddress!(sender)
    }
    @objc func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        _netService_didNotResolve!(sender, errorDict)
    }
    @objc func netServiceDidStop(_ sender: NetService) {
        _netServiceDidStop!(sender)
    }
    @objc func netService(_ sender: NetService, didUpdateTXTRecord data: Data) {
        _netService_didUpdateTXTRecord!(sender, data)
    }
    @objc func netService(_ sender: NetService, didAcceptConnectionWith inputStream: InputStream, outputStream: OutputStream) {
        _netService_didAcceptConnectionWith!(sender, inputStream, outputStream)
    }
}
