//
//  CE_NSUserActivity.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
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
    
    @discardableResult
    public func ce_userActivityWillSave(handle: @escaping (NSUserActivity) -> Void) -> Self {
        ce._userActivityWillSave = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_userActivityWasContinued(handle: @escaping (NSUserActivity) -> Void) -> Self {
        ce._userActivityWasContinued = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_userActivity_didReceive(handle: @escaping (NSUserActivity?, InputStream, OutputStream) -> Void) -> Self {
        ce._userActivity_didReceive = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSUserActivity_Delegate: NSObject, NSUserActivityDelegate {
    
    var _userActivityWillSave: ((NSUserActivity) -> Void)?
    var _userActivityWasContinued: ((NSUserActivity) -> Void)?
    var _userActivity_didReceive: ((NSUserActivity?, InputStream, OutputStream) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(userActivityWillSave(_:)) : _userActivityWillSave,
            #selector(userActivityWasContinued(_:)) : _userActivityWasContinued,
            #selector(userActivity(_:didReceive:outputStream:)) : _userActivity_didReceive,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func userActivityWillSave(_ userActivity: NSUserActivity) {
        _userActivityWillSave!(userActivity)
    }
    @objc func userActivityWasContinued(_ userActivity: NSUserActivity) {
        _userActivityWasContinued!(userActivity)
    }
    @objc func userActivity(_ userActivity: NSUserActivity?, didReceive inputStream: InputStream, outputStream: OutputStream) {
        _userActivity_didReceive!(userActivity, inputStream, outputStream)
    }
}
