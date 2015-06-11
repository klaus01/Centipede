//
//  CE_AVAudioPlayer.swift
//  Centipede
//
//  Created by kelei on 2015/6/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import AVFoundation

public extension AVAudioPlayer {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: AVAudioPlayer_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? AVAudioPlayer_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: AVAudioPlayer_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is AVAudioPlayer_Delegate {
                return obj as! AVAudioPlayer_Delegate
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
    
    internal func getDelegateInstance() -> AVAudioPlayer_Delegate {
        return AVAudioPlayer_Delegate()
    }
    
    public func ce_didFinishPlaying(handle: (player: AVAudioPlayer, flag: Bool) -> Void) -> Self {
        ce._didFinishPlaying = handle
        rebindingDelegate()
        return self
    }
    public func ce_decodeErrorDidOccur(handle: (player: AVAudioPlayer, error: NSError!) -> Void) -> Self {
        ce._decodeErrorDidOccur = handle
        rebindingDelegate()
        return self
    }
    public func ce_beginInterruption(handle: (player: AVAudioPlayer) -> Void) -> Self {
        ce._beginInterruption = handle
        rebindingDelegate()
        return self
    }
    public func ce_endInterruption(handle: (player: AVAudioPlayer, flags: Int) -> Void) -> Self {
        ce._endInterruption = handle
        rebindingDelegate()
        return self
    }
    
}

internal class AVAudioPlayer_Delegate: NSObject, AVAudioPlayerDelegate {
    
    var _didFinishPlaying: ((AVAudioPlayer, Bool) -> Void)?
    var _decodeErrorDidOccur: ((AVAudioPlayer, NSError!) -> Void)?
    var _beginInterruption: ((AVAudioPlayer) -> Void)?
    var _endInterruption: ((AVAudioPlayer, Int) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "audioPlayerDidFinishPlaying:successfully:" : _didFinishPlaying,
            "audioPlayerDecodeErrorDidOccur:error:" : _decodeErrorDidOccur,
            "audioPlayerBeginInterruption:" : _beginInterruption,
            "audioPlayerEndInterruption:withOptions:" : _endInterruption,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        _didFinishPlaying!(player, flag)
    }
    @objc func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError!) {
        _decodeErrorDidOccur!(player, error)
    }
    @objc func audioPlayerBeginInterruption(player: AVAudioPlayer) {
        _beginInterruption!(player)
    }
    @objc func audioPlayerEndInterruption(player: AVAudioPlayer, withOptions flags: Int) {
        _endInterruption!(player, flags)
    }
}
