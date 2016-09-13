//
//  CE_NetServiceBrowser.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import Foundation

public extension NetServiceBrowser {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NetServiceBrowser_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NetServiceBrowser_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: NetServiceBrowser_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is NetServiceBrowser_Delegate {
                return obj as! NetServiceBrowser_Delegate
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
    
    internal func getDelegateInstance() -> NetServiceBrowser_Delegate {
        return NetServiceBrowser_Delegate()
    }
    
    public func ce_nWillSearch(handle: ((NetServiceBrowser) -> Void)) -> Self {
        ce._nWillSearch = handle
        rebindingDelegate()
        return self
    }
    public func ce_nDidStopSearch(handle: ((NetServiceBrowser) -> Void)) -> Self {
        ce._nDidStopSearch = handle
        rebindingDelegate()
        return self
    }
    public func ce_n(handle: ((NetServiceBrowser, [String : NSNumber]) -> Void)) -> Self {
        ce._n = handle
        rebindingDelegate()
        return self
    }
    public func ce_n_didFindDomain(handle: ((NetServiceBrowser, String, Bool) -> Void)) -> Self {
        ce._n_didFindDomain = handle
        rebindingDelegate()
        return self
    }
    public func ce_n_didFind(handle: ((NetServiceBrowser, NetService, Bool) -> Void)) -> Self {
        ce._n_didFind = handle
        rebindingDelegate()
        return self
    }
    public func ce_n_didRemoveDomain(handle: ((NetServiceBrowser, String, Bool) -> Void)) -> Self {
        ce._n_didRemoveDomain = handle
        rebindingDelegate()
        return self
    }
    public func ce_n_didRemove(handle: ((NetServiceBrowser, NetService, Bool) -> Void)) -> Self {
        ce._n_didRemove = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NetServiceBrowser_Delegate: NSObject, NetServiceBrowserDelegate {
    
    var _nWillSearch: ((NetServiceBrowser) -> Void)?
    var _nDidStopSearch: ((NetServiceBrowser) -> Void)?
    var _n: ((NetServiceBrowser, [String : NSNumber]) -> Void)?
    var _n_didFindDomain: ((NetServiceBrowser, String, Bool) -> Void)?
    var _n_didFind: ((NetServiceBrowser, NetService, Bool) -> Void)?
    var _n_didRemoveDomain: ((NetServiceBrowser, String, Bool) -> Void)?
    var _n_didRemove: ((NetServiceBrowser, NetService, Bool) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(netServiceBrowserWillSearch(_:)) : _nWillSearch,
            #selector(netServiceBrowserDidStopSearch(_:)) : _nDidStopSearch,
            #selector(netServiceBrowser(_:didNotSearch:)) : _n,
            #selector(netServiceBrowser(_:didFindDomain:moreComing:)) : _n_didFindDomain,
            #selector(netServiceBrowser(_:didFind:moreComing:)) : _n_didFind,
            #selector(netServiceBrowser(_:didRemoveDomain:moreComing:)) : _n_didRemoveDomain,
            #selector(netServiceBrowser(_:didRemove:moreComing:)) : _n_didRemove,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func netServiceBrowserWillSearch(_ browser: NetServiceBrowser) {
        _nWillSearch!(browser)
    }
    @objc func netServiceBrowserDidStopSearch(_ browser: NetServiceBrowser) {
        _nDidStopSearch!(browser)
    }
    @objc func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
        _n!(browser, errorDict)
    }
    @objc func netServiceBrowser(_ browser: NetServiceBrowser, didFindDomain domainString: String, moreComing: Bool) {
        _n_didFindDomain!(browser, domainString, moreComing)
    }
    @objc func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        _n_didFind!(browser, service, moreComing)
    }
    @objc func netServiceBrowser(_ browser: NetServiceBrowser, didRemoveDomain domainString: String, moreComing: Bool) {
        _n_didRemoveDomain!(browser, domainString, moreComing)
    }
    @objc func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
        _n_didRemove!(browser, service, moreComing)
    }
}
