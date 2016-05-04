//
//  CE_MCBrowserViewController.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
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
    
    public func ce_didFinish(handle: (browserViewController: MCBrowserViewController) -> Void) -> Self {
        ce._didFinish = handle
        rebindingDelegate()
        return self
    }
    public func ce_wasCancelled(handle: (browserViewController: MCBrowserViewController) -> Void) -> Self {
        ce._wasCancelled = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldPresentNearbyPeer(handle: (browserViewController: MCBrowserViewController, peerID: MCPeerID!, info: [String : String]?) -> Bool) -> Self {
        ce._shouldPresentNearbyPeer = handle
        rebindingDelegate()
        return self
    }
    
}

internal class MCBrowserViewController_Delegate: UIViewController_Delegate, MCBrowserViewControllerDelegate {
    
    var _didFinish: ((MCBrowserViewController) -> Void)?
    var _wasCancelled: ((MCBrowserViewController) -> Void)?
    var _shouldPresentNearbyPeer: ((MCBrowserViewController, MCPeerID!, [String : String]?) -> Bool)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(browserViewControllerDidFinish(_:)) : _didFinish,
            #selector(browserViewControllerWasCancelled(_:)) : _wasCancelled,
            #selector(browserViewController(_:shouldPresentNearbyPeer:withDiscoveryInfo:)) : _shouldPresentNearbyPeer,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func browserViewControllerDidFinish(browserViewController: MCBrowserViewController) {
        _didFinish!(browserViewController)
    }
    @objc func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController) {
        _wasCancelled!(browserViewController)
    }
    @objc func browserViewController(browserViewController: MCBrowserViewController, shouldPresentNearbyPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) -> Bool {
        return _shouldPresentNearbyPeer!(browserViewController, peerID, info)
    }
}
