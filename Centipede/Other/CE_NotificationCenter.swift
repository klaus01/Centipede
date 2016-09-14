//
//  CE_NotificationCenter.swift
//  Centipede
//
//  Created by kelei on 15/4/19.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import Foundation

public typealias CE_NotificationAction = (NSNotification) -> Void

public extension NSObject {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NSObject_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NSObject_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: NSObject_Delegate {
        if let obj = _delegate {
            return obj
        }
        let obj = NSObject_Delegate()
        _delegate = obj
        return obj
    }
    
    @discardableResult
    public func ce_addObserver(forName name: String, handle: @escaping CE_NotificationAction) -> Self {
        ce.addNotification(forName: name, handle: handle)
        NotificationCenter.default.addObserver(ce, selector: #selector(NSObject_Delegate.observerHandlerAction(_:)), name: NSNotification.Name(rawValue: name), object: nil)
        return self
    }
    
    @discardableResult
    public func ce_removeObserverForName(name: String) -> Self {
        NotificationCenter.default.removeObserver(ce, name: NSNotification.Name(rawValue: name), object: nil)
        return self
    }
    
    @discardableResult
    public func ce_removeObserver() -> Self {
        NotificationCenter.default.removeObserver(ce)
        return self
    }
    
}

private class NSObject_Delegate: NSObject {
    
    private var dic = [String : CE_NotificationAction]()
    
    func addNotification(forName name: String, handle: @escaping CE_NotificationAction) {
        dic[name] = handle
    }
    
    @objc func observerHandlerAction(_ notification: NSNotification) {
        if let action = dic[notification.name.rawValue] {
            action(notification)
        }
    }

}
