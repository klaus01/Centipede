//
//  CE_NSUserActivity.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import Foundation

public extension NSUserActivity {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NSUserActivity_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NSUserActivity_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: NSUserActivity_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is NSUserActivity_Delegate {
                return obj as! NSUserActivity_Delegate
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
    
    internal func getDelegateInstance() -> NSUserActivity_Delegate {
        return NSUserActivity_Delegate()
    }
    
    public func ce_willSave(handle: (userActivity: NSUserActivity) -> Void) -> Self {
        ce._willSave = handle
        rebindingDelegate()
        return self
    }
    public func ce_wasContinued(handle: (userActivity: NSUserActivity) -> Void) -> Self {
        ce._wasContinued = handle
        rebindingDelegate()
        return self
    }
    public func ce_didReceiveInputStream(handle: (userActivity: NSUserActivity?, inputStream: NSInputStream, outputStream: NSOutputStream) -> Void) -> Self {
        ce._didReceiveInputStream = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSUserActivity_Delegate: NSObject, NSUserActivityDelegate {
    
    var _willSave: ((NSUserActivity) -> Void)?
    var _wasContinued: ((NSUserActivity) -> Void)?
    var _didReceiveInputStream: ((NSUserActivity?, NSInputStream, NSOutputStream) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "userActivityWillSave:" : _willSave,
            "userActivityWasContinued:" : _wasContinued,
            "userActivity:didReceiveInputStream:outputStream:" : _didReceiveInputStream,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func userActivityWillSave(userActivity: NSUserActivity) {
        _willSave!(userActivity)
    }
    @objc func userActivityWasContinued(userActivity: NSUserActivity) {
        _wasContinued!(userActivity)
    }
    @objc func userActivity(userActivity: NSUserActivity?, didReceiveInputStream inputStream: NSInputStream, outputStream: NSOutputStream) {
        _didReceiveInputStream!(userActivity, inputStream, outputStream)
    }
}
