//
//  CE_MCNearbyServiceAdvertiser.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import MultipeerConnectivity

public extension MCNearbyServiceAdvertiser {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: MCNearbyServiceAdvertiser_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? MCNearbyServiceAdvertiser_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: MCNearbyServiceAdvertiser_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is MCNearbyServiceAdvertiser_Delegate {
                return obj as! MCNearbyServiceAdvertiser_Delegate
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
    
    internal func getDelegateInstance() -> MCNearbyServiceAdvertiser_Delegate {
        return MCNearbyServiceAdvertiser_Delegate()
    }
    
    public func ce_advertiser(handle: (advertiser: MCNearbyServiceAdvertiser, peerID: MCPeerID!, context: NSData!, invitationHandler: ((Bool, MCSession!) -> Void)!) -> Void) -> Self {
        ce._advertiser = handle
        rebindingDelegate()
        return self
    }
    public func ce_advertiserAndDidNotStartAdvertisingPeer(handle: (advertiser: MCNearbyServiceAdvertiser, error: NSError!) -> Void) -> Self {
        ce._advertiserAndDidNotStartAdvertisingPeer = handle
        rebindingDelegate()
        return self
    }
    
}

internal class MCNearbyServiceAdvertiser_Delegate: NSObject, MCNearbyServiceAdvertiserDelegate {
    
    var _advertiser: ((MCNearbyServiceAdvertiser, MCPeerID!, NSData!, ((Bool, MCSession!) -> Void)!) -> Void)?
    var _advertiserAndDidNotStartAdvertisingPeer: ((MCNearbyServiceAdvertiser, NSError!) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "advertiser:didReceiveInvitationFromPeer:withContext:invitationHandler:" : _advertiser,
            "advertiser:didNotStartAdvertisingPeer:" : _advertiserAndDidNotStartAdvertisingPeer,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: NSData!, invitationHandler: ((Bool, MCSession!) -> Void)!) -> Void {
        return _advertiser!(advertiser, peerID, context, invitationHandler)
    }
    @objc func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError!) {
        _advertiserAndDidNotStartAdvertisingPeer!(advertiser, error)
    }
}
