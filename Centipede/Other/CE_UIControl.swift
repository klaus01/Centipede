//
//  CE_UIControl.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public typealias CE_UIControlAction = (control: UIControl, touches: NSSet) -> Void

public extension UIControl {
    
    public func ce_addControlEvents(controlEvents: UIControlEvents, action: CE_UIControlAction) -> Self {
        return on(controlEvents, action: action)
    }
    
    public func ce_removeControlEvents(controlEvents: UIControlEvents) -> Self {
        return off(controlEvents)
    }
    
}

// MARK: - Internal

private struct Static { static var AssociationKey: UInt8 = 0 }

private typealias UIControlProxies = [String: UIControlProxy]

internal class UIControlProxy : NSObject {
    
    var action: CE_UIControlAction
    
    init(_ action: CE_UIControlAction) {
        self.action = action
    }
    
    func act(source: UIControl, touches: NSSet) {
        action(control: source, touches: touches)
    }
}

internal extension UIControl {
    
    private var proxies: UIControlProxies {
        get {
            if let result = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIControlProxies {
                return result
            } else {
                return setter(UIControlProxies())
            }
        }
        set {
            setter(newValue)
        }
    }
    
    private func proxyKey(event: UIControlEvents) -> String {
        return "UIControl:\(event.rawValue)"
    }
    
    private func setter(newValue: UIControlProxies) -> UIControlProxies {
        objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN));
        return newValue
    }
    
    internal func on(controlEvents: UIControlEvents, action: CE_UIControlAction) -> Self {
        self.off(controlEvents)
        
        let proxy = UIControlProxy(action)
        self.addTarget(proxy, action: "act:touches:", forControlEvents: controlEvents)
        
        let eventKey: String = proxyKey(controlEvents)
        proxies[eventKey] = proxy
        
        return self
    }
    
    internal func off(controlEvents: UIControlEvents) -> Self {
        
        if let proxy = proxies[proxyKey(controlEvents)] {
            self.removeTarget(proxy, action: "act:touches:", forControlEvents: controlEvents)
            proxies.removeValueForKey(proxyKey(controlEvents))
        }
        return self
    }
}