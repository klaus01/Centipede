//
//  CE_AVAudioPlayer.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import AVFoundation

public extension AVAudioPlayer {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: AVAudioPlayer_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? AVAudioPlayer_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: AVAudioPlayer_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
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
    
    public func ce_audioPlayerDidFinishPlaying(handle: ((AVAudioPlayer, Bool) -> Void)) -> Self {
        ce._audioPlayerDidFinishPlaying = handle
        rebindingDelegate()
        return self
    }
    public func ce_audioPlayerDecodeErrorDidOccur(handle: ((AVAudioPlayer, Error?) -> Void)) -> Self {
        ce._audioPlayerDecodeErrorDidOccur = handle
        rebindingDelegate()
        return self
    }
    public func ce_audioPlayerBeginInterruption(handle: ((AVAudioPlayer) -> Void)) -> Self {
        ce._audioPlayerBeginInterruption = handle
        rebindingDelegate()
        return self
    }
    public func ce_audioPlayerEndInterruption(handle: ((AVAudioPlayer, Int) -> Void)) -> Self {
        ce._audioPlayerEndInterruption = handle
        rebindingDelegate()
        return self
    }
    
}

internal class AVAudioPlayer_Delegate: NSObject, AVAudioPlayerDelegate {
    
    var _audioPlayerDidFinishPlaying: ((AVAudioPlayer, Bool) -> Void)?
    var _audioPlayerDecodeErrorDidOccur: ((AVAudioPlayer, Error?) -> Void)?
    var _audioPlayerBeginInterruption: ((AVAudioPlayer) -> Void)?
    var _audioPlayerEndInterruption: ((AVAudioPlayer, Int) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(audioPlayerDidFinishPlaying(_:successfully:)) : _audioPlayerDidFinishPlaying,
            #selector(audioPlayerDecodeErrorDidOccur(_:error:)) : _audioPlayerDecodeErrorDidOccur,
            #selector(audioPlayerBeginInterruption(_:)) : _audioPlayerBeginInterruption,
            #selector(audioPlayerEndInterruption(_:withOptions:)) : _audioPlayerEndInterruption,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        _audioPlayerDidFinishPlaying!(player, flag)
    }
    @objc func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        _audioPlayerDecodeErrorDidOccur!(player, error)
    }
    @objc func audioPlayerBeginInterruption(_ player: AVAudioPlayer) {
        _audioPlayerBeginInterruption!(player)
    }
    @objc func audioPlayerEndInterruption(_ player: AVAudioPlayer, withOptions flags: Int) {
        _audioPlayerEndInterruption!(player, flags)
    }
}
