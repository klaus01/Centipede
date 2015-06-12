//
//  CE_NSNetServiceBrowser.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import Foundation

public extension NSNetServiceBrowser {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NSNetServiceBrowser_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NSNetServiceBrowser_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: NSNetServiceBrowser_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is NSNetServiceBrowser_Delegate {
                return obj as! NSNetServiceBrowser_Delegate
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
    
    internal func getDelegateInstance() -> NSNetServiceBrowser_Delegate {
        return NSNetServiceBrowser_Delegate()
    }
    
    public func ce_willSearch(handle: (aNetServiceBrowser: NSNetServiceBrowser) -> Void) -> Self {
        ce._willSearch = handle
        rebindingDelegate()
        return self
    }
    public func ce_didStopSearch(handle: (aNetServiceBrowser: NSNetServiceBrowser) -> Void) -> Self {
        ce._didStopSearch = handle
        rebindingDelegate()
        return self
    }
    public func ce_didNotSearch(handle: (aNetServiceBrowser: NSNetServiceBrowser, errorDict: [NSObject : AnyObject]) -> Void) -> Self {
        ce._didNotSearch = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFindDomain(handle: (aNetServiceBrowser: NSNetServiceBrowser, domainString: String, moreComing: Bool) -> Void) -> Self {
        ce._didFindDomain = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFindService(handle: (aNetServiceBrowser: NSNetServiceBrowser, aNetService: NSNetService, moreComing: Bool) -> Void) -> Self {
        ce._didFindService = handle
        rebindingDelegate()
        return self
    }
    public func ce_didRemoveDomain(handle: (aNetServiceBrowser: NSNetServiceBrowser, domainString: String, moreComing: Bool) -> Void) -> Self {
        ce._didRemoveDomain = handle
        rebindingDelegate()
        return self
    }
    public func ce_didRemoveService(handle: (aNetServiceBrowser: NSNetServiceBrowser, aNetService: NSNetService, moreComing: Bool) -> Void) -> Self {
        ce._didRemoveService = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSNetServiceBrowser_Delegate: NSObject, NSNetServiceBrowserDelegate {
    
    var _willSearch: ((NSNetServiceBrowser) -> Void)?
    var _didStopSearch: ((NSNetServiceBrowser) -> Void)?
    var _didNotSearch: ((NSNetServiceBrowser, [NSObject : AnyObject]) -> Void)?
    var _didFindDomain: ((NSNetServiceBrowser, String, Bool) -> Void)?
    var _didFindService: ((NSNetServiceBrowser, NSNetService, Bool) -> Void)?
    var _didRemoveDomain: ((NSNetServiceBrowser, String, Bool) -> Void)?
    var _didRemoveService: ((NSNetServiceBrowser, NSNetService, Bool) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "netServiceBrowserWillSearch:" : _willSearch,
            "netServiceBrowserDidStopSearch:" : _didStopSearch,
            "netServiceBrowser:didNotSearch:" : _didNotSearch,
            "netServiceBrowser:didFindDomain:moreComing:" : _didFindDomain,
            "netServiceBrowser:didFindService:moreComing:" : _didFindService,
            "netServiceBrowser:didRemoveDomain:moreComing:" : _didRemoveDomain,
            "netServiceBrowser:didRemoveService:moreComing:" : _didRemoveService,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func netServiceBrowserWillSearch(aNetServiceBrowser: NSNetServiceBrowser) {
        _willSearch!(aNetServiceBrowser)
    }
    @objc func netServiceBrowserDidStopSearch(aNetServiceBrowser: NSNetServiceBrowser) {
        _didStopSearch!(aNetServiceBrowser)
    }
    @objc func netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser, didNotSearch errorDict: [NSObject : AnyObject]) {
        _didNotSearch!(aNetServiceBrowser, errorDict)
    }
    @objc func netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser, didFindDomain domainString: String, moreComing: Bool) {
        _didFindDomain!(aNetServiceBrowser, domainString, moreComing)
    }
    @objc func netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser, didFindService aNetService: NSNetService, moreComing: Bool) {
        _didFindService!(aNetServiceBrowser, aNetService, moreComing)
    }
    @objc func netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser, didRemoveDomain domainString: String, moreComing: Bool) {
        _didRemoveDomain!(aNetServiceBrowser, domainString, moreComing)
    }
    @objc func netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser, didRemoveService aNetService: NSNetService, moreComing: Bool) {
        _didRemoveService!(aNetServiceBrowser, aNetService, moreComing)
    }
}
