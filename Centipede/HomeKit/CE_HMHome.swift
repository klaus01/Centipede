//
//  CE_HMHome.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import HomeKit

public extension HMHome {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: HMHome_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? HMHome_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
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
    
    public func ce_homeDidUpdateName(handle: ((HMHome) -> Void)) -> Self {
        ce._homeDidUpdateName = handle
        rebindingDelegate()
        return self
    }
    public func ce_home(handle: ((HMHome, HMAccessory) -> Void)) -> Self {
        ce._home = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didRemove(handle: ((HMHome, HMAccessory) -> Void)) -> Self {
        ce._home_didRemove = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didAdd(handle: ((HMHome, HMUser) -> Void)) -> Self {
        ce._home_didAdd = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didRemove_didRemove(handle: ((HMHome, HMUser) -> Void)) -> Self {
        ce._home_didRemove_didRemove = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didUpdate(handle: ((HMHome, HMRoom, HMAccessory) -> Void)) -> Self {
        ce._home_didUpdate = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didAdd_didAdd(handle: ((HMHome, HMRoom) -> Void)) -> Self {
        ce._home_didAdd_didAdd = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didRemove_didRemove_didRemove(handle: ((HMHome, HMRoom) -> Void)) -> Self {
        ce._home_didRemove_didRemove_didRemove = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didUpdateNameFor(handle: ((HMHome, HMRoom) -> Void)) -> Self {
        ce._home_didUpdateNameFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didAdd_didAdd_didAdd(handle: ((HMHome, HMZone) -> Void)) -> Self {
        ce._home_didAdd_didAdd_didAdd = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didRemove_didRemove_didRemove_didRemove(handle: ((HMHome, HMZone) -> Void)) -> Self {
        ce._home_didRemove_didRemove_didRemove_didRemove = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didUpdateNameFor_didUpdateNameFor(handle: ((HMHome, HMZone) -> Void)) -> Self {
        ce._home_didUpdateNameFor_didUpdateNameFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didAdd_didAdd_didAdd_didAdd(handle: ((HMHome, HMRoom, HMZone) -> Void)) -> Self {
        ce._home_didAdd_didAdd_didAdd_didAdd = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didRemove_didRemove_didRemove_didRemove_didRemove(handle: ((HMHome, HMRoom, HMZone) -> Void)) -> Self {
        ce._home_didRemove_didRemove_didRemove_didRemove_didRemove = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didAdd_didAdd_didAdd_didAdd_didAdd(handle: ((HMHome, HMServiceGroup) -> Void)) -> Self {
        ce._home_didAdd_didAdd_didAdd_didAdd_didAdd = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove(handle: ((HMHome, HMServiceGroup) -> Void)) -> Self {
        ce._home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor(handle: ((HMHome, HMServiceGroup) -> Void)) -> Self {
        ce._home_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd(handle: ((HMHome, HMService, HMServiceGroup) -> Void)) -> Self {
        ce._home_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove(handle: ((HMHome, HMService, HMServiceGroup) -> Void)) -> Self {
        ce._home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd(handle: ((HMHome, HMActionSet) -> Void)) -> Self {
        ce._home_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove(handle: ((HMHome, HMActionSet) -> Void)) -> Self {
        ce._home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor(handle: ((HMHome, HMActionSet) -> Void)) -> Self {
        ce._home_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didUpdateActionsFor(handle: ((HMHome, HMActionSet) -> Void)) -> Self {
        ce._home_didUpdateActionsFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd(handle: ((HMHome, HMTrigger) -> Void)) -> Self {
        ce._home_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove(handle: ((HMHome, HMTrigger) -> Void)) -> Self {
        ce._home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor(handle: ((HMHome, HMTrigger) -> Void)) -> Self {
        ce._home_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didUpdate_didUpdate(handle: ((HMHome, HMTrigger) -> Void)) -> Self {
        ce._home_didUpdate_didUpdate = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didUnblockAccessory(handle: ((HMHome, HMAccessory) -> Void)) -> Self {
        ce._home_didUnblockAccessory = handle
        rebindingDelegate()
        return self
    }
    public func ce_home_didEncounterError(handle: ((HMHome, Error, HMAccessory) -> Void)) -> Self {
        ce._home_didEncounterError = handle
        rebindingDelegate()
        return self
    }
    
}

internal class HMHome_Delegate: NSObject, HMHomeDelegate {
    
    var _homeDidUpdateName: ((HMHome) -> Void)?
    var _home: ((HMHome, HMAccessory) -> Void)?
    var _home_didRemove: ((HMHome, HMAccessory) -> Void)?
    var _home_didAdd: ((HMHome, HMUser) -> Void)?
    var _home_didRemove_didRemove: ((HMHome, HMUser) -> Void)?
    var _home_didUpdate: ((HMHome, HMRoom, HMAccessory) -> Void)?
    var _home_didAdd_didAdd: ((HMHome, HMRoom) -> Void)?
    var _home_didRemove_didRemove_didRemove: ((HMHome, HMRoom) -> Void)?
    var _home_didUpdateNameFor: ((HMHome, HMRoom) -> Void)?
    var _home_didAdd_didAdd_didAdd: ((HMHome, HMZone) -> Void)?
    var _home_didRemove_didRemove_didRemove_didRemove: ((HMHome, HMZone) -> Void)?
    var _home_didUpdateNameFor_didUpdateNameFor: ((HMHome, HMZone) -> Void)?
    var _home_didAdd_didAdd_didAdd_didAdd: ((HMHome, HMRoom, HMZone) -> Void)?
    var _home_didRemove_didRemove_didRemove_didRemove_didRemove: ((HMHome, HMRoom, HMZone) -> Void)?
    var _home_didAdd_didAdd_didAdd_didAdd_didAdd: ((HMHome, HMServiceGroup) -> Void)?
    var _home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove: ((HMHome, HMServiceGroup) -> Void)?
    var _home_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor: ((HMHome, HMServiceGroup) -> Void)?
    var _home_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd: ((HMHome, HMService, HMServiceGroup) -> Void)?
    var _home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove: ((HMHome, HMService, HMServiceGroup) -> Void)?
    var _home_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd: ((HMHome, HMActionSet) -> Void)?
    var _home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove: ((HMHome, HMActionSet) -> Void)?
    var _home_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor: ((HMHome, HMActionSet) -> Void)?
    var _home_didUpdateActionsFor: ((HMHome, HMActionSet) -> Void)?
    var _home_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd: ((HMHome, HMTrigger) -> Void)?
    var _home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove: ((HMHome, HMTrigger) -> Void)?
    var _home_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor: ((HMHome, HMTrigger) -> Void)?
    var _home_didUpdate_didUpdate: ((HMHome, HMTrigger) -> Void)?
    var _home_didUnblockAccessory: ((HMHome, HMAccessory) -> Void)?
    var _home_didEncounterError: ((HMHome, Error, HMAccessory) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(homeDidUpdateName(_:)) : _homeDidUpdateName,
            #selector(home(_:didAdd:)) : _home,
            #selector(home(_:didRemove:)) : _home_didRemove,
            #selector(home(_:didAdd:)) : _home_didAdd,
            #selector(home(_:didRemove:)) : _home_didRemove_didRemove,
            #selector(home(_:didUpdate:for:)) : _home_didUpdate,
            #selector(home(_:didAdd:)) : _home_didAdd_didAdd,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(home(_:didRemove:)) : _home_didRemove_didRemove_didRemove,
            #selector(home(_:didUpdateNameFor:)) : _home_didUpdateNameFor,
            #selector(home(_:didAdd:)) : _home_didAdd_didAdd_didAdd,
            #selector(home(_:didRemove:)) : _home_didRemove_didRemove_didRemove_didRemove,
            #selector(home(_:didUpdateNameFor:)) : _home_didUpdateNameFor_didUpdateNameFor,
            #selector(home(_:didAdd:to:)) : _home_didAdd_didAdd_didAdd_didAdd,
            #selector(home(_:didRemove:from:)) : _home_didRemove_didRemove_didRemove_didRemove_didRemove,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        let funcDic3: [Selector : Any?] = [
            #selector(home(_:didAdd:)) : _home_didAdd_didAdd_didAdd_didAdd_didAdd,
            #selector(home(_:didRemove:)) : _home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove,
            #selector(home(_:didUpdateNameFor:)) : _home_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor,
            #selector(home(_:didAdd:to:)) : _home_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd,
            #selector(home(_:didRemove:from:)) : _home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove,
            #selector(home(_:didAdd:)) : _home_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd,
            #selector(home(_:didRemove:)) : _home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove,
        ]
        if let f = funcDic3[aSelector] {
            return f != nil
        }
        
        let funcDic4: [Selector : Any?] = [
            #selector(home(_:didUpdateNameFor:)) : _home_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor,
            #selector(home(_:didUpdateActionsFor:)) : _home_didUpdateActionsFor,
            #selector(home(_:didAdd:)) : _home_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd,
            #selector(home(_:didRemove:)) : _home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove,
            #selector(home(_:didUpdateNameFor:)) : _home_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor,
            #selector(home(_:didUpdate:)) : _home_didUpdate_didUpdate,
            #selector(home(_:didUnblockAccessory:)) : _home_didUnblockAccessory,
        ]
        if let f = funcDic4[aSelector] {
            return f != nil
        }
        
        let funcDic5: [Selector : Any?] = [
            #selector(home(_:didEncounterError:for:)) : _home_didEncounterError,
        ]
        if let f = funcDic5[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func homeDidUpdateName(_ home: HMHome) {
        _homeDidUpdateName!(home)
    }
    @objc func home(_ home: HMHome, didAdd accessory: HMAccessory) {
        _home!(home, accessory)
    }
    @objc func home(_ home: HMHome, didRemove accessory: HMAccessory) {
        _home_didRemove!(home, accessory)
    }
    @objc func home(_ home: HMHome, didAdd user: HMUser) {
        _home_didAdd!(home, user)
    }
    @objc func home(_ home: HMHome, didRemove user: HMUser) {
        _home_didRemove_didRemove!(home, user)
    }
    @objc func home(_ home: HMHome, didUpdate room: HMRoom, for accessory: HMAccessory) {
        _home_didUpdate!(home, room, accessory)
    }
    @objc func home(_ home: HMHome, didAdd room: HMRoom) {
        _home_didAdd_didAdd!(home, room)
    }
    @objc func home(_ home: HMHome, didRemove room: HMRoom) {
        _home_didRemove_didRemove_didRemove!(home, room)
    }
    @objc func home(_ home: HMHome, didUpdateNameFor room: HMRoom) {
        _home_didUpdateNameFor!(home, room)
    }
    @objc func home(_ home: HMHome, didAdd zone: HMZone) {
        _home_didAdd_didAdd_didAdd!(home, zone)
    }
    @objc func home(_ home: HMHome, didRemove zone: HMZone) {
        _home_didRemove_didRemove_didRemove_didRemove!(home, zone)
    }
    @objc func home(_ home: HMHome, didUpdateNameFor zone: HMZone) {
        _home_didUpdateNameFor_didUpdateNameFor!(home, zone)
    }
    @objc func home(_ home: HMHome, didAdd room: HMRoom, to zone: HMZone) {
        _home_didAdd_didAdd_didAdd_didAdd!(home, room, zone)
    }
    @objc func home(_ home: HMHome, didRemove room: HMRoom, from zone: HMZone) {
        _home_didRemove_didRemove_didRemove_didRemove_didRemove!(home, room, zone)
    }
    @objc func home(_ home: HMHome, didAdd group: HMServiceGroup) {
        _home_didAdd_didAdd_didAdd_didAdd_didAdd!(home, group)
    }
    @objc func home(_ home: HMHome, didRemove group: HMServiceGroup) {
        _home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove!(home, group)
    }
    @objc func home(_ home: HMHome, didUpdateNameFor group: HMServiceGroup) {
        _home_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor!(home, group)
    }
    @objc func home(_ home: HMHome, didAdd service: HMService, to group: HMServiceGroup) {
        _home_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd!(home, service, group)
    }
    @objc func home(_ home: HMHome, didRemove service: HMService, from group: HMServiceGroup) {
        _home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove!(home, service, group)
    }
    @objc func home(_ home: HMHome, didAdd actionSet: HMActionSet) {
        _home_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd!(home, actionSet)
    }
    @objc func home(_ home: HMHome, didRemove actionSet: HMActionSet) {
        _home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove!(home, actionSet)
    }
    @objc func home(_ home: HMHome, didUpdateNameFor actionSet: HMActionSet) {
        _home_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor!(home, actionSet)
    }
    @objc func home(_ home: HMHome, didUpdateActionsFor actionSet: HMActionSet) {
        _home_didUpdateActionsFor!(home, actionSet)
    }
    @objc func home(_ home: HMHome, didAdd trigger: HMTrigger) {
        _home_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd_didAdd!(home, trigger)
    }
    @objc func home(_ home: HMHome, didRemove trigger: HMTrigger) {
        _home_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove_didRemove!(home, trigger)
    }
    @objc func home(_ home: HMHome, didUpdateNameFor trigger: HMTrigger) {
        _home_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor_didUpdateNameFor!(home, trigger)
    }
    @objc func home(_ home: HMHome, didUpdate trigger: HMTrigger) {
        _home_didUpdate_didUpdate!(home, trigger)
    }
    @objc func home(_ home: HMHome, didUnblockAccessory accessory: HMAccessory) {
        _home_didUnblockAccessory!(home, accessory)
    }
    @objc func home(_ home: HMHome, didEncounterError error: Error, for accessory: HMAccessory) {
        _home_didEncounterError!(home, error, accessory)
    }
}
