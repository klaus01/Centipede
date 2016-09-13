//
//  CE_ADBannerView.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
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
    
    public func ce_bannerViewWillLoadAd(handle: ((ADBannerView) -> Void)) -> Self {
        ce._bannerViewWillLoadAd = handle
        rebindingDelegate()
        return self
    }
    public func ce_bannerViewDidLoadAd(handle: ((ADBannerView) -> Void)) -> Self {
        ce._bannerViewDidLoadAd = handle
        rebindingDelegate()
        return self
    }
    public func ce_bannerView_didFailToReceiveAdWithError(handle: ((ADBannerView, Error) -> Void)) -> Self {
        ce._bannerView_didFailToReceiveAdWithError = handle
        rebindingDelegate()
        return self
    }
    public func ce_bannerViewActionShouldBegin_willLeaveApplication(handle: ((ADBannerView, Bool) -> Bool)) -> Self {
        ce._bannerViewActionShouldBegin_willLeaveApplication = handle
        rebindingDelegate()
        return self
    }
    public func ce_bannerViewActionDidFinish(handle: ((ADBannerView) -> Void)) -> Self {
        ce._bannerViewActionDidFinish = handle
        rebindingDelegate()
        return self
    }
    
}

internal class ADBannerView_Delegate: NSObject, ADBannerViewDelegate {
    
    var _bannerViewWillLoadAd: ((ADBannerView) -> Void)?
    var _bannerViewDidLoadAd: ((ADBannerView) -> Void)?
    var _bannerView_didFailToReceiveAdWithError: ((ADBannerView, Error) -> Void)?
    var _bannerViewActionShouldBegin_willLeaveApplication: ((ADBannerView, Bool) -> Bool)?
    var _bannerViewActionDidFinish: ((ADBannerView) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(bannerViewWillLoadAd(_:)) : _bannerViewWillLoadAd,
            #selector(bannerViewDidLoadAd(_:)) : _bannerViewDidLoadAd,
            #selector(bannerView(_:didFailToReceiveAdWithError:)) : _bannerView_didFailToReceiveAdWithError,
            #selector(bannerViewActionShouldBegin(_:willLeaveApplication:)) : _bannerViewActionShouldBegin_willLeaveApplication,
            #selector(bannerViewActionDidFinish(_:)) : _bannerViewActionDidFinish,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func bannerViewWillLoadAd(_ banner: ADBannerView) {
        _bannerViewWillLoadAd!(banner)
    }
    @objc func bannerViewDidLoadAd(_ banner: ADBannerView) {
        _bannerViewDidLoadAd!(banner)
    }
    @objc func bannerView(_ banner: ADBannerView, didFailToReceiveAdWithError error: Error) {
        _bannerView_didFailToReceiveAdWithError!(banner, error)
    }
    @objc func bannerViewActionShouldBegin(_ banner: ADBannerView, willLeaveApplication willLeave: Bool) -> Bool {
        return _bannerViewActionShouldBegin_willLeaveApplication!(banner, willLeave)
    }
    @objc func bannerViewActionDidFinish(_ banner: ADBannerView) {
        _bannerViewActionDidFinish!(banner)
    }
}
