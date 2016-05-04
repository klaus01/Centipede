//
//  CE_UIBarButtonItem.swift
//  Centipede
//
//  Created by kelei on 15/6/8.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public typealias CE_UIBarButtonItemAction = (gestureRecognizer: UIBarButtonItem) -> Void

public extension UIBarButtonItem {
    
    public func action(action: CE_UIBarButtonItemAction?) -> Self {
        return on(action)
    }
    
}

// MARK: - Internal

private struct Static { static var AssociationKey: UInt8 = 0 }

private typealias UIBarButtonItemProxies = [String: UIBarButtonItemProxy]

internal class UIBarButtonItemProxy : NSObject {
    
    var action: CE_UIBarButtonItemAction
    
    init(_ action: CE_UIBarButtonItemAction) {
        self.action = action
    }
    
    func act(gestureRecognizer: UIBarButtonItem) {
        action(gestureRecognizer: gestureRecognizer)
    }
}

internal extension UIBarButtonItem {
    
    private var proxies: UIBarButtonItemProxies {
        get {
            if let result = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIBarButtonItemProxies {
                return result
            } else {
                return setter(UIBarButtonItemProxies())
            }
        }
        set {
            setter(newValue)
        }
    }
    
    private func setter(newValue: UIBarButtonItemProxies) -> UIBarButtonItemProxies {
        objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN);
        return newValue
    }
    
    internal func on(action: CE_UIBarButtonItemAction?) -> Self {
        self.off()
        
        if action == nil {
            return self
        }
        
        let proxy = UIBarButtonItemProxy(action!)
        self.target = proxy
        self.action = #selector(UIBarButtonItemProxy.act(_:))
        proxies[""] = proxy

        return self
    }
    
    internal func off() -> Self {
        if let _ = proxies[""] {
            target = nil
            action = nil
            proxies.removeValueForKey("")
        }
        return self
    }
}
