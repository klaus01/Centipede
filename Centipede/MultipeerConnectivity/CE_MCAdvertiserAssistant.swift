//
//  CE_MCAdvertiserAssistant.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import MultipeerConnectivity

public extension MCAdvertiserAssistant {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: MCAdvertiserAssistant_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? MCAdvertiserAssistant_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: MCAdvertiserAssistant_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is MCAdvertiserAssistant_Delegate {
                return obj as! MCAdvertiserAssistant_Delegate
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
    
    internal func getDelegateInstance() -> MCAdvertiserAssistant_Delegate {
        return MCAdvertiserAssistant_Delegate()
    }
    
    public func ce_willPresentInvitation(handle: (advertiserAssistant: MCAdvertiserAssistant) -> Void) -> Self {
        ce._willPresentInvitation = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDismissInvitation(handle: (advertiserAssistant: MCAdvertiserAssistant) -> Void) -> Self {
        ce._didDismissInvitation = handle
        rebindingDelegate()
        return self
    }
    
}

internal class MCAdvertiserAssistant_Delegate: NSObject, MCAdvertiserAssistantDelegate {
    
    var _willPresentInvitation: ((MCAdvertiserAssistant) -> Void)?
    var _didDismissInvitation: ((MCAdvertiserAssistant) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(advertiserAssistantWillPresentInvitation(_:)) : _willPresentInvitation,
            #selector(advertiserAssistantDidDismissInvitation(_:)) : _didDismissInvitation,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func advertiserAssistantWillPresentInvitation(advertiserAssistant: MCAdvertiserAssistant) {
        _willPresentInvitation!(advertiserAssistant)
    }
    @objc func advertiserAssistantDidDismissInvitation(advertiserAssistant: MCAdvertiserAssistant) {
        _didDismissInvitation!(advertiserAssistant)
    }
}
