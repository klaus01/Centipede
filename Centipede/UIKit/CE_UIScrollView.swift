//
//  CE_UIScrollView.swift
//  Centipede
//
//  Created by kelei on 15/4/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import Foundation
import UIKit


extension UIScrollView {
    
    private var ce: UIScrollView_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIScrollView_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UIScrollView_Delegate {
                return delegate as! UIScrollView_Delegate
            }
        }
        let delegate = getDelegateInstance()
        objc_setAssociatedObject(self, &Static.AssociationKey, delegate, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        return delegate
    }
    
    private func rebindingDelegate() {
        let delegate = ce
        self.delegate = nil
        self.delegate = delegate
    }
    
    internal func getDelegateInstance() -> UIScrollView_Delegate {
        return UIScrollView_Delegate()
    }
    
    public func ce_DidScroll(handle: (scrollView: UIScrollView) -> Void) -> Self {
        ce.DidScroll = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidZoom(handle: (scrollView: UIScrollView) -> Void) -> Self {
        ce.DidZoom = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillBeginDragging(handle: (scrollView: UIScrollView) -> Void) -> Self {
        ce.WillBeginDragging = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillEndDragging(handle: (scrollView: UIScrollView, velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) -> Void) -> Self {
        ce.WillEndDragging = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndDragging(handle: (scrollView: UIScrollView, decelerate: Bool) -> Void) -> Self {
        ce.DidEndDragging = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillBeginDecelerating(handle: (scrollView: UIScrollView) -> Void) -> Self {
        ce.WillBeginDecelerating = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndDecelerating(handle: (scrollView: UIScrollView) -> Void) -> Self {
        ce.DidEndDecelerating = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndScrollingAnimation(handle: (scrollView: UIScrollView) -> Void) -> Self {
        ce.DidEndScrollingAnimation = handle
        rebindingDelegate()
        return self
    }
    public func ce_ViewForZoomingIn(handle: (scrollView: UIScrollView) -> UIView?) -> Self {
        ce.ViewForZoomingIn = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillBeginZooming(handle: (scrollView: UIScrollView, view: UIView!) -> Void) -> Self {
        ce.WillBeginZooming = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndZooming(handle: (scrollView: UIScrollView, view: UIView!, scale: CGFloat) -> Void) -> Self {
        ce.DidEndZooming = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldScrollToTop(handle: (scrollView: UIScrollView) -> Bool) -> Self {
        ce.ShouldScrollToTop = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidScrollToTop(handle: (scrollView: UIScrollView) -> Void) -> Self {
        ce.DidScrollToTop = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIScrollView_Delegate: NSObject, UIScrollViewDelegate {
    
    var DidScroll: ((UIScrollView) -> Void)?
    var DidZoom: ((UIScrollView) -> Void)?
    var WillBeginDragging: ((UIScrollView) -> Void)?
    var WillEndDragging: ((UIScrollView, CGPoint, UnsafeMutablePointer<CGPoint>) -> Void)?
    var DidEndDragging: ((UIScrollView, Bool) -> Void)?
    var WillBeginDecelerating: ((UIScrollView) -> Void)?
    var DidEndDecelerating: ((UIScrollView) -> Void)?
    var DidEndScrollingAnimation: ((UIScrollView) -> Void)?
    var ViewForZoomingIn: ((UIScrollView) -> UIView?)?
    var WillBeginZooming: ((UIScrollView, UIView!) -> Void)?
    var DidEndZooming: ((UIScrollView, UIView!, CGFloat) -> Void)?
    var ShouldScrollToTop: ((UIScrollView) -> Bool)?
    var DidScrollToTop: ((UIScrollView) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "scrollViewDidScroll:" : DidScroll,
            "scrollViewDidZoom:" : DidZoom,
            "scrollViewWillBeginDragging:" : WillBeginDragging,
            "scrollViewWillEndDragging:withVelocity:targetContentOffset:" : WillEndDragging,
            "scrollViewDidEndDragging:willDecelerate:" : DidEndDragging,
            "scrollViewWillBeginDecelerating:" : WillBeginDecelerating,
            "scrollViewDidEndDecelerating:" : DidEndDecelerating,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "scrollViewDidEndScrollingAnimation:" : DidEndScrollingAnimation,
            "viewForZoomingInScrollView:" : ViewForZoomingIn,
            "scrollViewWillBeginZooming:withView:" : WillBeginZooming,
            "scrollViewDidEndZooming:withView:atScale:" : DidEndZooming,
            "scrollViewShouldScrollToTop:" : ShouldScrollToTop,
            "scrollViewDidScrollToTop:" : DidScrollToTop,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func scrollViewDidScroll(scrollView: UIScrollView) {
        DidScroll!(scrollView)
    }
    @objc func scrollViewDidZoom(scrollView: UIScrollView) {
        DidZoom!(scrollView)
    }
    @objc func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        WillBeginDragging!(scrollView)
    }
    @objc func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        WillEndDragging!(scrollView, velocity, targetContentOffset)
    }
    @objc func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        DidEndDragging!(scrollView, decelerate)
    }
    @objc func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        WillBeginDecelerating!(scrollView)
    }
    @objc func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        DidEndDecelerating!(scrollView)
    }
    @objc func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        DidEndScrollingAnimation!(scrollView)
    }
    @objc func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return ViewForZoomingIn!(scrollView)
    }
    @objc func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView!) {
        WillBeginZooming!(scrollView, view)
    }
    @objc func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
        DidEndZooming!(scrollView, view, scale)
    }
    @objc func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        return ShouldScrollToTop!(scrollView)
    }
    @objc func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        DidScrollToTop!(scrollView)
    }
}