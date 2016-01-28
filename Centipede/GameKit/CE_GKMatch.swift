//
//  CE_GKMatch.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import GameKit

public extension GKMatch {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: GKMatch_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? GKMatch_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: GKMatch_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is GKMatch_Delegate {
                return obj as! GKMatch_Delegate
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
    
    internal func getDelegateInstance() -> GKMatch_Delegate {
        return GKMatch_Delegate()
    }
    
    public func ce_didReceiveData(handle: (match: GKMatch, data: NSData, player: GKPlayer) -> Void) -> Self {
        ce._didReceiveData = handle
        rebindingDelegate()
        return self
    }
    public func ce_didReceiveDataAndDidReceiveData(handle: (match: GKMatch, data: NSData, playerID: String) -> Void) -> Self {
        ce._didReceiveDataAndDidReceiveData = handle
        rebindingDelegate()
        return self
    }
    public func ce_playerDidChangeConnectionState(handle: (match: GKMatch, player: GKPlayer, state: GKPlayerConnectionState) -> Void) -> Self {
        ce._playerDidChangeConnectionState = handle
        rebindingDelegate()
        return self
    }
    public func ce_playerDidChangeState(handle: (match: GKMatch, playerID: String, state: GKPlayerConnectionState) -> Void) -> Self {
        ce._playerDidChangeState = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFailWithError(handle: (match: GKMatch, error: NSError?) -> Void) -> Self {
        ce._didFailWithError = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldReinviteDisconnectedPlayer(handle: (match: GKMatch, player: GKPlayer) -> Bool) -> Self {
        ce._shouldReinviteDisconnectedPlayer = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldReinvitePlayer(handle: (match: GKMatch, playerID: String) -> Bool) -> Self {
        ce._shouldReinvitePlayer = handle
        rebindingDelegate()
        return self
    }
    
}

internal class GKMatch_Delegate: NSObject, GKMatchDelegate {
    
    var _didReceiveData: ((GKMatch, NSData, GKPlayer) -> Void)?
    var _didReceiveDataAndDidReceiveData: ((GKMatch, NSData, String) -> Void)?
    var _playerDidChangeConnectionState: ((GKMatch, GKPlayer, GKPlayerConnectionState) -> Void)?
    var _playerDidChangeState: ((GKMatch, String, GKPlayerConnectionState) -> Void)?
    var _didFailWithError: ((GKMatch, NSError?) -> Void)?
    var _shouldReinviteDisconnectedPlayer: ((GKMatch, GKPlayer) -> Bool)?
    var _shouldReinvitePlayer: ((GKMatch, String) -> Bool)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "match:didReceiveData:fromRemotePlayer:" : _didReceiveData,
            "match:didReceiveData:fromPlayer:" : _didReceiveDataAndDidReceiveData,
            "match:player:didChangeConnectionState:" : _playerDidChangeConnectionState,
            "match:player:didChangeState:" : _playerDidChangeState,
            "match:didFailWithError:" : _didFailWithError,
            "match:shouldReinviteDisconnectedPlayer:" : _shouldReinviteDisconnectedPlayer,
            "match:shouldReinvitePlayer:" : _shouldReinvitePlayer,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func match(match: GKMatch, didReceiveData data: NSData, fromRemotePlayer player: GKPlayer) {
        _didReceiveData!(match, data, player)
    }
    @objc func match(match: GKMatch, didReceiveData data: NSData, fromPlayer playerID: String) {
        _didReceiveDataAndDidReceiveData!(match, data, playerID)
    }
    @objc func match(match: GKMatch, player: GKPlayer, didChangeConnectionState state: GKPlayerConnectionState) {
        _playerDidChangeConnectionState!(match, player, state)
    }
    @objc func match(match: GKMatch, player playerID: String, didChangeState state: GKPlayerConnectionState) {
        _playerDidChangeState!(match, playerID, state)
    }
    @objc func match(match: GKMatch, didFailWithError error: NSError?) {
        _didFailWithError!(match, error)
    }
    @objc func match(match: GKMatch, shouldReinviteDisconnectedPlayer player: GKPlayer) -> Bool {
        return _shouldReinviteDisconnectedPlayer!(match, player)
    }
    @objc func match(match: GKMatch, shouldReinvitePlayer playerID: String) -> Bool {
        return _shouldReinvitePlayer!(match, playerID)
    }
}
