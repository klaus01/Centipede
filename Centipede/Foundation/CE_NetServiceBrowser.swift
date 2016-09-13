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
    
    public func ce_netServiceBrowserWillSearch(handle: ((NetServiceBrowser) -> Void)) -> Self {
        ce._netServiceBrowserWillSearch = handle
        rebindingDelegate()
        return self
    }
    public func ce_netServiceBrowserDidStopSearch(handle: ((NetServiceBrowser) -> Void)) -> Self {
        ce._netServiceBrowserDidStopSearch = handle
        rebindingDelegate()
        return self
    }
    public func ce_netServiceBrowser_didNotSearch(handle: ((NetServiceBrowser, [String : NSNumber]) -> Void)) -> Self {
        ce._netServiceBrowser_didNotSearch = handle
        rebindingDelegate()
        return self
    }
    public func ce_netServiceBrowser_didFindDomain(handle: ((NetServiceBrowser, String, Bool) -> Void)) -> Self {
        ce._netServiceBrowser_didFindDomain = handle
        rebindingDelegate()
        return self
    }
    public func ce_netServiceBrowser_didFind(handle: ((NetServiceBrowser, NetService, Bool) -> Void)) -> Self {
        ce._netServiceBrowser_didFind = handle
        rebindingDelegate()
        return self
    }
    public func ce_netServiceBrowser_didRemoveDomain(handle: ((NetServiceBrowser, String, Bool) -> Void)) -> Self {
        ce._netServiceBrowser_didRemoveDomain = handle
        rebindingDelegate()
        return self
    }
    public func ce_netServiceBrowser_didRemove(handle: ((NetServiceBrowser, NetService, Bool) -> Void)) -> Self {
        ce._netServiceBrowser_didRemove = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NetServiceBrowser_Delegate: NSObject, NetServiceBrowserDelegate {
    
    var _netServiceBrowserWillSearch: ((NetServiceBrowser) -> Void)?
    var _netServiceBrowserDidStopSearch: ((NetServiceBrowser) -> Void)?
    var _netServiceBrowser_didNotSearch: ((NetServiceBrowser, [String : NSNumber]) -> Void)?
    var _netServiceBrowser_didFindDomain: ((NetServiceBrowser, String, Bool) -> Void)?
    var _netServiceBrowser_didFind: ((NetServiceBrowser, NetService, Bool) -> Void)?
    var _netServiceBrowser_didRemoveDomain: ((NetServiceBrowser, String, Bool) -> Void)?
    var _netServiceBrowser_didRemove: ((NetServiceBrowser, NetService, Bool) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(netServiceBrowserWillSearch(_:)) : _netServiceBrowserWillSearch,
            #selector(netServiceBrowserDidStopSearch(_:)) : _netServiceBrowserDidStopSearch,
            #selector(netServiceBrowser(_:didNotSearch:)) : _netServiceBrowser_didNotSearch,
            #selector(netServiceBrowser(_:didFindDomain:moreComing:)) : _netServiceBrowser_didFindDomain,
            #selector(netServiceBrowser(_:didFind:moreComing:)) : _netServiceBrowser_didFind,
            #selector(netServiceBrowser(_:didRemoveDomain:moreComing:)) : _netServiceBrowser_didRemoveDomain,
            #selector(netServiceBrowser(_:didRemove:moreComing:)) : _netServiceBrowser_didRemove,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func netServiceBrowserWillSearch(_ browser: NetServiceBrowser) {
        _netServiceBrowserWillSearch!(browser)
    }
    @objc func netServiceBrowserDidStopSearch(_ browser: NetServiceBrowser) {
        _netServiceBrowserDidStopSearch!(browser)
    }
    @objc func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
        _netServiceBrowser_didNotSearch!(browser, errorDict)
    }
    @objc func netServiceBrowser(_ browser: NetServiceBrowser, didFindDomain domainString: String, moreComing: Bool) {
        _netServiceBrowser_didFindDomain!(browser, domainString, moreComing)
    }
    @objc func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        _netServiceBrowser_didFind!(browser, service, moreComing)
    }
    @objc func netServiceBrowser(_ browser: NetServiceBrowser, didRemoveDomain domainString: String, moreComing: Bool) {
        _netServiceBrowser_didRemoveDomain!(browser, domainString, moreComing)
    }
    @objc func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
        _netServiceBrowser_didRemove!(browser, service, moreComing)
    }
}
