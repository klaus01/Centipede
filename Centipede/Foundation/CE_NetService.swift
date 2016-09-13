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
    
    public func ce_nWillPublish(handle: ((NetService) -> Void)) -> Self {
        ce._nWillPublish = handle
        rebindingDelegate()
        return self
    }
    public func ce_nDidPublish(handle: ((NetService) -> Void)) -> Self {
        ce._nDidPublish = handle
        rebindingDelegate()
        return self
    }
    public func ce_n(handle: ((NetService, [String : NSNumber]) -> Void)) -> Self {
        ce._n = handle
        rebindingDelegate()
        return self
    }
    public func ce_nWillResolve(handle: ((NetService) -> Void)) -> Self {
        ce._nWillResolve = handle
        rebindingDelegate()
        return self
    }
    public func ce_nDidResolveAddress(handle: ((NetService) -> Void)) -> Self {
        ce._nDidResolveAddress = handle
        rebindingDelegate()
        return self
    }
    public func ce_n_didNotResolve(handle: ((NetService, [String : NSNumber]) -> Void)) -> Self {
        ce._n_didNotResolve = handle
        rebindingDelegate()
        return self
    }
    public func ce_nDidStop(handle: ((NetService) -> Void)) -> Self {
        ce._nDidStop = handle
        rebindingDelegate()
        return self
    }
    public func ce_n_didUpdateTXTRecord(handle: ((NetService, Data) -> Void)) -> Self {
        ce._n_didUpdateTXTRecord = handle
        rebindingDelegate()
        return self
    }
    public func ce_n_didAcceptConnectionWith(handle: ((NetService, InputStream, OutputStream) -> Void)) -> Self {
        ce._n_didAcceptConnectionWith = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NetService_Delegate: NSObject, NetServiceDelegate {
    
    var _nWillPublish: ((NetService) -> Void)?
    var _nDidPublish: ((NetService) -> Void)?
    var _n: ((NetService, [String : NSNumber]) -> Void)?
    var _nWillResolve: ((NetService) -> Void)?
    var _nDidResolveAddress: ((NetService) -> Void)?
    var _n_didNotResolve: ((NetService, [String : NSNumber]) -> Void)?
    var _nDidStop: ((NetService) -> Void)?
    var _n_didUpdateTXTRecord: ((NetService, Data) -> Void)?
    var _n_didAcceptConnectionWith: ((NetService, InputStream, OutputStream) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(netServiceWillPublish(_:)) : _nWillPublish,
            #selector(netServiceDidPublish(_:)) : _nDidPublish,
            #selector(netService(_:didNotPublish:)) : _n,
            #selector(netServiceWillResolve(_:)) : _nWillResolve,
            #selector(netServiceDidResolveAddress(_:)) : _nDidResolveAddress,
            #selector(netService(_:didNotResolve:)) : _n_didNotResolve,
            #selector(netServiceDidStop(_:)) : _nDidStop,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(netService(_:didUpdateTXTRecord:)) : _n_didUpdateTXTRecord,
            #selector(netService(_:didAcceptConnectionWith:outputStream:)) : _n_didAcceptConnectionWith,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func netServiceWillPublish(_ sender: NetService) {
        _nWillPublish!(sender)
    }
    @objc func netServiceDidPublish(_ sender: NetService) {
        _nDidPublish!(sender)
    }
    @objc func netService(_ sender: NetService, didNotPublish errorDict: [String : NSNumber]) {
        _n!(sender, errorDict)
    }
    @objc func netServiceWillResolve(_ sender: NetService) {
        _nWillResolve!(sender)
    }
    @objc func netServiceDidResolveAddress(_ sender: NetService) {
        _nDidResolveAddress!(sender)
    }
    @objc func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        _n_didNotResolve!(sender, errorDict)
    }
    @objc func netServiceDidStop(_ sender: NetService) {
        _nDidStop!(sender)
    }
    @objc func netService(_ sender: NetService, didUpdateTXTRecord data: Data) {
        _n_didUpdateTXTRecord!(sender, data)
    }
    @objc func netService(_ sender: NetService, didAcceptConnectionWith inputStream: InputStream, outputStream: OutputStream) {
        _n_didAcceptConnectionWith!(sender, inputStream, outputStream)
    }
}
