//
//  CE_UIControl.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public typealias CE_UIControlAction = (UIControl, NSSet) -> Void

public extension UIControl {
    
    @discardableResult
    public func ce_addControlEvents(controlEvents: UIControlEvents, action: @escaping CE_UIControlAction) -> Self {
        return on(controlEvents, action: action)
    }
    
    @discardableResult
    public func ce_removeControlEvents(controlEvents: UIControlEvents) -> Self {
        return off(controlEvents)
    }
    
}

// MARK: - private

private struct Static { static var AssociationKey: UInt8 = 0 }

private typealias UIControlProxies = [String: UIControlProxy]

fileprivate class UIControlProxy : NSObject {
    
    var action: CE_UIControlAction
    
    init(_ action: @escaping CE_UIControlAction) {
        self.action = action
    }
    
    func act(source: UIControl, touches: NSSet) {
        action(source, touches)
    }
}

fileprivate extension UIControl {
    
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
    
    private func proxyKey(_ event: UIControlEvents) -> String {
        return "UIControl:\(event.rawValue)"
    }
    
    @discardableResult
    private func setter(_ newValue: UIControlProxies) -> UIControlProxies {
        objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN);
        return newValue
    }
    
    fileprivate func on(_ controlEvents: UIControlEvents, action: @escaping CE_UIControlAction) -> Self {
        self.off(controlEvents)
        
        let proxy = UIControlProxy(action)
        self.addTarget(proxy, action: #selector(UIControlProxy.act(source:touches:)), for: controlEvents)
        
        let eventKey: String = proxyKey(controlEvents)
        proxies[eventKey] = proxy
        
        return self
    }
    
    @discardableResult
    fileprivate func off(_ controlEvents: UIControlEvents) -> Self {
        if let proxy = proxies[proxyKey(controlEvents)] {
            self.removeTarget(proxy, action: #selector(UIControlProxy.act(source:touches:)), for: controlEvents)
            proxies.removeValue(forKey: proxyKey(controlEvents))
        }
        return self
    }
}
