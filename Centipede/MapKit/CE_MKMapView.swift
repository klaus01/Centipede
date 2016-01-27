//
//  CE_MKMapView.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import MapKit

public extension MKMapView {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: MKMapView_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? MKMapView_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: MKMapView_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is MKMapView_Delegate {
                return obj as! MKMapView_Delegate
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
    
    internal func getDelegateInstance() -> MKMapView_Delegate {
        return MKMapView_Delegate()
    }
    
    public func ce_regionWillChangeAnimated(handle: (mapView: MKMapView, animated: Bool) -> Void) -> Self {
        ce._regionWillChangeAnimated = handle
        rebindingDelegate()
        return self
    }
    public func ce_regionDidChangeAnimated(handle: (mapView: MKMapView, animated: Bool) -> Void) -> Self {
        ce._regionDidChangeAnimated = handle
        rebindingDelegate()
        return self
    }
    public func ce_willStartLoadingMap(handle: (mapView: MKMapView) -> Void) -> Self {
        ce._willStartLoadingMap = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFinishLoadingMap(handle: (mapView: MKMapView) -> Void) -> Self {
        ce._didFinishLoadingMap = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFailLoadingMap(handle: (mapView: MKMapView, error: NSError) -> Void) -> Self {
        ce._didFailLoadingMap = handle
        rebindingDelegate()
        return self
    }
    public func ce_willStartRenderingMap(handle: (mapView: MKMapView) -> Void) -> Self {
        ce._willStartRenderingMap = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFinishRenderingMap(handle: (mapView: MKMapView, fullyRendered: Bool) -> Void) -> Self {
        ce._didFinishRenderingMap = handle
        rebindingDelegate()
        return self
    }
    public func ce_viewForAnnotation(handle: (mapView: MKMapView, annotation: MKAnnotation) -> MKAnnotationView?) -> Self {
        ce._viewForAnnotation = handle
        rebindingDelegate()
        return self
    }
    public func ce_didAddAnnotationViews(handle: (mapView: MKMapView, views: [MKAnnotationView]) -> Void) -> Self {
        ce._didAddAnnotationViews = handle
        rebindingDelegate()
        return self
    }
    public func ce_annotationView(handle: (mapView: MKMapView, view: MKAnnotationView, control: UIControl) -> Void) -> Self {
        ce._annotationView = handle
        rebindingDelegate()
        return self
    }
    public func ce_didSelectAnnotationView(handle: (mapView: MKMapView, view: MKAnnotationView) -> Void) -> Self {
        ce._didSelectAnnotationView = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDeselectAnnotationView(handle: (mapView: MKMapView, view: MKAnnotationView) -> Void) -> Self {
        ce._didDeselectAnnotationView = handle
        rebindingDelegate()
        return self
    }
    public func ce_willStartLocatingUser(handle: (mapView: MKMapView) -> Void) -> Self {
        ce._willStartLocatingUser = handle
        rebindingDelegate()
        return self
    }
    public func ce_didStopLocatingUser(handle: (mapView: MKMapView) -> Void) -> Self {
        ce._didStopLocatingUser = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateUserLocation(handle: (mapView: MKMapView, userLocation: MKUserLocation) -> Void) -> Self {
        ce._didUpdateUserLocation = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFailToLocateUserWithError(handle: (mapView: MKMapView, error: NSError) -> Void) -> Self {
        ce._didFailToLocateUserWithError = handle
        rebindingDelegate()
        return self
    }
    public func ce_annotationViewAndAnnotationView(handle: (mapView: MKMapView, view: MKAnnotationView, newState: MKAnnotationViewDragState, oldState: MKAnnotationViewDragState) -> Void) -> Self {
        ce._annotationViewAndAnnotationView = handle
        rebindingDelegate()
        return self
    }
    public func ce_didChangeUserTrackingMode(handle: (mapView: MKMapView, mode: MKUserTrackingMode, animated: Bool) -> Void) -> Self {
        ce._didChangeUserTrackingMode = handle
        rebindingDelegate()
        return self
    }
    public func ce_rendererForOverlay(handle: (mapView: MKMapView, overlay: MKOverlay) -> MKOverlayRenderer) -> Self {
        ce._rendererForOverlay = handle
        rebindingDelegate()
        return self
    }
    public func ce_didAddOverlayRenderers(handle: (mapView: MKMapView, renderers: [MKOverlayRenderer]) -> Void) -> Self {
        ce._didAddOverlayRenderers = handle
        rebindingDelegate()
        return self
    }
    
}

internal class MKMapView_Delegate: NSObject, MKMapViewDelegate {
    
    var _regionWillChangeAnimated: ((MKMapView, Bool) -> Void)?
    var _regionDidChangeAnimated: ((MKMapView, Bool) -> Void)?
    var _willStartLoadingMap: ((MKMapView) -> Void)?
    var _didFinishLoadingMap: ((MKMapView) -> Void)?
    var _didFailLoadingMap: ((MKMapView, NSError) -> Void)?
    var _willStartRenderingMap: ((MKMapView) -> Void)?
    var _didFinishRenderingMap: ((MKMapView, Bool) -> Void)?
    var _viewForAnnotation: ((MKMapView, MKAnnotation) -> MKAnnotationView?)?
    var _didAddAnnotationViews: ((MKMapView, [MKAnnotationView]) -> Void)?
    var _annotationView: ((MKMapView, MKAnnotationView, UIControl) -> Void)?
    var _didSelectAnnotationView: ((MKMapView, MKAnnotationView) -> Void)?
    var _didDeselectAnnotationView: ((MKMapView, MKAnnotationView) -> Void)?
    var _willStartLocatingUser: ((MKMapView) -> Void)?
    var _didStopLocatingUser: ((MKMapView) -> Void)?
    var _didUpdateUserLocation: ((MKMapView, MKUserLocation) -> Void)?
    var _didFailToLocateUserWithError: ((MKMapView, NSError) -> Void)?
    var _annotationViewAndAnnotationView: ((MKMapView, MKAnnotationView, MKAnnotationViewDragState, MKAnnotationViewDragState) -> Void)?
    var _didChangeUserTrackingMode: ((MKMapView, MKUserTrackingMode, Bool) -> Void)?
    var _rendererForOverlay: ((MKMapView, MKOverlay) -> MKOverlayRenderer)?
    var _didAddOverlayRenderers: ((MKMapView, [MKOverlayRenderer]) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "mapView:regionWillChangeAnimated:" : _regionWillChangeAnimated,
            "mapView:regionDidChangeAnimated:" : _regionDidChangeAnimated,
            "mapViewWillStartLoadingMap:" : _willStartLoadingMap,
            "mapViewDidFinishLoadingMap:" : _didFinishLoadingMap,
            "mapViewDidFailLoadingMap:withError:" : _didFailLoadingMap,
            "mapViewWillStartRenderingMap:" : _willStartRenderingMap,
            "mapViewDidFinishRenderingMap:fullyRendered:" : _didFinishRenderingMap,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "mapView:viewForAnnotation:" : _viewForAnnotation,
            "mapView:didAddAnnotationViews:" : _didAddAnnotationViews,
            "mapView:annotationView:calloutAccessoryControlTapped:" : _annotationView,
            "mapView:didSelectAnnotationView:" : _didSelectAnnotationView,
            "mapView:didDeselectAnnotationView:" : _didDeselectAnnotationView,
            "mapViewWillStartLocatingUser:" : _willStartLocatingUser,
            "mapViewDidStopLocatingUser:" : _didStopLocatingUser,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        let funcDic3: [Selector : Any?] = [
            "mapView:didUpdateUserLocation:" : _didUpdateUserLocation,
            "mapView:didFailToLocateUserWithError:" : _didFailToLocateUserWithError,
            "mapView:annotationView:didChangeDragState:fromOldState:" : _annotationViewAndAnnotationView,
            "mapView:didChangeUserTrackingMode:animated:" : _didChangeUserTrackingMode,
            "mapView:rendererForOverlay:" : _rendererForOverlay,
            "mapView:didAddOverlayRenderers:" : _didAddOverlayRenderers,
        ]
        if let f = funcDic3[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        _regionWillChangeAnimated!(mapView, animated)
    }
    @objc func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        _regionDidChangeAnimated!(mapView, animated)
    }
    @objc func mapViewWillStartLoadingMap(mapView: MKMapView) {
        _willStartLoadingMap!(mapView)
    }
    @objc func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        _didFinishLoadingMap!(mapView)
    }
    @objc func mapViewDidFailLoadingMap(mapView: MKMapView, withError error: NSError) {
        _didFailLoadingMap!(mapView, error)
    }
    @objc func mapViewWillStartRenderingMap(mapView: MKMapView) {
        _willStartRenderingMap!(mapView)
    }
    @objc func mapViewDidFinishRenderingMap(mapView: MKMapView, fullyRendered: Bool) {
        _didFinishRenderingMap!(mapView, fullyRendered)
    }
    @objc func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        return _viewForAnnotation!(mapView, annotation)
    }
    @objc func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        _didAddAnnotationViews!(mapView, views)
    }
    @objc func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        _annotationView!(mapView, view, control)
    }
    @objc func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        _didSelectAnnotationView!(mapView, view)
    }
    @objc func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        _didDeselectAnnotationView!(mapView, view)
    }
    @objc func mapViewWillStartLocatingUser(mapView: MKMapView) {
        _willStartLocatingUser!(mapView)
    }
    @objc func mapViewDidStopLocatingUser(mapView: MKMapView) {
        _didStopLocatingUser!(mapView)
    }
    @objc func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        _didUpdateUserLocation!(mapView, userLocation)
    }
    @objc func mapView(mapView: MKMapView, didFailToLocateUserWithError error: NSError) {
        _didFailToLocateUserWithError!(mapView, error)
    }
    @objc func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        _annotationViewAndAnnotationView!(mapView, view, newState, oldState)
    }
    @objc func mapView(mapView: MKMapView, didChangeUserTrackingMode mode: MKUserTrackingMode, animated: Bool) {
        _didChangeUserTrackingMode!(mapView, mode, animated)
    }
    @objc func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        return _rendererForOverlay!(mapView, overlay)
    }
    @objc func mapView(mapView: MKMapView, didAddOverlayRenderers renderers: [MKOverlayRenderer]) {
        _didAddOverlayRenderers!(mapView, renderers)
    }
}
