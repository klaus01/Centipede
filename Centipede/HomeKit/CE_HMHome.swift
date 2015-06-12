//
//  CE_HMHome.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import HomeKit

public extension HMHome {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: HMHome_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? HMHome_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: HMHome_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is HMHome_Delegate {
                return obj as! HMHome_Delegate
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
    
    internal func getDelegateInstance() -> HMHome_Delegate {
        return HMHome_Delegate()
    }
    
    public func ce_didUpdateName(handle: (home: HMHome) -> Void) -> Self {
        ce._didUpdateName = handle
        rebindingDelegate()
        return self
    }
    public func ce_didAddAccessory(handle: (home: HMHome, accessory: HMAccessory!) -> Void) -> Self {
        ce._didAddAccessory = handle
        rebindingDelegate()
        return self
    }
    public func ce_didRemoveAccessory(handle: (home: HMHome, accessory: HMAccessory!) -> Void) -> Self {
        ce._didRemoveAccessory = handle
        rebindingDelegate()
        return self
    }
    public func ce_didAddUser(handle: (home: HMHome, user: HMUser!) -> Void) -> Self {
        ce._didAddUser = handle
        rebindingDelegate()
        return self
    }
    public func ce_didRemoveUser(handle: (home: HMHome, user: HMUser!) -> Void) -> Self {
        ce._didRemoveUser = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateRoom(handle: (home: HMHome, room: HMRoom!, accessory: HMAccessory!) -> Void) -> Self {
        ce._didUpdateRoom = handle
        rebindingDelegate()
        return self
    }
    public func ce_didAddRoom(handle: (home: HMHome, room: HMRoom!) -> Void) -> Self {
        ce._didAddRoom = handle
        rebindingDelegate()
        return self
    }
    public func ce_didRemoveRoom(handle: (home: HMHome, room: HMRoom!) -> Void) -> Self {
        ce._didRemoveRoom = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateNameForRoom(handle: (home: HMHome, room: HMRoom!) -> Void) -> Self {
        ce._didUpdateNameForRoom = handle
        rebindingDelegate()
        return self
    }
    public func ce_didAddZone(handle: (home: HMHome, zone: HMZone!) -> Void) -> Self {
        ce._didAddZone = handle
        rebindingDelegate()
        return self
    }
    public func ce_didRemoveZone(handle: (home: HMHome, zone: HMZone!) -> Void) -> Self {
        ce._didRemoveZone = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateNameForZone(handle: (home: HMHome, zone: HMZone!) -> Void) -> Self {
        ce._didUpdateNameForZone = handle
        rebindingDelegate()
        return self
    }
    public func ce_didAddRoomAndDidAddRoom(handle: (home: HMHome, room: HMRoom!, zone: HMZone!) -> Void) -> Self {
        ce._didAddRoomAndDidAddRoom = handle
        rebindingDelegate()
        return self
    }
    public func ce_didRemoveRoomAndDidRemoveRoom(handle: (home: HMHome, room: HMRoom!, zone: HMZone!) -> Void) -> Self {
        ce._didRemoveRoomAndDidRemoveRoom = handle
        rebindingDelegate()
        return self
    }
    public func ce_didAddServiceGroup(handle: (home: HMHome, group: HMServiceGroup!) -> Void) -> Self {
        ce._didAddServiceGroup = handle
        rebindingDelegate()
        return self
    }
    public func ce_didRemoveServiceGroup(handle: (home: HMHome, group: HMServiceGroup!) -> Void) -> Self {
        ce._didRemoveServiceGroup = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateNameForServiceGroup(handle: (home: HMHome, group: HMServiceGroup!) -> Void) -> Self {
        ce._didUpdateNameForServiceGroup = handle
        rebindingDelegate()
        return self
    }
    public func ce_didAddService(handle: (home: HMHome, service: HMService!, group: HMServiceGroup!) -> Void) -> Self {
        ce._didAddService = handle
        rebindingDelegate()
        return self
    }
    public func ce_didRemoveService(handle: (home: HMHome, service: HMService!, group: HMServiceGroup!) -> Void) -> Self {
        ce._didRemoveService = handle
        rebindingDelegate()
        return self
    }
    public func ce_didAddActionSet(handle: (home: HMHome, actionSet: HMActionSet!) -> Void) -> Self {
        ce._didAddActionSet = handle
        rebindingDelegate()
        return self
    }
    public func ce_didRemoveActionSet(handle: (home: HMHome, actionSet: HMActionSet!) -> Void) -> Self {
        ce._didRemoveActionSet = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateNameForActionSet(handle: (home: HMHome, actionSet: HMActionSet!) -> Void) -> Self {
        ce._didUpdateNameForActionSet = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateActionsForActionSet(handle: (home: HMHome, actionSet: HMActionSet!) -> Void) -> Self {
        ce._didUpdateActionsForActionSet = handle
        rebindingDelegate()
        return self
    }
    public func ce_didAddTrigger(handle: (home: HMHome, trigger: HMTrigger!) -> Void) -> Self {
        ce._didAddTrigger = handle
        rebindingDelegate()
        return self
    }
    public func ce_didRemoveTrigger(handle: (home: HMHome, trigger: HMTrigger!) -> Void) -> Self {
        ce._didRemoveTrigger = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateNameForTrigger(handle: (home: HMHome, trigger: HMTrigger!) -> Void) -> Self {
        ce._didUpdateNameForTrigger = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUpdateTrigger(handle: (home: HMHome, trigger: HMTrigger!) -> Void) -> Self {
        ce._didUpdateTrigger = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUnblockAccessory(handle: (home: HMHome, accessory: HMAccessory!) -> Void) -> Self {
        ce._didUnblockAccessory = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEncounterError(handle: (home: HMHome, error: NSError!, accessory: HMAccessory!) -> Void) -> Self {
        ce._didEncounterError = handle
        rebindingDelegate()
        return self
    }
    
}

internal class HMHome_Delegate: NSObject, HMHomeDelegate {
    
    var _didUpdateName: ((HMHome) -> Void)?
    var _didAddAccessory: ((HMHome, HMAccessory!) -> Void)?
    var _didRemoveAccessory: ((HMHome, HMAccessory!) -> Void)?
    var _didAddUser: ((HMHome, HMUser!) -> Void)?
    var _didRemoveUser: ((HMHome, HMUser!) -> Void)?
    var _didUpdateRoom: ((HMHome, HMRoom!, HMAccessory!) -> Void)?
    var _didAddRoom: ((HMHome, HMRoom!) -> Void)?
    var _didRemoveRoom: ((HMHome, HMRoom!) -> Void)?
    var _didUpdateNameForRoom: ((HMHome, HMRoom!) -> Void)?
    var _didAddZone: ((HMHome, HMZone!) -> Void)?
    var _didRemoveZone: ((HMHome, HMZone!) -> Void)?
    var _didUpdateNameForZone: ((HMHome, HMZone!) -> Void)?
    var _didAddRoomAndDidAddRoom: ((HMHome, HMRoom!, HMZone!) -> Void)?
    var _didRemoveRoomAndDidRemoveRoom: ((HMHome, HMRoom!, HMZone!) -> Void)?
    var _didAddServiceGroup: ((HMHome, HMServiceGroup!) -> Void)?
    var _didRemoveServiceGroup: ((HMHome, HMServiceGroup!) -> Void)?
    var _didUpdateNameForServiceGroup: ((HMHome, HMServiceGroup!) -> Void)?
    var _didAddService: ((HMHome, HMService!, HMServiceGroup!) -> Void)?
    var _didRemoveService: ((HMHome, HMService!, HMServiceGroup!) -> Void)?
    var _didAddActionSet: ((HMHome, HMActionSet!) -> Void)?
    var _didRemoveActionSet: ((HMHome, HMActionSet!) -> Void)?
    var _didUpdateNameForActionSet: ((HMHome, HMActionSet!) -> Void)?
    var _didUpdateActionsForActionSet: ((HMHome, HMActionSet!) -> Void)?
    var _didAddTrigger: ((HMHome, HMTrigger!) -> Void)?
    var _didRemoveTrigger: ((HMHome, HMTrigger!) -> Void)?
    var _didUpdateNameForTrigger: ((HMHome, HMTrigger!) -> Void)?
    var _didUpdateTrigger: ((HMHome, HMTrigger!) -> Void)?
    var _didUnblockAccessory: ((HMHome, HMAccessory!) -> Void)?
    var _didEncounterError: ((HMHome, NSError!, HMAccessory!) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "homeDidUpdateName:" : _didUpdateName,
            "home:didAddAccessory:" : _didAddAccessory,
            "home:didRemoveAccessory:" : _didRemoveAccessory,
            "home:didAddUser:" : _didAddUser,
            "home:didRemoveUser:" : _didRemoveUser,
            "home:didUpdateRoom:forAccessory:" : _didUpdateRoom,
            "home:didAddRoom:" : _didAddRoom,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "home:didRemoveRoom:" : _didRemoveRoom,
            "home:didUpdateNameForRoom:" : _didUpdateNameForRoom,
            "home:didAddZone:" : _didAddZone,
            "home:didRemoveZone:" : _didRemoveZone,
            "home:didUpdateNameForZone:" : _didUpdateNameForZone,
            "home:didAddRoom:toZone:" : _didAddRoomAndDidAddRoom,
            "home:didRemoveRoom:fromZone:" : _didRemoveRoomAndDidRemoveRoom,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        let funcDic3: [Selector : Any?] = [
            "home:didAddServiceGroup:" : _didAddServiceGroup,
            "home:didRemoveServiceGroup:" : _didRemoveServiceGroup,
            "home:didUpdateNameForServiceGroup:" : _didUpdateNameForServiceGroup,
            "home:didAddService:toServiceGroup:" : _didAddService,
            "home:didRemoveService:fromServiceGroup:" : _didRemoveService,
            "home:didAddActionSet:" : _didAddActionSet,
            "home:didRemoveActionSet:" : _didRemoveActionSet,
        ]
        if let f = funcDic3[aSelector] {
            return f != nil
        }
        
        let funcDic4: [Selector : Any?] = [
            "home:didUpdateNameForActionSet:" : _didUpdateNameForActionSet,
            "home:didUpdateActionsForActionSet:" : _didUpdateActionsForActionSet,
            "home:didAddTrigger:" : _didAddTrigger,
            "home:didRemoveTrigger:" : _didRemoveTrigger,
            "home:didUpdateNameForTrigger:" : _didUpdateNameForTrigger,
            "home:didUpdateTrigger:" : _didUpdateTrigger,
            "home:didUnblockAccessory:" : _didUnblockAccessory,
        ]
        if let f = funcDic4[aSelector] {
            return f != nil
        }
        
        let funcDic5: [Selector : Any?] = [
            "home:didEncounterError:forAccessory:" : _didEncounterError,
        ]
        if let f = funcDic5[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func homeDidUpdateName(home: HMHome) {
        _didUpdateName!(home)
    }
    @objc func home(home: HMHome, didAddAccessory accessory: HMAccessory!) {
        _didAddAccessory!(home, accessory)
    }
    @objc func home(home: HMHome, didRemoveAccessory accessory: HMAccessory!) {
        _didRemoveAccessory!(home, accessory)
    }
    @objc func home(home: HMHome, didAddUser user: HMUser!) {
        _didAddUser!(home, user)
    }
    @objc func home(home: HMHome, didRemoveUser user: HMUser!) {
        _didRemoveUser!(home, user)
    }
    @objc func home(home: HMHome, didUpdateRoom room: HMRoom!, forAccessory accessory: HMAccessory!) {
        _didUpdateRoom!(home, room, accessory)
    }
    @objc func home(home: HMHome, didAddRoom room: HMRoom!) {
        _didAddRoom!(home, room)
    }
    @objc func home(home: HMHome, didRemoveRoom room: HMRoom!) {
        _didRemoveRoom!(home, room)
    }
    @objc func home(home: HMHome, didUpdateNameForRoom room: HMRoom!) {
        _didUpdateNameForRoom!(home, room)
    }
    @objc func home(home: HMHome, didAddZone zone: HMZone!) {
        _didAddZone!(home, zone)
    }
    @objc func home(home: HMHome, didRemoveZone zone: HMZone!) {
        _didRemoveZone!(home, zone)
    }
    @objc func home(home: HMHome, didUpdateNameForZone zone: HMZone!) {
        _didUpdateNameForZone!(home, zone)
    }
    @objc func home(home: HMHome, didAddRoom room: HMRoom!, toZone zone: HMZone!) {
        _didAddRoomAndDidAddRoom!(home, room, zone)
    }
    @objc func home(home: HMHome, didRemoveRoom room: HMRoom!, fromZone zone: HMZone!) {
        _didRemoveRoomAndDidRemoveRoom!(home, room, zone)
    }
    @objc func home(home: HMHome, didAddServiceGroup group: HMServiceGroup!) {
        _didAddServiceGroup!(home, group)
    }
    @objc func home(home: HMHome, didRemoveServiceGroup group: HMServiceGroup!) {
        _didRemoveServiceGroup!(home, group)
    }
    @objc func home(home: HMHome, didUpdateNameForServiceGroup group: HMServiceGroup!) {
        _didUpdateNameForServiceGroup!(home, group)
    }
    @objc func home(home: HMHome, didAddService service: HMService!, toServiceGroup group: HMServiceGroup!) {
        _didAddService!(home, service, group)
    }
    @objc func home(home: HMHome, didRemoveService service: HMService!, fromServiceGroup group: HMServiceGroup!) {
        _didRemoveService!(home, service, group)
    }
    @objc func home(home: HMHome, didAddActionSet actionSet: HMActionSet!) {
        _didAddActionSet!(home, actionSet)
    }
    @objc func home(home: HMHome, didRemoveActionSet actionSet: HMActionSet!) {
        _didRemoveActionSet!(home, actionSet)
    }
    @objc func home(home: HMHome, didUpdateNameForActionSet actionSet: HMActionSet!) {
        _didUpdateNameForActionSet!(home, actionSet)
    }
    @objc func home(home: HMHome, didUpdateActionsForActionSet actionSet: HMActionSet!) {
        _didUpdateActionsForActionSet!(home, actionSet)
    }
    @objc func home(home: HMHome, didAddTrigger trigger: HMTrigger!) {
        _didAddTrigger!(home, trigger)
    }
    @objc func home(home: HMHome, didRemoveTrigger trigger: HMTrigger!) {
        _didRemoveTrigger!(home, trigger)
    }
    @objc func home(home: HMHome, didUpdateNameForTrigger trigger: HMTrigger!) {
        _didUpdateNameForTrigger!(home, trigger)
    }
    @objc func home(home: HMHome, didUpdateTrigger trigger: HMTrigger!) {
        _didUpdateTrigger!(home, trigger)
    }
    @objc func home(home: HMHome, didUnblockAccessory accessory: HMAccessory!) {
        _didUnblockAccessory!(home, accessory)
    }
    @objc func home(home: HMHome, didEncounterError error: NSError!, forAccessory accessory: HMAccessory!) {
        _didEncounterError!(home, error, accessory)
    }
}
