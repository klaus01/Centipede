//
//  CE_MCNearbyServiceBrowser.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
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
    
    public func ce_browser(handle: (browser: MCNearbyServiceBrowser, peerID: MCPeerID, info: [String : String]?) -> Void) -> Self {
        ce._browser = handle
        rebindingDelegate()
        return self
    }
    public func ce_browserAndLostPeer(handle: (browser: MCNearbyServiceBrowser, peerID: MCPeerID) -> Void) -> Self {
        ce._browserAndLostPeer = handle
        rebindingDelegate()
        return self
    }
    public func ce_browserAndDidNotStartBrowsingForPeers(handle: (browser: MCNearbyServiceBrowser, error: NSError) -> Void) -> Self {
        ce._browserAndDidNotStartBrowsingForPeers = handle
        rebindingDelegate()
        return self
    }
    
}

internal class MCNearbyServiceBrowser_Delegate: NSObject, MCNearbyServiceBrowserDelegate {
    
    var _browser: ((MCNearbyServiceBrowser, MCPeerID, [String : String]?) -> Void)?
    var _browserAndLostPeer: ((MCNearbyServiceBrowser, MCPeerID) -> Void)?
    var _browserAndDidNotStartBrowsingForPeers: ((MCNearbyServiceBrowser, NSError) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "browser:foundPeer:withDiscoveryInfo:" : _browser,
            "browser:lostPeer:" : _browserAndLostPeer,
            "browser:didNotStartBrowsingForPeers:" : _browserAndDidNotStartBrowsingForPeers,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        _browser!(browser, peerID, info)
    }
    @objc func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        _browserAndLostPeer!(browser, peerID)
    }
    @objc func browser(browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: NSError) {
        _browserAndDidNotStartBrowsingForPeers!(browser, error)
    }
}
