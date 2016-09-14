//
//  CE_MCNearbyServiceAdvertiser.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import MultipeerConnectivity

public extension MCNearbyServiceAdvertiser {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: MCNearbyServiceAdvertiser_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? MCNearbyServiceAdvertiser_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
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
    
    @discardableResult
    public func ce_advertiser_didReceiveInvitationFromPeer(handle: @escaping (MCNearbyServiceAdvertiser, MCPeerID, Data?, @escaping (Bool, MCSession?) -> Void) -> Void) -> Self {
        ce._advertiser_didReceiveInvitationFromPeer = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_advertiser_didNotStartAdvertisingPeer(handle: @escaping (MCNearbyServiceAdvertiser, Error) -> Void) -> Self {
        ce._advertiser_didNotStartAdvertisingPeer = handle
        rebindingDelegate()
        return self
    }
    
}

internal class MCNearbyServiceAdvertiser_Delegate: NSObject, MCNearbyServiceAdvertiserDelegate {
    
    var _advertiser_didReceiveInvitationFromPeer: ((MCNearbyServiceAdvertiser, MCPeerID, Data?, @escaping (Bool, MCSession?) -> Void) -> Void)?
    var _advertiser_didNotStartAdvertisingPeer: ((MCNearbyServiceAdvertiser, Error) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(advertiser(_:didReceiveInvitationFromPeer:withContext:invitationHandler:)) : _advertiser_didReceiveInvitationFromPeer,
            #selector(advertiser(_:didNotStartAdvertisingPeer:)) : _advertiser_didNotStartAdvertisingPeer,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        _advertiser_didReceiveInvitationFromPeer!(advertiser, peerID, context, invitationHandler)
    }
    @objc func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        _advertiser_didNotStartAdvertisingPeer!(advertiser, error)
    }
}
