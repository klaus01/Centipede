//
//  CE_AVSpeechSynthesizer.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import AVFoundation

public extension AVSpeechSynthesizer {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: AVSpeechSynthesizer_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? AVSpeechSynthesizer_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: AVSpeechSynthesizer_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is AVSpeechSynthesizer_Delegate {
                return obj as! AVSpeechSynthesizer_Delegate
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
    
    internal func getDelegateInstance() -> AVSpeechSynthesizer_Delegate {
        return AVSpeechSynthesizer_Delegate()
    }
    
    public func ce_didStartSpeechUtterance(handle: (synthesizer: AVSpeechSynthesizer, utterance: AVSpeechUtterance) -> Void) -> Self {
        ce._didStartSpeechUtterance = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFinishSpeechUtterance(handle: (synthesizer: AVSpeechSynthesizer, utterance: AVSpeechUtterance) -> Void) -> Self {
        ce._didFinishSpeechUtterance = handle
        rebindingDelegate()
        return self
    }
    public func ce_didPauseSpeechUtterance(handle: (synthesizer: AVSpeechSynthesizer, utterance: AVSpeechUtterance) -> Void) -> Self {
        ce._didPauseSpeechUtterance = handle
        rebindingDelegate()
        return self
    }
    public func ce_didContinueSpeechUtterance(handle: (synthesizer: AVSpeechSynthesizer, utterance: AVSpeechUtterance) -> Void) -> Self {
        ce._didContinueSpeechUtterance = handle
        rebindingDelegate()
        return self
    }
    public func ce_didCancelSpeechUtterance(handle: (synthesizer: AVSpeechSynthesizer, utterance: AVSpeechUtterance) -> Void) -> Self {
        ce._didCancelSpeechUtterance = handle
        rebindingDelegate()
        return self
    }
    public func ce_willSpeakRangeOfSpeechString(handle: (synthesizer: AVSpeechSynthesizer, characterRange: NSRange, utterance: AVSpeechUtterance) -> Void) -> Self {
        ce._willSpeakRangeOfSpeechString = handle
        rebindingDelegate()
        return self
    }
    
}

internal class AVSpeechSynthesizer_Delegate: NSObject, AVSpeechSynthesizerDelegate {
    
    var _didStartSpeechUtterance: ((AVSpeechSynthesizer, AVSpeechUtterance) -> Void)?
    var _didFinishSpeechUtterance: ((AVSpeechSynthesizer, AVSpeechUtterance) -> Void)?
    var _didPauseSpeechUtterance: ((AVSpeechSynthesizer, AVSpeechUtterance) -> Void)?
    var _didContinueSpeechUtterance: ((AVSpeechSynthesizer, AVSpeechUtterance) -> Void)?
    var _didCancelSpeechUtterance: ((AVSpeechSynthesizer, AVSpeechUtterance) -> Void)?
    var _willSpeakRangeOfSpeechString: ((AVSpeechSynthesizer, NSRange, AVSpeechUtterance) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(speechSynthesizer(_:didStartSpeechUtterance:)) : _didStartSpeechUtterance,
            #selector(speechSynthesizer(_:didFinishSpeechUtterance:)) : _didFinishSpeechUtterance,
            #selector(speechSynthesizer(_:didPauseSpeechUtterance:)) : _didPauseSpeechUtterance,
            #selector(speechSynthesizer(_:didContinueSpeechUtterance:)) : _didContinueSpeechUtterance,
            #selector(speechSynthesizer(_:didCancelSpeechUtterance:)) : _didCancelSpeechUtterance,
            #selector(speechSynthesizer(_:willSpeakRangeOfSpeechString:utterance:)) : _willSpeakRangeOfSpeechString,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didStartSpeechUtterance utterance: AVSpeechUtterance) {
        _didStartSpeechUtterance!(synthesizer, utterance)
    }
    @objc func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didFinishSpeechUtterance utterance: AVSpeechUtterance) {
        _didFinishSpeechUtterance!(synthesizer, utterance)
    }
    @objc func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didPauseSpeechUtterance utterance: AVSpeechUtterance) {
        _didPauseSpeechUtterance!(synthesizer, utterance)
    }
    @objc func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didContinueSpeechUtterance utterance: AVSpeechUtterance) {
        _didContinueSpeechUtterance!(synthesizer, utterance)
    }
    @objc func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didCancelSpeechUtterance utterance: AVSpeechUtterance) {
        _didCancelSpeechUtterance!(synthesizer, utterance)
    }
    @objc func speechSynthesizer(synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        _willSpeakRangeOfSpeechString!(synthesizer, characterRange, utterance)
    }
}
