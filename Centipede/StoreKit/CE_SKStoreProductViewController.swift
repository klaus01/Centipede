//
//  CE_SKStoreProductViewController.swift
//  Centipede
//
//  Created by kelei on 2016/9/14.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import StoreKit

public extension SKStoreProductViewController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: SKStoreProductViewController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? SKStoreProductViewController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: SKStoreProductViewController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is SKStoreProductViewController_Delegate {
                return obj as! SKStoreProductViewController_Delegate
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
    
    internal override func getDelegateInstance() -> SKStoreProductViewController_Delegate {
        return SKStoreProductViewController_Delegate()
    }
    
    public func ce_productViewControllerDidFinish(handle: @escaping (SKStoreProductViewController) -> Void) -> Self {
        ce._productViewControllerDidFinish = handle
        rebindingDelegate()
        return self
    }
    
}

internal class SKStoreProductViewController_Delegate: UIViewController_Delegate, SKStoreProductViewControllerDelegate {
    
    var _productViewControllerDidFinish: ((SKStoreProductViewController) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(productViewControllerDidFinish(_:)) : _productViewControllerDidFinish,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        _productViewControllerDidFinish!(viewController)
    }
}
