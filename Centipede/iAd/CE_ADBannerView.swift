//
//  CE_ADBannerView.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import iAd

public extension ADBannerView {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: ADBannerView_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? ADBannerView_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: ADBannerView_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is ADBannerView_Delegate {
                return obj as! ADBannerView_Delegate
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
    
    internal func getDelegateInstance() -> ADBannerView_Delegate {
        return ADBannerView_Delegate()
    }
    
    public func ce_willLoadAd(handle: (banner: ADBannerView) -> Void) -> Self {
        ce._willLoadAd = handle
        rebindingDelegate()
        return self
    }
    public func ce_didLoadAd(handle: (banner: ADBannerView) -> Void) -> Self {
        ce._didLoadAd = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFailToReceiveAdWithError(handle: (banner: ADBannerView, error: NSError!) -> Void) -> Self {
        ce._didFailToReceiveAdWithError = handle
        rebindingDelegate()
        return self
    }
    public func ce_actionShouldBegin(handle: (banner: ADBannerView, willLeave: Bool) -> Bool) -> Self {
        ce._actionShouldBegin = handle
        rebindingDelegate()
        return self
    }
    public func ce_actionDidFinish(handle: (banner: ADBannerView) -> Void) -> Self {
        ce._actionDidFinish = handle
        rebindingDelegate()
        return self
    }
    
}

internal class ADBannerView_Delegate: NSObject, ADBannerViewDelegate {
    
    var _willLoadAd: ((ADBannerView) -> Void)?
    var _didLoadAd: ((ADBannerView) -> Void)?
    var _didFailToReceiveAdWithError: ((ADBannerView, NSError!) -> Void)?
    var _actionShouldBegin: ((ADBannerView, Bool) -> Bool)?
    var _actionDidFinish: ((ADBannerView) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "bannerViewWillLoadAd:" : _willLoadAd,
            "bannerViewDidLoadAd:" : _didLoadAd,
            "bannerView:didFailToReceiveAdWithError:" : _didFailToReceiveAdWithError,
            "bannerViewActionShouldBegin:willLeaveApplication:" : _actionShouldBegin,
            "bannerViewActionDidFinish:" : _actionDidFinish,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func bannerViewWillLoadAd(banner: ADBannerView) {
        _willLoadAd!(banner)
    }
    @objc func bannerViewDidLoadAd(banner: ADBannerView) {
        _didLoadAd!(banner)
    }
    @objc func bannerView(banner: ADBannerView, didFailToReceiveAdWithError error: NSError!) {
        _didFailToReceiveAdWithError!(banner, error)
    }
    @objc func bannerViewActionShouldBegin(banner: ADBannerView, willLeaveApplication willLeave: Bool) -> Bool {
        return _actionShouldBegin!(banner, willLeave)
    }
    @objc func bannerViewActionDidFinish(banner: ADBannerView) {
        _actionDidFinish!(banner)
    }
}
