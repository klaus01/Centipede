//
//  CE_AVAudioRecorder.swift
//  Centipede
//
//  Created by kelei on 2015/6/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import AVFoundation

public extension AVAudioRecorder {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: AVAudioRecorder_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? AVAudioRecorder_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: AVAudioRecorder_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
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
    
    public func ce_didFinishRecording(handle: (recorder: AVAudioRecorder, flag: Bool) -> Void) -> Self {
        ce._didFinishRecording = handle
        rebindingDelegate()
        return self
    }
    public func ce_encodeErrorDidOccur(handle: (recorder: AVAudioRecorder, error: NSError!) -> Void) -> Self {
        ce._encodeErrorDidOccur = handle
        rebindingDelegate()
        return self
    }
    public func ce_beginInterruption(handle: (recorder: AVAudioRecorder) -> Void) -> Self {
        ce._beginInterruption = handle
        rebindingDelegate()
        return self
    }
    public func ce_endInterruption(handle: (recorder: AVAudioRecorder, flags: Int) -> Void) -> Self {
        ce._endInterruption = handle
        rebindingDelegate()
        return self
    }
    
}

internal class AVAudioRecorder_Delegate: NSObject, AVAudioRecorderDelegate {
    
    var _didFinishRecording: ((AVAudioRecorder, Bool) -> Void)?
    var _encodeErrorDidOccur: ((AVAudioRecorder, NSError!) -> Void)?
    var _beginInterruption: ((AVAudioRecorder) -> Void)?
    var _endInterruption: ((AVAudioRecorder, Int) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "audioRecorderDidFinishRecording:successfully:" : _didFinishRecording,
            "audioRecorderEncodeErrorDidOccur:error:" : _encodeErrorDidOccur,
            "audioRecorderBeginInterruption:" : _beginInterruption,
            "audioRecorderEndInterruption:withOptions:" : _endInterruption,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        _didFinishRecording!(recorder, flag)
    }
    @objc func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder, error: NSError!) {
        _encodeErrorDidOccur!(recorder, error)
    }
    @objc func audioRecorderBeginInterruption(recorder: AVAudioRecorder) {
        _beginInterruption!(recorder)
    }
    @objc func audioRecorderEndInterruption(recorder: AVAudioRecorder, withOptions flags: Int) {
        _endInterruption!(recorder, flags)
    }
}
