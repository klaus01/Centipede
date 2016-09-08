//
//  CE_UIGestureRecognizer_Action.swift
//  Centipede
//
//  Created by kelei on 15/6/8.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public typealias CE_UIGestureRecognizerAction = (UIGestureRecognizer) -> Void

public extension UIGestureRecognizer {
    
    public convenience init(action: CE_UIGestureRecognizerAction) {
        let proxy = UIGestureRecognizerProxy(action)
        self.init(target:proxy, action:#selector(UIGestureRecognizerProxy.act(gestureRecognizer:)))
        proxies[""] = proxy
    }
    
    public func action(action: CE_UIGestureRecognizerAction?) -> Self {
        return on(action)
    }
    
}

// MARK: - Internal

private struct Static { static var AssociationKey: UInt8 = 0 }

internal typealias UIGestureRecognizerProxies = [String: UIGestureRecognizerProxy]

internal class UIGestureRecognizerProxy : NSObject {
    
    var action: CE_UIGestureRecognizerAction
    
    init(_ action: CE_UIGestureRecognizerAction) {
        self.action = action
    }
    
    func act(gestureRecognizer: UIGestureRecognizer) {
        action(gestureRecognizer)
    }
}

internal extension UIGestureRecognizer {
    
    internal var proxies: UIGestureRecognizerProxies {
        get {
            if let result = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIGestureRecognizerProxies {
                return result
            } else {
                return setter(UIGestureRecognizerProxies())
            }
        }
        set {
            setter(newValue)
        }
    }
    
    @discardableResult
    private func setter(_ newValue: UIGestureRecognizerProxies) -> UIGestureRecognizerProxies {
        objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN);
        return newValue
    }
    
    internal func on(_ action: CE_UIGestureRecognizerAction?) -> Self {
        self.off()
        
        if action == nil {
            return self
        }
        
        let proxy = UIGestureRecognizerProxy(action!)
        addTarget(proxy, action: #selector(UIGestureRecognizerProxy.act(gestureRecognizer:)))
        proxies[""] = proxy
        
        return self
    }
    
    @discardableResult
    internal func off() -> Self {
        if let proxy = proxies[""] {
            self.removeTarget(proxy, action: #selector(UIGestureRecognizerProxy.act(gestureRecognizer:)))
            proxies.removeValue(forKey: "")
        }
        return self
    }
}
