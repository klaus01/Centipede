//
//  CE_AVAudioRecorder.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
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
    
    @discardableResult
    public func ce_audioRecorderDidFinishRecording_successfully(handle: @escaping (AVAudioRecorder, Bool) -> Void) -> Self {
        ce._audioRecorderDidFinishRecording_successfully = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_audioRecorderEncodeErrorDidOccur_error(handle: @escaping (AVAudioRecorder, Error?) -> Void) -> Self {
        ce._audioRecorderEncodeErrorDidOccur_error = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_audioRecorderBeginInterruption(handle: @escaping (AVAudioRecorder) -> Void) -> Self {
        ce._audioRecorderBeginInterruption = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_audioRecorderEndInterruption_withOptions(handle: @escaping (AVAudioRecorder, Int) -> Void) -> Self {
        ce._audioRecorderEndInterruption_withOptions = handle
        rebindingDelegate()
        return self
    }
    
}

internal class AVAudioRecorder_Delegate: NSObject, AVAudioRecorderDelegate {
    
    var _audioRecorderDidFinishRecording_successfully: ((AVAudioRecorder, Bool) -> Void)?
    var _audioRecorderEncodeErrorDidOccur_error: ((AVAudioRecorder, Error?) -> Void)?
    var _audioRecorderBeginInterruption: ((AVAudioRecorder) -> Void)?
    var _audioRecorderEndInterruption_withOptions: ((AVAudioRecorder, Int) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(audioRecorderDidFinishRecording(_:successfully:)) : _audioRecorderDidFinishRecording_successfully,
            #selector(audioRecorderEncodeErrorDidOccur(_:error:)) : _audioRecorderEncodeErrorDidOccur_error,
            #selector(audioRecorderBeginInterruption(_:)) : _audioRecorderBeginInterruption,
            #selector(audioRecorderEndInterruption(_:withOptions:)) : _audioRecorderEndInterruption_withOptions,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        _audioRecorderDidFinishRecording_successfully!(recorder, flag)
    }
    @objc func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        _audioRecorderEncodeErrorDidOccur_error!(recorder, error)
    }
    @objc func audioRecorderBeginInterruption(_ recorder: AVAudioRecorder) {
        _audioRecorderBeginInterruption!(recorder)
    }
    @objc func audioRecorderEndInterruption(_ recorder: AVAudioRecorder, withOptions flags: Int) {
        _audioRecorderEndInterruption_withOptions!(recorder, flags)
    }
}
