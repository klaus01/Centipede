//
//  CE_CLLocationManager.swift
//  Centipede
//
//  Created by kelei on 2016/9/14.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import CoreLocation

public extension CLLocationManager {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: CLLocationManager_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? CLLocationManager_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: CLLocationManager_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is CLLocationManager_Delegate {
                return obj as! CLLocationManager_Delegate
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
    
    internal func getDelegateInstance() -> CLLocationManager_Delegate {
        return CLLocationManager_Delegate()
    }
    
    public func ce_locationManager_didUpdateLocations(handle: @escaping (CLLocationManager, [CLLocation]) -> Void) -> Self {
        ce._locationManager_didUpdateLocations = handle
        rebindingDelegate()
        return self
    }
    public func ce_locationManager_didUpdateHeading(handle: @escaping (CLLocationManager, CLHeading) -> Void) -> Self {
        ce._locationManager_didUpdateHeading = handle
        rebindingDelegate()
        return self
    }
    public func ce_locationManagerShouldDisplayHeadingCalibration(handle: @escaping (CLLocationManager) -> Bool) -> Self {
        ce._locationManagerShouldDisplayHeadingCalibration = handle
        rebindingDelegate()
        return self
    }
    public func ce_locationManager_didDetermineState(handle: @escaping (CLLocationManager, CLRegionState, CLRegion) -> Void) -> Self {
        ce._locationManager_didDetermineState = handle
        rebindingDelegate()
        return self
    }
    public func ce_locationManager_didRangeBeacons(handle: @escaping (CLLocationManager, [CLBeacon], CLBeaconRegion) -> Void) -> Self {
        ce._locationManager_didRangeBeacons = handle
        rebindingDelegate()
        return self
    }
    public func ce_locationManager_rangingBeaconsDidFailFor(handle: @escaping (CLLocationManager, CLBeaconRegion, Error) -> Void) -> Self {
        ce._locationManager_rangingBeaconsDidFailFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_locationManager_didEnterRegion(handle: @escaping (CLLocationManager, CLRegion) -> Void) -> Self {
        ce._locationManager_didEnterRegion = handle
        rebindingDelegate()
        return self
    }
    public func ce_locationManager_didExitRegion(handle: @escaping (CLLocationManager, CLRegion) -> Void) -> Self {
        ce._locationManager_didExitRegion = handle
        rebindingDelegate()
        return self
    }
    public func ce_locationManager_didFailWithError(handle: @escaping (CLLocationManager, Error) -> Void) -> Self {
        ce._locationManager_didFailWithError = handle
        rebindingDelegate()
        return self
    }
    public func ce_locationManager_monitoringDidFailFor(handle: @escaping (CLLocationManager, CLRegion?, Error) -> Void) -> Self {
        ce._locationManager_monitoringDidFailFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_locationManager_didChangeAuthorization(handle: @escaping (CLLocationManager, CLAuthorizationStatus) -> Void) -> Self {
        ce._locationManager_didChangeAuthorization = handle
        rebindingDelegate()
        return self
    }
    public func ce_locationManager_didStartMonitoringFor(handle: @escaping (CLLocationManager, CLRegion) -> Void) -> Self {
        ce._locationManager_didStartMonitoringFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_locationManagerDidPauseLocationUpdates(handle: @escaping (CLLocationManager) -> Void) -> Self {
        ce._locationManagerDidPauseLocationUpdates = handle
        rebindingDelegate()
        return self
    }
    public func ce_locationManagerDidResumeLocationUpdates(handle: @escaping (CLLocationManager) -> Void) -> Self {
        ce._locationManagerDidResumeLocationUpdates = handle
        rebindingDelegate()
        return self
    }
    public func ce_locationManager_didFinishDeferredUpdatesWithError(handle: @escaping (CLLocationManager, Error?) -> Void) -> Self {
        ce._locationManager_didFinishDeferredUpdatesWithError = handle
        rebindingDelegate()
        return self
    }
    public func ce_locationManager_didVisit(handle: @escaping (CLLocationManager, CLVisit) -> Void) -> Self {
        ce._locationManager_didVisit = handle
        rebindingDelegate()
        return self
    }
    
}

internal class CLLocationManager_Delegate: NSObject, CLLocationManagerDelegate {
    
    var _locationManager_didUpdateLocations: ((CLLocationManager, [CLLocation]) -> Void)?
    var _locationManager_didUpdateHeading: ((CLLocationManager, CLHeading) -> Void)?
    var _locationManagerShouldDisplayHeadingCalibration: ((CLLocationManager) -> Bool)?
    var _locationManager_didDetermineState: ((CLLocationManager, CLRegionState, CLRegion) -> Void)?
    var _locationManager_didRangeBeacons: ((CLLocationManager, [CLBeacon], CLBeaconRegion) -> Void)?
    var _locationManager_rangingBeaconsDidFailFor: ((CLLocationManager, CLBeaconRegion, Error) -> Void)?
    var _locationManager_didEnterRegion: ((CLLocationManager, CLRegion) -> Void)?
    var _locationManager_didExitRegion: ((CLLocationManager, CLRegion) -> Void)?
    var _locationManager_didFailWithError: ((CLLocationManager, Error) -> Void)?
    var _locationManager_monitoringDidFailFor: ((CLLocationManager, CLRegion?, Error) -> Void)?
    var _locationManager_didChangeAuthorization: ((CLLocationManager, CLAuthorizationStatus) -> Void)?
    var _locationManager_didStartMonitoringFor: ((CLLocationManager, CLRegion) -> Void)?
    var _locationManagerDidPauseLocationUpdates: ((CLLocationManager) -> Void)?
    var _locationManagerDidResumeLocationUpdates: ((CLLocationManager) -> Void)?
    var _locationManager_didFinishDeferredUpdatesWithError: ((CLLocationManager, Error?) -> Void)?
    var _locationManager_didVisit: ((CLLocationManager, CLVisit) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(locationManager(_:didUpdateLocations:)) : _locationManager_didUpdateLocations,
            #selector(locationManager(_:didUpdateHeading:)) : _locationManager_didUpdateHeading,
            #selector(locationManagerShouldDisplayHeadingCalibration(_:)) : _locationManagerShouldDisplayHeadingCalibration,
            #selector(locationManager(_:didDetermineState:for:)) : _locationManager_didDetermineState,
            #selector(locationManager(_:didRangeBeacons:in:)) : _locationManager_didRangeBeacons,
            #selector(locationManager(_:rangingBeaconsDidFailFor:withError:)) : _locationManager_rangingBeaconsDidFailFor,
            #selector(locationManager(_:didEnterRegion:)) : _locationManager_didEnterRegion,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(locationManager(_:didExitRegion:)) : _locationManager_didExitRegion,
            #selector(locationManager(_:didFailWithError:)) : _locationManager_didFailWithError,
            #selector(locationManager(_:monitoringDidFailFor:withError:)) : _locationManager_monitoringDidFailFor,
            #selector(locationManager(_:didChangeAuthorization:)) : _locationManager_didChangeAuthorization,
            #selector(locationManager(_:didStartMonitoringFor:)) : _locationManager_didStartMonitoringFor,
            #selector(locationManagerDidPauseLocationUpdates(_:)) : _locationManagerDidPauseLocationUpdates,
            #selector(locationManagerDidResumeLocationUpdates(_:)) : _locationManagerDidResumeLocationUpdates,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        let funcDic3: [Selector : Any?] = [
            #selector(locationManager(_:didFinishDeferredUpdatesWithError:)) : _locationManager_didFinishDeferredUpdatesWithError,
            #selector(locationManager(_:didVisit:)) : _locationManager_didVisit,
        ]
        if let f = funcDic3[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        _locationManager_didUpdateLocations!(manager, locations)
    }
    @objc func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        _locationManager_didUpdateHeading!(manager, newHeading)
    }
    @objc func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return _locationManagerShouldDisplayHeadingCalibration!(manager)
    }
    @objc func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        _locationManager_didDetermineState!(manager, state, region)
    }
    @objc func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        _locationManager_didRangeBeacons!(manager, beacons, region)
    }
    @objc func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        _locationManager_rangingBeaconsDidFailFor!(manager, region, error)
    }
    @objc func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        _locationManager_didEnterRegion!(manager, region)
    }
    @objc func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        _locationManager_didExitRegion!(manager, region)
    }
    @objc func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        _locationManager_didFailWithError!(manager, error)
    }
    @objc func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        _locationManager_monitoringDidFailFor!(manager, region, error)
    }
    @objc func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        _locationManager_didChangeAuthorization!(manager, status)
    }
    @objc func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        _locationManager_didStartMonitoringFor!(manager, region)
    }
    @objc func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        _locationManagerDidPauseLocationUpdates!(manager)
    }
    @objc func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        _locationManagerDidResumeLocationUpdates!(manager)
    }
    @objc func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        _locationManager_didFinishDeferredUpdatesWithError!(manager, error)
    }
    @objc func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        _locationManager_didVisit!(manager, visit)
    }
}
