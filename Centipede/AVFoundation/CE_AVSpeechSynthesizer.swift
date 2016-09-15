//
//  CE_AVSpeechSynthesizer.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import AVFoundation

extension AVSpeechSynthesizer {
    
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
    
    @discardableResult
    public func ce_speechSynthesizer_didStart(handle: @escaping (AVSpeechSynthesizer, AVSpeechUtterance) -> Void) -> Self {
        ce._speechSynthesizer_didStart = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_speechSynthesizer_didFinish(handle: @escaping (AVSpeechSynthesizer, AVSpeechUtterance) -> Void) -> Self {
        ce._speechSynthesizer_didFinish = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_speechSynthesizer_didPause(handle: @escaping (AVSpeechSynthesizer, AVSpeechUtterance) -> Void) -> Self {
        ce._speechSynthesizer_didPause = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_speechSynthesizer_didContinue(handle: @escaping (AVSpeechSynthesizer, AVSpeechUtterance) -> Void) -> Self {
        ce._speechSynthesizer_didContinue = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_speechSynthesizer_didCancel(handle: @escaping (AVSpeechSynthesizer, AVSpeechUtterance) -> Void) -> Self {
        ce._speechSynthesizer_didCancel = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_speechSynthesizer_willSpeakRangeOfSpeechString(handle: @escaping (AVSpeechSynthesizer, NSRange, AVSpeechUtterance) -> Void) -> Self {
        ce._speechSynthesizer_willSpeakRangeOfSpeechString = handle
        rebindingDelegate()
        return self
    }
    
}

internal class AVSpeechSynthesizer_Delegate: NSObject, AVSpeechSynthesizerDelegate {
    
    var _speechSynthesizer_didStart: ((AVSpeechSynthesizer, AVSpeechUtterance) -> Void)?
    var _speechSynthesizer_didFinish: ((AVSpeechSynthesizer, AVSpeechUtterance) -> Void)?
    var _speechSynthesizer_didPause: ((AVSpeechSynthesizer, AVSpeechUtterance) -> Void)?
    var _speechSynthesizer_didContinue: ((AVSpeechSynthesizer, AVSpeechUtterance) -> Void)?
    var _speechSynthesizer_didCancel: ((AVSpeechSynthesizer, AVSpeechUtterance) -> Void)?
    var _speechSynthesizer_willSpeakRangeOfSpeechString: ((AVSpeechSynthesizer, NSRange, AVSpeechUtterance) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(speechSynthesizer(_:didStart:)) : _speechSynthesizer_didStart,
            #selector(speechSynthesizer(_:didFinish:)) : _speechSynthesizer_didFinish,
            #selector(speechSynthesizer(_:didPause:)) : _speechSynthesizer_didPause,
            #selector(speechSynthesizer(_:didContinue:)) : _speechSynthesizer_didContinue,
            #selector(speechSynthesizer(_:didCancel:)) : _speechSynthesizer_didCancel,
            #selector(speechSynthesizer(_:willSpeakRangeOfSpeechString:utterance:)) : _speechSynthesizer_willSpeakRangeOfSpeechString,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        _speechSynthesizer_didStart!(synthesizer, utterance)
    }
    @objc func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        _speechSynthesizer_didFinish!(synthesizer, utterance)
    }
    @objc func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        _speechSynthesizer_didPause!(synthesizer, utterance)
    }
    @objc func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        _speechSynthesizer_didContinue!(synthesizer, utterance)
    }
    @objc func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        _speechSynthesizer_didCancel!(synthesizer, utterance)
    }
    @objc func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        _speechSynthesizer_willSpeakRangeOfSpeechString!(synthesizer, characterRange, utterance)
    }
}
