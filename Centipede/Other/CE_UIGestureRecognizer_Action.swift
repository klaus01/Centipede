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
    
    public convenience init(action: @escaping CE_UIGestureRecognizerAction) {
        let proxy = UIGestureRecognizerProxy(action)
        self.init(target:proxy, action:#selector(UIGestureRecognizerProxy.act(gestureRecognizer:)))
        proxies[""] = proxy
    }
    
    @discardableResult
    public func action(action: CE_UIGestureRecognizerAction?) -> Self {
        return on(action)
    }
    
}

// MARK: - private

private struct Static { static var AssociationKey: UInt8 = 0 }

fileprivate typealias UIGestureRecognizerProxies = [String: UIGestureRecognizerProxy]

fileprivate class UIGestureRecognizerProxy : NSObject {
    
    var action: CE_UIGestureRecognizerAction
    
    init(_ action: @escaping CE_UIGestureRecognizerAction) {
        self.action = action
    }
    
    func act(gestureRecognizer: UIGestureRecognizer) {
        action(gestureRecognizer)
    }
}

fileprivate extension UIGestureRecognizer {
    
    fileprivate var proxies: UIGestureRecognizerProxies {
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
    
    fileprivate func on(_ action: CE_UIGestureRecognizerAction?) -> Self {
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
    fileprivate func off() -> Self {
        if let proxy = proxies[""] {
            self.removeTarget(proxy, action: #selector(UIGestureRecognizerProxy.act(gestureRecognizer:)))
            proxies.removeValue(forKey: "")
        }
        return self
    }
}
