//
//  CE_GKMatch.swift
//  Centipede
//
//  Created by kelei on 2016/9/14.
//  Copyright (c) 2016年 kelei. All rights reserved.
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
    
    public func ce_match_didReceive(handle: @escaping (GKMatch, Data, GKPlayer) -> Void) -> Self {
        ce._match_didReceive = handle
        rebindingDelegate()
        return self
    }
    public func ce_match_didReceive_didReceive(handle: @escaping (GKMatch, Data, String) -> Void) -> Self {
        ce._match_didReceive_didReceive = handle
        rebindingDelegate()
        return self
    }
    public func ce_match_player(handle: @escaping (GKMatch, GKPlayer, GKPlayerConnectionState) -> Void) -> Self {
        ce._match_player = handle
        rebindingDelegate()
        return self
    }
    public func ce_match_didFailWithError(handle: @escaping (GKMatch, Error?) -> Void) -> Self {
        ce._match_didFailWithError = handle
        rebindingDelegate()
        return self
    }
    public func ce_match_shouldReinviteDisconnectedPlayer(handle: @escaping (GKMatch, GKPlayer) -> Bool) -> Self {
        ce._match_shouldReinviteDisconnectedPlayer = handle
        rebindingDelegate()
        return self
    }
    public func ce_match_shouldReinvitePlayer(handle: @escaping (GKMatch, String) -> Bool) -> Self {
        ce._match_shouldReinvitePlayer = handle
        rebindingDelegate()
        return self
    }
    
}

internal class GKMatch_Delegate: NSObject, GKMatchDelegate {
    
    var _match_didReceive: ((GKMatch, Data, GKPlayer) -> Void)?
    var _match_didReceive_didReceive: ((GKMatch, Data, String) -> Void)?
    var _match_player: ((GKMatch, GKPlayer, GKPlayerConnectionState) -> Void)?
    var _match_didFailWithError: ((GKMatch, Error?) -> Void)?
    var _match_shouldReinviteDisconnectedPlayer: ((GKMatch, GKPlayer) -> Bool)?
    var _match_shouldReinvitePlayer: ((GKMatch, String) -> Bool)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(match(_:didReceive:fromRemotePlayer:)) : _match_didReceive,
            #selector(match(_:didReceive:fromPlayer:)) : _match_didReceive_didReceive,
            #selector(match(_:player:didChange:)) : _match_player,
            #selector(match(_:didFailWithError:)) : _match_didFailWithError,
            #selector(match(_:shouldReinviteDisconnectedPlayer:)) : _match_shouldReinviteDisconnectedPlayer,
            #selector(match(_:shouldReinvitePlayer:)) : _match_shouldReinvitePlayer,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        _match_didReceive!(match, data, player)
    }
    @objc func match(_ match: GKMatch, didReceive data: Data, fromPlayer playerID: String) {
        _match_didReceive_didReceive!(match, data, playerID)
    }
    @objc func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        _match_player!(match, player, state)
    }
    @objc func match(_ match: GKMatch, didFailWithError error: Error?) {
        _match_didFailWithError!(match, error)
    }
    @objc func match(_ match: GKMatch, shouldReinviteDisconnectedPlayer player: GKPlayer) -> Bool {
        return _match_shouldReinviteDisconnectedPlayer!(match, player)
    }
    @objc func match(_ match: GKMatch, shouldReinvitePlayer playerID: String) -> Bool {
        return _match_shouldReinvitePlayer!(match, playerID)
    }
}
