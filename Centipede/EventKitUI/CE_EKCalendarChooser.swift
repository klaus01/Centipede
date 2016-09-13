//
//  CE_EKCalendarChooser.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import EventKitUI

public extension EKCalendarChooser {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: EKCalendarChooser_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? EKCalendarChooser_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: EKCalendarChooser_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is EKCalendarChooser_Delegate {
                return obj as! EKCalendarChooser_Delegate
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
    
    internal override func getDelegateInstance() -> EKCalendarChooser_Delegate {
        return EKCalendarChooser_Delegate()
    }
    
    public func ce_calendarChooserSelectionDidChange(handle: ((EKCalendarChooser) -> Void)) -> Self {
        ce._calendarChooserSelectionDidChange = handle
        rebindingDelegate()
        return self
    }
    public func ce_calendarChooserDidFinish(handle: ((EKCalendarChooser) -> Void)) -> Self {
        ce._calendarChooserDidFinish = handle
        rebindingDelegate()
        return self
    }
    public func ce_calendarChooserDidCancel(handle: ((EKCalendarChooser) -> Void)) -> Self {
        ce._calendarChooserDidCancel = handle
        rebindingDelegate()
        return self
    }
    
}

internal class EKCalendarChooser_Delegate: UIViewController_Delegate, EKCalendarChooserDelegate {
    
    var _calendarChooserSelectionDidChange: ((EKCalendarChooser) -> Void)?
    var _calendarChooserDidFinish: ((EKCalendarChooser) -> Void)?
    var _calendarChooserDidCancel: ((EKCalendarChooser) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(calendarChooserSelectionDidChange(_:)) : _calendarChooserSelectionDidChange,
            #selector(calendarChooserDidFinish(_:)) : _calendarChooserDidFinish,
            #selector(calendarChooserDidCancel(_:)) : _calendarChooserDidCancel,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func calendarChooserSelectionDidChange(_ calendarChooser: EKCalendarChooser) {
        _calendarChooserSelectionDidChange!(calendarChooser)
    }
    @objc func calendarChooserDidFinish(_ calendarChooser: EKCalendarChooser) {
        _calendarChooserDidFinish!(calendarChooser)
    }
    @objc func calendarChooserDidCancel(_ calendarChooser: EKCalendarChooser) {
        _calendarChooserDidCancel!(calendarChooser)
    }
}
