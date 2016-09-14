//
//  CE_MCBrowserViewController.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import MultipeerConnectivity

public extension MCBrowserViewController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: MCBrowserViewController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? MCBrowserViewController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: MCBrowserViewController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is MCBrowserViewController_Delegate {
                return obj as! MCBrowserViewController_Delegate
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
    
    internal override func getDelegateInstance() -> MCBrowserViewController_Delegate {
        return MCBrowserViewController_Delegate()
    }
    
    @discardableResult
    public func ce_browserViewControllerDidFinish(handle: @escaping (MCBrowserViewController) -> Void) -> Self {
        ce._browserViewControllerDidFinish = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_browserViewControllerWasCancelled(handle: @escaping (MCBrowserViewController) -> Void) -> Self {
        ce._browserViewControllerWasCancelled = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_browserViewController_shouldPresentNearbyPeer(handle: @escaping (MCBrowserViewController, MCPeerID, [String : String]?) -> Bool) -> Self {
        ce._browserViewController_shouldPresentNearbyPeer = handle
        rebindingDelegate()
        return self
    }
    
}

internal class MCBrowserViewController_Delegate: UIViewController_Delegate, MCBrowserViewControllerDelegate {
    
    var _browserViewControllerDidFinish: ((MCBrowserViewController) -> Void)?
    var _browserViewControllerWasCancelled: ((MCBrowserViewController) -> Void)?
    var _browserViewController_shouldPresentNearbyPeer: ((MCBrowserViewController, MCPeerID, [String : String]?) -> Bool)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(browserViewControllerDidFinish(_:)) : _browserViewControllerDidFinish,
            #selector(browserViewControllerWasCancelled(_:)) : _browserViewControllerWasCancelled,
            #selector(browserViewController(_:shouldPresentNearbyPeer:withDiscoveryInfo:)) : _browserViewController_shouldPresentNearbyPeer,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        _browserViewControllerDidFinish!(browserViewController)
    }
    @objc func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        _browserViewControllerWasCancelled!(browserViewController)
    }
    @objc func browserViewController(_ browserViewController: MCBrowserViewController, shouldPresentNearbyPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) -> Bool {
        return _browserViewController_shouldPresentNearbyPeer!(browserViewController, peerID, info)
    }
}
