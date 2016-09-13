//
//  CE_MCSession.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
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
    
    public func ce_session(handle: ((MCSession, MCPeerID, MCSessionState) -> Void)) -> Self {
        ce._session = handle
        rebindingDelegate()
        return self
    }
    public func ce_session_didReceive(handle: ((MCSession, Data, MCPeerID) -> Void)) -> Self {
        ce._session_didReceive = handle
        rebindingDelegate()
        return self
    }
    public func ce_session_didReceive_didReceive(handle: ((MCSession, InputStream, String, MCPeerID) -> Void)) -> Self {
        ce._session_didReceive_didReceive = handle
        rebindingDelegate()
        return self
    }
    public func ce_session_didStartReceivingResourceWithName(handle: ((MCSession, String, MCPeerID, Progress) -> Void)) -> Self {
        ce._session_didStartReceivingResourceWithName = handle
        rebindingDelegate()
        return self
    }
    public func ce_session_didFinishReceivingResourceWithName(handle: ((MCSession, String, MCPeerID, URL, Error?) -> Void)) -> Self {
        ce._session_didFinishReceivingResourceWithName = handle
        rebindingDelegate()
        return self
    }
    public func ce_session_didReceiveCertificate(handle: ((MCSession, [Any]?, MCPeerID) -> Void)) -> Self {
        ce._session_didReceiveCertificate = handle
        rebindingDelegate()
        return self
    }
    
}

internal class MCSession_Delegate: NSObject, MCSessionDelegate {
    
    var _session: ((MCSession, MCPeerID, MCSessionState) -> Void)?
    var _session_didReceive: ((MCSession, Data, MCPeerID) -> Void)?
    var _session_didReceive_didReceive: ((MCSession, InputStream, String, MCPeerID) -> Void)?
    var _session_didStartReceivingResourceWithName: ((MCSession, String, MCPeerID, Progress) -> Void)?
    var _session_didFinishReceivingResourceWithName: ((MCSession, String, MCPeerID, URL, Error?) -> Void)?
    var _session_didReceiveCertificate: ((MCSession, [Any]?, MCPeerID) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(session(_:peer:didChange:)) : _session,
            #selector(session(_:didReceive:fromPeer:)) : _session_didReceive,
            #selector(session(_:didReceive:withName:fromPeer:)) : _session_didReceive_didReceive,
            #selector(session(_:didStartReceivingResourceWithName:fromPeer:with:)) : _session_didStartReceivingResourceWithName,
            #selector(session(_:didFinishReceivingResourceWithName:fromPeer:at:withError:)) : _session_didFinishReceivingResourceWithName,
            #selector(session(_:didReceiveCertificate:fromPeer:)) : _session_didReceiveCertificate,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        _session!(session, peerID, state)
    }
    @objc func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        _session_didReceive!(session, data, peerID)
    }
    @objc func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        _session_didReceive_didReceive!(session, stream, streamName, peerID)
    }
    @objc func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        _session_didStartReceivingResourceWithName!(session, resourceName, peerID, progress)
    }
    @objc func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        _session_didFinishReceivingResourceWithName!(session, resourceName, peerID, localURL, error)
    }
    @objc func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID) {
        _session_didReceiveCertificate!(session, certificate, peerID)
    }
}
