//
//  CE_UIScrollView.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
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
        if let obj: AnyObject = self.delegate {
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
    
    public func ce_scrollViewDidScroll(handle: ((UIScrollView) -> Void)) -> Self {
        ce._scrollViewDidScroll = handle
        rebindingDelegate()
        return self
    }
    public func ce_scrollViewDidZoom(handle: ((UIScrollView) -> Void)) -> Self {
        ce._scrollViewDidZoom = handle
        rebindingDelegate()
        return self
    }
    public func ce_scrollViewWillBeginDragging(handle: ((UIScrollView) -> Void)) -> Self {
        ce._scrollViewWillBeginDragging = handle
        rebindingDelegate()
        return self
    }
    public func ce_scrollViewWillEndDragging(handle: ((UIScrollView, CGPoint, UnsafeMutablePointer<CGPoint>) -> Void)) -> Self {
        ce._scrollViewWillEndDragging = handle
        rebindingDelegate()
        return self
    }
    public func ce_scrollViewDidEndDragging(handle: ((UIScrollView, Bool) -> Void)) -> Self {
        ce._scrollViewDidEndDragging = handle
        rebindingDelegate()
        return self
    }
    public func ce_scrollViewWillBeginDecelerating(handle: ((UIScrollView) -> Void)) -> Self {
        ce._scrollViewWillBeginDecelerating = handle
        rebindingDelegate()
        return self
    }
    public func ce_scrollViewDidEndDecelerating(handle: ((UIScrollView) -> Void)) -> Self {
        ce._scrollViewDidEndDecelerating = handle
        rebindingDelegate()
        return self
    }
    public func ce_scrollViewDidEndScrollingAnimation(handle: ((UIScrollView) -> Void)) -> Self {
        ce._scrollViewDidEndScrollingAnimation = handle
        rebindingDelegate()
        return self
    }
    public func ce_viewForZooming(handle: ((UIScrollView) -> UIView?)) -> Self {
        ce._viewForZooming = handle
        rebindingDelegate()
        return self
    }
    public func ce_scrollViewWillBeginZooming(handle: ((UIScrollView, UIView?) -> Void)) -> Self {
        ce._scrollViewWillBeginZooming = handle
        rebindingDelegate()
        return self
    }
    public func ce_scrollViewDidEndZooming(handle: ((UIScrollView, UIView?, CGFloat) -> Void)) -> Self {
        ce._scrollViewDidEndZooming = handle
        rebindingDelegate()
        return self
    }
    public func ce_scrollViewShouldScrollToTop(handle: ((UIScrollView) -> Bool)) -> Self {
        ce._scrollViewShouldScrollToTop = handle
        rebindingDelegate()
        return self
    }
    public func ce_scrollViewDidScrollToTop(handle: ((UIScrollView) -> Void)) -> Self {
        ce._scrollViewDidScrollToTop = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIScrollView_Delegate: NSObject, UIScrollViewDelegate {
    
    var _scrollViewDidScroll: ((UIScrollView) -> Void)?
    var _scrollViewDidZoom: ((UIScrollView) -> Void)?
    var _scrollViewWillBeginDragging: ((UIScrollView) -> Void)?
    var _scrollViewWillEndDragging: ((UIScrollView, CGPoint, UnsafeMutablePointer<CGPoint>) -> Void)?
    var _scrollViewDidEndDragging: ((UIScrollView, Bool) -> Void)?
    var _scrollViewWillBeginDecelerating: ((UIScrollView) -> Void)?
    var _scrollViewDidEndDecelerating: ((UIScrollView) -> Void)?
    var _scrollViewDidEndScrollingAnimation: ((UIScrollView) -> Void)?
    var _viewForZooming: ((UIScrollView) -> UIView?)?
    var _scrollViewWillBeginZooming: ((UIScrollView, UIView?) -> Void)?
    var _scrollViewDidEndZooming: ((UIScrollView, UIView?, CGFloat) -> Void)?
    var _scrollViewShouldScrollToTop: ((UIScrollView) -> Bool)?
    var _scrollViewDidScrollToTop: ((UIScrollView) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(scrollViewDidScroll(_:)) : _scrollViewDidScroll,
            #selector(scrollViewDidZoom(_:)) : _scrollViewDidZoom,
            #selector(scrollViewWillBeginDragging(_:)) : _scrollViewWillBeginDragging,
            #selector(scrollViewWillEndDragging(_:withVelocity:targetContentOffset:)) : _scrollViewWillEndDragging,
            #selector(scrollViewDidEndDragging(_:willDecelerate:)) : _scrollViewDidEndDragging,
            #selector(scrollViewWillBeginDecelerating(_:)) : _scrollViewWillBeginDecelerating,
            #selector(scrollViewDidEndDecelerating(_:)) : _scrollViewDidEndDecelerating,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(scrollViewDidEndScrollingAnimation(_:)) : _scrollViewDidEndScrollingAnimation,
            #selector(viewForZooming(in:)) : _viewForZooming,
            #selector(scrollViewWillBeginZooming(_:with:)) : _scrollViewWillBeginZooming,
            #selector(scrollViewDidEndZooming(_:with:atScale:)) : _scrollViewDidEndZooming,
            #selector(scrollViewShouldScrollToTop(_:)) : _scrollViewShouldScrollToTop,
            #selector(scrollViewDidScrollToTop(_:)) : _scrollViewDidScrollToTop,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
        _scrollViewDidScroll!(scrollView)
    }
    @objc func scrollViewDidZoom(_ scrollView: UIScrollView) {
        _scrollViewDidZoom!(scrollView)
    }
    @objc func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        _scrollViewWillBeginDragging!(scrollView)
    }
    @objc func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        _scrollViewWillEndDragging!(scrollView, velocity, targetContentOffset)
    }
    @objc func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        _scrollViewDidEndDragging!(scrollView, decelerate)
    }
    @objc func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        _scrollViewWillBeginDecelerating!(scrollView)
    }
    @objc func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        _scrollViewDidEndDecelerating!(scrollView)
    }
    @objc func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        _scrollViewDidEndScrollingAnimation!(scrollView)
    }
    @objc func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return _viewForZooming!(scrollView)
    }
    @objc func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        _scrollViewWillBeginZooming!(scrollView, view)
    }
    @objc func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        _scrollViewDidEndZooming!(scrollView, view, scale)
    }
    @objc func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return _scrollViewShouldScrollToTop!(scrollView)
    }
    @objc func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        _scrollViewDidScrollToTop!(scrollView)
    }
}
