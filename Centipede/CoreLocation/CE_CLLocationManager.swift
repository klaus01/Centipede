//
//  CE_CLLocationManager.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import CoreLocation

public extension CLLocationManager {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: CLLocationManager_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? CLLocationManager_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
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
    
    public func ce_didUpdateLocations(handle: (manager: CLLocationManager, locations: [AnyObject]!) -> Void) -> Self {
        ce._didUpdateLocations = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateHeading(handle: (manager: CLLocationManager, newHeading: CLHeading!) -> Void) -> Self {
        ce._didUpdateHeading = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldDisplayHeadingCalibration(handle: (manager: CLLocationManager) -> Bool) -> Self {
        ce._shouldDisplayHeadingCalibration = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDetermineState(handle: (manager: CLLocationManager, state: CLRegionState, region: CLRegion!) -> Void) -> Self {
        ce._didDetermineState = handle
        rebindingDelegate()
        return self
    }
    public func ce_didRangeBeacons(handle: (manager: CLLocationManager, beacons: [AnyObject]!, region: CLBeaconRegion!) -> Void) -> Self {
        ce._didRangeBeacons = handle
        rebindingDelegate()
        return self
    }
    public func ce_rangingBeaconsDidFailForRegion(handle: (manager: CLLocationManager, region: CLBeaconRegion!, error: NSError!) -> Void) -> Self {
        ce._rangingBeaconsDidFailForRegion = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEnterRegion(handle: (manager: CLLocationManager, region: CLRegion!) -> Void) -> Self {
        ce._didEnterRegion = handle
        rebindingDelegate()
        return self
    }
    public func ce_didExitRegion(handle: (manager: CLLocationManager, region: CLRegion!) -> Void) -> Self {
        ce._didExitRegion = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFailWithError(handle: (manager: CLLocationManager, error: NSError!) -> Void) -> Self {
        ce._didFailWithError = handle
        rebindingDelegate()
        return self
    }
    public func ce_monitoringDidFailForRegion(handle: (manager: CLLocationManager, region: CLRegion!, error: NSError!) -> Void) -> Self {
        ce._monitoringDidFailForRegion = handle
        rebindingDelegate()
        return self
    }
    public func ce_didChangeAuthorizationStatus(handle: (manager: CLLocationManager, status: CLAuthorizationStatus) -> Void) -> Self {
        ce._didChangeAuthorizationStatus = handle
        rebindingDelegate()
        return self
    }
    public func ce_didStartMonitoringForRegion(handle: (manager: CLLocationManager, region: CLRegion!) -> Void) -> Self {
        ce._didStartMonitoringForRegion = handle
        rebindingDelegate()
        return self
    }
    public func ce_didPauseLocationUpdates(handle: (manager: CLLocationManager) -> Void) -> Self {
        ce._didPauseLocationUpdates = handle
        rebindingDelegate()
        return self
    }
    public func ce_didResumeLocationUpdates(handle: (manager: CLLocationManager) -> Void) -> Self {
        ce._didResumeLocationUpdates = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFinishDeferredUpdatesWithError(handle: (manager: CLLocationManager, error: NSError!) -> Void) -> Self {
        ce._didFinishDeferredUpdatesWithError = handle
        rebindingDelegate()
        return self
    }
    public func ce_didVisit(handle: (manager: CLLocationManager, visit: CLVisit!) -> Void) -> Self {
        ce._didVisit = handle
        rebindingDelegate()
        return self
    }
    
}

internal class CLLocationManager_Delegate: NSObject, CLLocationManagerDelegate {
    
    var _didUpdateLocations: ((CLLocationManager, [AnyObject]!) -> Void)?
    var _didUpdateHeading: ((CLLocationManager, CLHeading!) -> Void)?
    var _shouldDisplayHeadingCalibration: ((CLLocationManager) -> Bool)?
    var _didDetermineState: ((CLLocationManager, CLRegionState, CLRegion!) -> Void)?
    var _didRangeBeacons: ((CLLocationManager, [AnyObject]!, CLBeaconRegion!) -> Void)?
    var _rangingBeaconsDidFailForRegion: ((CLLocationManager, CLBeaconRegion!, NSError!) -> Void)?
    var _didEnterRegion: ((CLLocationManager, CLRegion!) -> Void)?
    var _didExitRegion: ((CLLocationManager, CLRegion!) -> Void)?
    var _didFailWithError: ((CLLocationManager, NSError!) -> Void)?
    var _monitoringDidFailForRegion: ((CLLocationManager, CLRegion!, NSError!) -> Void)?
    var _didChangeAuthorizationStatus: ((CLLocationManager, CLAuthorizationStatus) -> Void)?
    var _didStartMonitoringForRegion: ((CLLocationManager, CLRegion!) -> Void)?
    var _didPauseLocationUpdates: ((CLLocationManager) -> Void)?
    var _didResumeLocationUpdates: ((CLLocationManager) -> Void)?
    var _didFinishDeferredUpdatesWithError: ((CLLocationManager, NSError!) -> Void)?
    var _didVisit: ((CLLocationManager, CLVisit!) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "locationManager:didUpdateLocations:" : _didUpdateLocations,
            "locationManager:didUpdateHeading:" : _didUpdateHeading,
            "locationManagerShouldDisplayHeadingCalibration:" : _shouldDisplayHeadingCalibration,
            "locationManager:didDetermineState:forRegion:" : _didDetermineState,
            "locationManager:didRangeBeacons:inRegion:" : _didRangeBeacons,
            "locationManager:rangingBeaconsDidFailForRegion:withError:" : _rangingBeaconsDidFailForRegion,
            "locationManager:didEnterRegion:" : _didEnterRegion,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "locationManager:didExitRegion:" : _didExitRegion,
            "locationManager:didFailWithError:" : _didFailWithError,
            "locationManager:monitoringDidFailForRegion:withError:" : _monitoringDidFailForRegion,
            "locationManager:didChangeAuthorizationStatus:" : _didChangeAuthorizationStatus,
            "locationManager:didStartMonitoringForRegion:" : _didStartMonitoringForRegion,
            "locationManagerDidPauseLocationUpdates:" : _didPauseLocationUpdates,
            "locationManagerDidResumeLocationUpdates:" : _didResumeLocationUpdates,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        let funcDic3: [Selector : Any?] = [
            "locationManager:didFinishDeferredUpdatesWithError:" : _didFinishDeferredUpdatesWithError,
            "locationManager:didVisit:" : _didVisit,
        ]
        if let f = funcDic3[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func locationManager(manager: CLLocationManager, didUpdateLocations locations: [AnyObject]!) {
        _didUpdateLocations!(manager, locations)
    }
    @objc func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading!) {
        _didUpdateHeading!(manager, newHeading)
    }
    @objc func locationManagerShouldDisplayHeadingCalibration(manager: CLLocationManager) -> Bool {
        return _shouldDisplayHeadingCalibration!(manager)
    }
    @objc func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion!) {
        _didDetermineState!(manager, state, region)
    }
    @objc func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        _didRangeBeacons!(manager, beacons, region)
    }
    @objc func locationManager(manager: CLLocationManager, rangingBeaconsDidFailForRegion region: CLBeaconRegion!, withError error: NSError!) {
        _rangingBeaconsDidFailForRegion!(manager, region, error)
    }
    @objc func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion!) {
        _didEnterRegion!(manager, region)
    }
    @objc func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion!) {
        _didExitRegion!(manager, region)
    }
    @objc func locationManager(manager: CLLocationManager, didFailWithError error: NSError!) {
        _didFailWithError!(manager, error)
    }
    @objc func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        _monitoringDidFailForRegion!(manager, region, error)
    }
    @objc func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        _didChangeAuthorizationStatus!(manager, status)
    }
    @objc func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion!) {
        _didStartMonitoringForRegion!(manager, region)
    }
    @objc func locationManagerDidPauseLocationUpdates(manager: CLLocationManager) {
        _didPauseLocationUpdates!(manager)
    }
    @objc func locationManagerDidResumeLocationUpdates(manager: CLLocationManager) {
        _didResumeLocationUpdates!(manager)
    }
    @objc func locationManager(manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError!) {
        _didFinishDeferredUpdatesWithError!(manager, error)
    }
    @objc func locationManager(manager: CLLocationManager, didVisit visit: CLVisit!) {
        _didVisit!(manager, visit)
    }
}
