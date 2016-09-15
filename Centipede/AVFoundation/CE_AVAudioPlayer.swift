//
//  CE_AVAudioPlayer.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import AVFoundation

extension AVAudioPlayer {
    
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
    
    @discardableResult
    public func ce_audioPlayerDidFinishPlaying_successfully(handle: @escaping (AVAudioPlayer, Bool) -> Void) -> Self {
        ce._audioPlayerDidFinishPlaying_successfully = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_audioPlayerDecodeErrorDidOccur_error(handle: @escaping (AVAudioPlayer, Error?) -> Void) -> Self {
        ce._audioPlayerDecodeErrorDidOccur_error = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_audioPlayerBeginInterruption(handle: @escaping (AVAudioPlayer) -> Void) -> Self {
        ce._audioPlayerBeginInterruption = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_audioPlayerEndInterruption_withOptions(handle: @escaping (AVAudioPlayer, Int) -> Void) -> Self {
        ce._audioPlayerEndInterruption_withOptions = handle
        rebindingDelegate()
        return self
    }
    
}

internal class AVAudioPlayer_Delegate: NSObject, AVAudioPlayerDelegate {
    
    var _audioPlayerDidFinishPlaying_successfully: ((AVAudioPlayer, Bool) -> Void)?
    var _audioPlayerDecodeErrorDidOccur_error: ((AVAudioPlayer, Error?) -> Void)?
    var _audioPlayerBeginInterruption: ((AVAudioPlayer) -> Void)?
    var _audioPlayerEndInterruption_withOptions: ((AVAudioPlayer, Int) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(audioPlayerDidFinishPlaying(_:successfully:)) : _audioPlayerDidFinishPlaying_successfully,
            #selector(audioPlayerDecodeErrorDidOccur(_:error:)) : _audioPlayerDecodeErrorDidOccur_error,
            #selector(audioPlayerBeginInterruption(_:)) : _audioPlayerBeginInterruption,
            #selector(audioPlayerEndInterruption(_:withOptions:)) : _audioPlayerEndInterruption_withOptions,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        _audioPlayerDidFinishPlaying_successfully!(player, flag)
    }
    @objc func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        _audioPlayerDecodeErrorDidOccur_error!(player, error)
    }
    @objc func audioPlayerBeginInterruption(_ player: AVAudioPlayer) {
        _audioPlayerBeginInterruption!(player)
    }
    @objc func audioPlayerEndInterruption(_ player: AVAudioPlayer, withOptions flags: Int) {
        _audioPlayerEndInterruption_withOptions!(player, flags)
    }
}
