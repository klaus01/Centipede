//
//  CE_ADInterstitialAd.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import iAd

public extension ADInterstitialAd {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: ADInterstitialAd_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? ADInterstitialAd_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: ADInterstitialAd_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is ADInterstitialAd_Delegate {
                return obj as! ADInterstitialAd_Delegate
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
    
    internal func getDelegateInstance() -> ADInterstitialAd_Delegate {
        return ADInterstitialAd_Delegate()
    }
    
    public func ce_didUnload(handle: (interstitialAd: ADInterstitialAd) -> Void) -> Self {
        ce._didUnload = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFailWithError(handle: (interstitialAd: ADInterstitialAd, error: NSError!) -> Void) -> Self {
        ce._didFailWithError = handle
        rebindingDelegate()
        return self
    }
    public func ce_willLoad(handle: (interstitialAd: ADInterstitialAd) -> Void) -> Self {
        ce._willLoad = handle
        rebindingDelegate()
        return self
    }
    public func ce_didLoad(handle: (interstitialAd: ADInterstitialAd) -> Void) -> Self {
        ce._didLoad = handle
        rebindingDelegate()
        return self
    }
    public func ce_actionShouldBegin(handle: (interstitialAd: ADInterstitialAd, willLeave: Bool) -> Bool) -> Self {
        ce._actionShouldBegin = handle
        rebindingDelegate()
        return self
    }
    public func ce_actionDidFinish(handle: (interstitialAd: ADInterstitialAd) -> Void) -> Self {
        ce._actionDidFinish = handle
        rebindingDelegate()
        return self
    }
    
}

internal class ADInterstitialAd_Delegate: NSObject, ADInterstitialAdDelegate {
    
    var _didUnload: ((ADInterstitialAd) -> Void)?
    var _didFailWithError: ((ADInterstitialAd, NSError!) -> Void)?
    var _willLoad: ((ADInterstitialAd) -> Void)?
    var _didLoad: ((ADInterstitialAd) -> Void)?
    var _actionShouldBegin: ((ADInterstitialAd, Bool) -> Bool)?
    var _actionDidFinish: ((ADInterstitialAd) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "interstitialAdDidUnload:" : _didUnload,
            "interstitialAd:didFailWithError:" : _didFailWithError,
            "interstitialAdWillLoad:" : _willLoad,
            "interstitialAdDidLoad:" : _didLoad,
            "interstitialAdActionShouldBegin:willLeaveApplication:" : _actionShouldBegin,
            "interstitialAdActionDidFinish:" : _actionDidFinish,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func interstitialAdDidUnload(interstitialAd: ADInterstitialAd) {
        _didUnload!(interstitialAd)
    }
    @objc func interstitialAd(interstitialAd: ADInterstitialAd, didFailWithError error: NSError!) {
        _didFailWithError!(interstitialAd, error)
    }
    @objc func interstitialAdWillLoad(interstitialAd: ADInterstitialAd) {
        _willLoad!(interstitialAd)
    }
    @objc func interstitialAdDidLoad(interstitialAd: ADInterstitialAd) {
        _didLoad!(interstitialAd)
    }
    @objc func interstitialAdActionShouldBegin(interstitialAd: ADInterstitialAd, willLeaveApplication willLeave: Bool) -> Bool {
        return _actionShouldBegin!(interstitialAd, willLeave)
    }
    @objc func interstitialAdActionDidFinish(interstitialAd: ADInterstitialAd) {
        _actionDidFinish!(interstitialAd)
    }
}
