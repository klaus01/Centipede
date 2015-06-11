//
//  CE_EKCalendarChooser.swift
//  Centipede
//
//  Created by kelei on 2015/6/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import EventKitUI

public extension EKCalendarChooser {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: EKCalendarChooser_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? EKCalendarChooser_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: EKCalendarChooser_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
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
    
    public func ce_selectionDidChange(handle: (calendarChooser: EKCalendarChooser) -> Void) -> Self {
        ce._selectionDidChange = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFinish(handle: (calendarChooser: EKCalendarChooser) -> Void) -> Self {
        ce._didFinish = handle
        rebindingDelegate()
        return self
    }
    public func ce_didCancel(handle: (calendarChooser: EKCalendarChooser) -> Void) -> Self {
        ce._didCancel = handle
        rebindingDelegate()
        return self
    }
    
}

internal class EKCalendarChooser_Delegate: UIViewController_Delegate, EKCalendarChooserDelegate {
    
    var _selectionDidChange: ((EKCalendarChooser) -> Void)?
    var _didFinish: ((EKCalendarChooser) -> Void)?
    var _didCancel: ((EKCalendarChooser) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "calendarChooserSelectionDidChange:" : _selectionDidChange,
            "calendarChooserDidFinish:" : _didFinish,
            "calendarChooserDidCancel:" : _didCancel,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func calendarChooserSelectionDidChange(calendarChooser: EKCalendarChooser) {
        _selectionDidChange!(calendarChooser)
    }
    @objc func calendarChooserDidFinish(calendarChooser: EKCalendarChooser) {
        _didFinish!(calendarChooser)
    }
    @objc func calendarChooserDidCancel(calendarChooser: EKCalendarChooser) {
        _didCancel!(calendarChooser)
    }
}
