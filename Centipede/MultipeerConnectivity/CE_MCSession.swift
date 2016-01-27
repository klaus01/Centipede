//
//  CE_MCSession.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import MultipeerConnectivity

public extension MCSession {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: MCSession_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? MCSession_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: MCSession_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is MCSession_Delegate {
                return obj as! MCSession_Delegate
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
    
    internal func getDelegateInstance() -> MCSession_Delegate {
        return MCSession_Delegate()
    }
    
    public func ce_peerDidChangeState(handle: (session: MCSession, peerID: MCPeerID, state: MCSessionState) -> Void) -> Self {
        ce._peerDidChangeState = handle
        rebindingDelegate()
        return self
    }
    public func ce_didReceiveData(handle: (session: MCSession, data: NSData, peerID: MCPeerID) -> Void) -> Self {
        ce._didReceiveData = handle
        rebindingDelegate()
        return self
    }
    public func ce_didReceiveStream(handle: (session: MCSession, stream: NSInputStream, streamName: String, peerID: MCPeerID) -> Void) -> Self {
        ce._didReceiveStream = handle
        rebindingDelegate()
        return self
    }
    public func ce_didStartReceivingResourceWithName(handle: (session: MCSession, resourceName: String, peerID: MCPeerID, progress: NSProgress) -> Void) -> Self {
        ce._didStartReceivingResourceWithName = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFinishReceivingResourceWithName(handle: (session: MCSession, resourceName: String, peerID: MCPeerID, localURL: NSURL, error: NSError?) -> Void) -> Self {
        ce._didFinishReceivingResourceWithName = handle
        rebindingDelegate()
        return self
    }
    public func ce_didReceiveCertificate(handle: (session: MCSession, certificate: [AnyObject]?, peerID: MCPeerID, certificateHandler: (Bool) -> Void) -> Void) -> Self {
        ce._didReceiveCertificate = handle
        rebindingDelegate()
        return self
    }
    
}

internal class MCSession_Delegate: NSObject, MCSessionDelegate {
    
    var _peerDidChangeState: ((MCSession, MCPeerID, MCSessionState) -> Void)?
    var _didReceiveData: ((MCSession, NSData, MCPeerID) -> Void)?
    var _didReceiveStream: ((MCSession, NSInputStream, String, MCPeerID) -> Void)?
    var _didStartReceivingResourceWithName: ((MCSession, String, MCPeerID, NSProgress) -> Void)?
    var _didFinishReceivingResourceWithName: ((MCSession, String, MCPeerID, NSURL, NSError?) -> Void)?
    var _didReceiveCertificate: ((MCSession, [AnyObject]?, MCPeerID, (Bool) -> Void) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "session:peer:didChangeState:" : _peerDidChangeState,
            "session:didReceiveData:fromPeer:" : _didReceiveData,
            "session:didReceiveStream:withName:fromPeer:" : _didReceiveStream,
            "session:didStartReceivingResourceWithName:fromPeer:withProgress:" : _didStartReceivingResourceWithName,
            "session:didFinishReceivingResourceWithName:fromPeer:atURL:withError:" : _didFinishReceivingResourceWithName,
            "session:didReceiveCertificate:fromPeer:certificateHandler:" : _didReceiveCertificate,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        _peerDidChangeState!(session, peerID, state)
    }
    @objc func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        _didReceiveData!(session, data, peerID)
    }
    @objc func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        _didReceiveStream!(session, stream, streamName, peerID)
    }
    @objc func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        _didStartReceivingResourceWithName!(session, resourceName, peerID, progress)
    }
    @objc func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        _didFinishReceivingResourceWithName!(session, resourceName, peerID, localURL, error)
    }
    @objc func session(session: MCSession, didReceiveCertificate certificate: [AnyObject]?, fromPeer peerID: MCPeerID, certificateHandler: ((Bool) -> Void)) -> Void {
        return _didReceiveCertificate!(session, certificate, peerID, certificateHandler)
    }
}
