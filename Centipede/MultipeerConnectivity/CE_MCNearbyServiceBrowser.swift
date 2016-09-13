//
//  CE_MCNearbyServiceBrowser.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import MultipeerConnectivity

public extension MCNearbyServiceBrowser {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: MCNearbyServiceBrowser_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? MCNearbyServiceBrowser_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: MCNearbyServiceBrowser_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is MCNearbyServiceBrowser_Delegate {
                return obj as! MCNearbyServiceBrowser_Delegate
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
    
    internal func getDelegateInstance() -> MCNearbyServiceBrowser_Delegate {
        return MCNearbyServiceBrowser_Delegate()
    }
    
    public func ce_browser_foundPeer(handle: ((MCNearbyServiceBrowser, MCPeerID, [String : String]?) -> Void)) -> Self {
        ce._browser_foundPeer = handle
        rebindingDelegate()
        return self
    }
    public func ce_browser_lostPeer(handle: ((MCNearbyServiceBrowser, MCPeerID) -> Void)) -> Self {
        ce._browser_lostPeer = handle
        rebindingDelegate()
        return self
    }
    public func ce_browser_didNotStartBrowsingForPeers(handle: ((MCNearbyServiceBrowser, Error) -> Void)) -> Self {
        ce._browser_didNotStartBrowsingForPeers = handle
        rebindingDelegate()
        return self
    }
    
}

internal class MCNearbyServiceBrowser_Delegate: NSObject, MCNearbyServiceBrowserDelegate {
    
    var _browser_foundPeer: ((MCNearbyServiceBrowser, MCPeerID, [String : String]?) -> Void)?
    var _browser_lostPeer: ((MCNearbyServiceBrowser, MCPeerID) -> Void)?
    var _browser_didNotStartBrowsingForPeers: ((MCNearbyServiceBrowser, Error) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(browser(_:foundPeer:withDiscoveryInfo:)) : _browser_foundPeer,
            #selector(browser(_:lostPeer:)) : _browser_lostPeer,
            #selector(browser(_:didNotStartBrowsingForPeers:)) : _browser_didNotStartBrowsingForPeers,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        _browser_foundPeer!(browser, peerID, info)
    }
    @objc func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        _browser_lostPeer!(browser, peerID)
    }
    @objc func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        _browser_didNotStartBrowsingForPeers!(browser, error)
    }
}
