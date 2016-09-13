//
//  CE_AVAudioRecorder.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import AVFoundation

public extension AVAudioRecorder {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: AVAudioRecorder_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? AVAudioRecorder_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: AVAudioRecorder_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is AVAudioRecorder_Delegate {
                return obj as! AVAudioRecorder_Delegate
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
    
    internal func getDelegateInstance() -> AVAudioRecorder_Delegate {
        return AVAudioRecorder_Delegate()
    }
    
    public func ce_audioRecorderDidFinishRecording(handle: ((AVAudioRecorder, Bool) -> Void)) -> Self {
        ce._audioRecorderDidFinishRecording = handle
        rebindingDelegate()
        return self
    }
    public func ce_audioRecorderEncodeErrorDidOccur(handle: ((AVAudioRecorder, Error?) -> Void)) -> Self {
        ce._audioRecorderEncodeErrorDidOccur = handle
        rebindingDelegate()
        return self
    }
    public func ce_audioRecorderBeginInterruption(handle: ((AVAudioRecorder) -> Void)) -> Self {
        ce._audioRecorderBeginInterruption = handle
        rebindingDelegate()
        return self
    }
    public func ce_audioRecorderEndInterruption(handle: ((AVAudioRecorder, Int) -> Void)) -> Self {
        ce._audioRecorderEndInterruption = handle
        rebindingDelegate()
        return self
    }
    
}

internal class AVAudioRecorder_Delegate: NSObject, AVAudioRecorderDelegate {
    
    var _audioRecorderDidFinishRecording: ((AVAudioRecorder, Bool) -> Void)?
    var _audioRecorderEncodeErrorDidOccur: ((AVAudioRecorder, Error?) -> Void)?
    var _audioRecorderBeginInterruption: ((AVAudioRecorder) -> Void)?
    var _audioRecorderEndInterruption: ((AVAudioRecorder, Int) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(audioRecorderDidFinishRecording(_:successfully:)) : _audioRecorderDidFinishRecording,
            #selector(audioRecorderEncodeErrorDidOccur(_:error:)) : _audioRecorderEncodeErrorDidOccur,
            #selector(audioRecorderBeginInterruption(_:)) : _audioRecorderBeginInterruption,
            #selector(audioRecorderEndInterruption(_:withOptions:)) : _audioRecorderEndInterruption,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        _audioRecorderDidFinishRecording!(recorder, flag)
    }
    @objc func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        _audioRecorderEncodeErrorDidOccur!(recorder, error)
    }
    @objc func audioRecorderBeginInterruption(_ recorder: AVAudioRecorder) {
        _audioRecorderBeginInterruption!(recorder)
    }
    @objc func audioRecorderEndInterruption(_ recorder: AVAudioRecorder, withOptions flags: Int) {
        _audioRecorderEndInterruption!(recorder, flags)
    }
}
