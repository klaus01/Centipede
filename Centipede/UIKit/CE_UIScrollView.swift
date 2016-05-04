//
//  CE_UIScrollView.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UIScrollView {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIScrollView_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIScrollView_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIScrollView_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is UIScrollView_Delegate {
                return obj as! UIScrollView_Delegate
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
    
    internal func getDelegateInstance() -> UIScrollView_Delegate {
        return UIScrollView_Delegate()
    }
    
    public func ce_didScroll(handle: (scrollView: UIScrollView) -> Void) -> Self {
        ce._didScroll = handle
        rebindingDelegate()
        return self
    }
    public func ce_didZoom(handle: (scrollView: UIScrollView) -> Void) -> Self {
        ce._didZoom = handle
        rebindingDelegate()
        return self
    }
    public func ce_willBeginDragging(handle: (scrollView: UIScrollView) -> Void) -> Self {
        ce._willBeginDragging = handle
        rebindingDelegate()
        return self
    }
    public func ce_willEndDragging(handle: (scrollView: UIScrollView, velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) -> Void) -> Self {
        ce._willEndDragging = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndDragging(handle: (scrollView: UIScrollView, decelerate: Bool) -> Void) -> Self {
        ce._didEndDragging = handle
        rebindingDelegate()
        return self
    }
    public func ce_willBeginDecelerating(handle: (scrollView: UIScrollView) -> Void) -> Self {
        ce._willBeginDecelerating = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndDecelerating(handle: (scrollView: UIScrollView) -> Void) -> Self {
        ce._didEndDecelerating = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndScrollingAnimation(handle: (scrollView: UIScrollView) -> Void) -> Self {
        ce._didEndScrollingAnimation = handle
        rebindingDelegate()
        return self
    }
    public func ce_viewForZoomingIn(handle: (scrollView: UIScrollView) -> UIView?) -> Self {
        ce._viewForZoomingIn = handle
        rebindingDelegate()
        return self
    }
    public func ce_willBeginZooming(handle: (scrollView: UIScrollView, view: UIView?) -> Void) -> Self {
        ce._willBeginZooming = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndZooming(handle: (scrollView: UIScrollView, view: UIView?, scale: CGFloat) -> Void) -> Self {
        ce._didEndZooming = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldScrollToTop(handle: (scrollView: UIScrollView) -> Bool) -> Self {
        ce._shouldScrollToTop = handle
        rebindingDelegate()
        return self
    }
    public func ce_didScrollToTop(handle: (scrollView: UIScrollView) -> Void) -> Self {
        ce._didScrollToTop = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIScrollView_Delegate: NSObject, UIScrollViewDelegate {
    
    var _didScroll: ((UIScrollView) -> Void)?
    var _didZoom: ((UIScrollView) -> Void)?
    var _willBeginDragging: ((UIScrollView) -> Void)?
    var _willEndDragging: ((UIScrollView, CGPoint, UnsafeMutablePointer<CGPoint>) -> Void)?
    var _didEndDragging: ((UIScrollView, Bool) -> Void)?
    var _willBeginDecelerating: ((UIScrollView) -> Void)?
    var _didEndDecelerating: ((UIScrollView) -> Void)?
    var _didEndScrollingAnimation: ((UIScrollView) -> Void)?
    var _viewForZoomingIn: ((UIScrollView) -> UIView?)?
    var _willBeginZooming: ((UIScrollView, UIView?) -> Void)?
    var _didEndZooming: ((UIScrollView, UIView?, CGFloat) -> Void)?
    var _shouldScrollToTop: ((UIScrollView) -> Bool)?
    var _didScrollToTop: ((UIScrollView) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(scrollViewDidScroll(_:)) : _didScroll,
            #selector(scrollViewDidZoom(_:)) : _didZoom,
            #selector(scrollViewWillBeginDragging(_:)) : _willBeginDragging,
            #selector(scrollViewWillEndDragging(_:withVelocity:targetContentOffset:)) : _willEndDragging,
            #selector(scrollViewDidEndDragging(_:willDecelerate:)) : _didEndDragging,
            #selector(scrollViewWillBeginDecelerating(_:)) : _willBeginDecelerating,
            #selector(scrollViewDidEndDecelerating(_:)) : _didEndDecelerating,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(scrollViewDidEndScrollingAnimation(_:)) : _didEndScrollingAnimation,
            #selector(viewForZoomingInScrollView(_:)) : _viewForZoomingIn,
            #selector(scrollViewWillBeginZooming(_:withView:)) : _willBeginZooming,
            #selector(scrollViewDidEndZooming(_:withView:atScale:)) : _didEndZooming,
            #selector(scrollViewShouldScrollToTop(_:)) : _shouldScrollToTop,
            #selector(scrollViewDidScrollToTop(_:)) : _didScrollToTop,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func scrollViewDidScroll(scrollView: UIScrollView) {
        _didScroll!(scrollView)
    }
    @objc func scrollViewDidZoom(scrollView: UIScrollView) {
        _didZoom!(scrollView)
    }
    @objc func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        _willBeginDragging!(scrollView)
    }
    @objc func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        _willEndDragging!(scrollView, velocity, targetContentOffset)
    }
    @objc func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        _didEndDragging!(scrollView, decelerate)
    }
    @objc func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        _willBeginDecelerating!(scrollView)
    }
    @objc func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        _didEndDecelerating!(scrollView)
    }
    @objc func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        _didEndScrollingAnimation!(scrollView)
    }
    @objc func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return _viewForZoomingIn!(scrollView)
    }
    @objc func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        _willBeginZooming!(scrollView, view)
    }
    @objc func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        _didEndZooming!(scrollView, view, scale)
    }
    @objc func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        return _shouldScrollToTop!(scrollView)
    }
    @objc func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        _didScrollToTop!(scrollView)
    }
}
