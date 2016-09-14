//
//  CE_ADInterstitialAd.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import iAd

public extension ADInterstitialAd {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: ADInterstitialAd_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? ADInterstitialAd_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
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
    
    @discardableResult
    public func ce_interstitialAdDidUnload(handle: @escaping (ADInterstitialAd) -> Void) -> Self {
        ce._interstitialAdDidUnload = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_interstitialAd_didFailWithError(handle: @escaping (ADInterstitialAd, Error) -> Void) -> Self {
        ce._interstitialAd_didFailWithError = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_interstitialAdWillLoad(handle: @escaping (ADInterstitialAd) -> Void) -> Self {
        ce._interstitialAdWillLoad = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_interstitialAdDidLoad(handle: @escaping (ADInterstitialAd) -> Void) -> Self {
        ce._interstitialAdDidLoad = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_interstitialAdActionShouldBegin_willLeaveApplication(handle: @escaping (ADInterstitialAd, Bool) -> Bool) -> Self {
        ce._interstitialAdActionShouldBegin_willLeaveApplication = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_interstitialAdActionDidFinish(handle: @escaping (ADInterstitialAd) -> Void) -> Self {
        ce._interstitialAdActionDidFinish = handle
        rebindingDelegate()
        return self
    }
    
}

internal class ADInterstitialAd_Delegate: NSObject, ADInterstitialAdDelegate {
    
    var _interstitialAdDidUnload: ((ADInterstitialAd) -> Void)?
    var _interstitialAd_didFailWithError: ((ADInterstitialAd, Error) -> Void)?
    var _interstitialAdWillLoad: ((ADInterstitialAd) -> Void)?
    var _interstitialAdDidLoad: ((ADInterstitialAd) -> Void)?
    var _interstitialAdActionShouldBegin_willLeaveApplication: ((ADInterstitialAd, Bool) -> Bool)?
    var _interstitialAdActionDidFinish: ((ADInterstitialAd) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(interstitialAdDidUnload(_:)) : _interstitialAdDidUnload,
            #selector(interstitialAd(_:didFailWithError:)) : _interstitialAd_didFailWithError,
            #selector(interstitialAdWillLoad(_:)) : _interstitialAdWillLoad,
            #selector(interstitialAdDidLoad(_:)) : _interstitialAdDidLoad,
            #selector(interstitialAdActionShouldBegin(_:willLeaveApplication:)) : _interstitialAdActionShouldBegin_willLeaveApplication,
            #selector(interstitialAdActionDidFinish(_:)) : _interstitialAdActionDidFinish,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func interstitialAdDidUnload(_ interstitialAd: ADInterstitialAd) {
        _interstitialAdDidUnload!(interstitialAd)
    }
    @objc func interstitialAd(_ interstitialAd: ADInterstitialAd, didFailWithError error: Error) {
        _interstitialAd_didFailWithError!(interstitialAd, error)
    }
    @objc func interstitialAdWillLoad(_ interstitialAd: ADInterstitialAd) {
        _interstitialAdWillLoad!(interstitialAd)
    }
    @objc func interstitialAdDidLoad(_ interstitialAd: ADInterstitialAd) {
        _interstitialAdDidLoad!(interstitialAd)
    }
    @objc func interstitialAdActionShouldBegin(_ interstitialAd: ADInterstitialAd, willLeaveApplication willLeave: Bool) -> Bool {
        return _interstitialAdActionShouldBegin_willLeaveApplication!(interstitialAd, willLeave)
    }
    @objc func interstitialAdActionDidFinish(_ interstitialAd: ADInterstitialAd) {
        _interstitialAdActionDidFinish!(interstitialAd)
    }
}
