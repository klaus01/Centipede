//
//  CE_MCAdvertiserAssistant.swift
//  Centipede
//
//  Created by kelei on 2016/9/14.
//  Copyright (c) 2016年 kelei. All rights reserved.
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
    
    public func ce_advertiserAssistantWillPresentInvitation(handle: @escaping (MCAdvertiserAssistant) -> Void) -> Self {
        ce._advertiserAssistantWillPresentInvitation = handle
        rebindingDelegate()
        return self
    }
    public func ce_advertiserAssistantDidDismissInvitation(handle: @escaping (MCAdvertiserAssistant) -> Void) -> Self {
        ce._advertiserAssistantDidDismissInvitation = handle
        rebindingDelegate()
        return self
    }
    
}

internal class MCAdvertiserAssistant_Delegate: NSObject, MCAdvertiserAssistantDelegate {
    
    var _advertiserAssistantWillPresentInvitation: ((MCAdvertiserAssistant) -> Void)?
    var _advertiserAssistantDidDismissInvitation: ((MCAdvertiserAssistant) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(advertiserAssistantWillPresentInvitation(_:)) : _advertiserAssistantWillPresentInvitation,
            #selector(advertiserAssistantDidDismissInvitation(_:)) : _advertiserAssistantDidDismissInvitation,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func advertiserAssistantWillPresentInvitation(_ advertiserAssistant: MCAdvertiserAssistant) {
        _advertiserAssistantWillPresentInvitation!(advertiserAssistant)
    }
    @objc func advertiserAssistantDidDismissInvitation(_ advertiserAssistant: MCAdvertiserAssistant) {
        _advertiserAssistantDidDismissInvitation!(advertiserAssistant)
    }
}
