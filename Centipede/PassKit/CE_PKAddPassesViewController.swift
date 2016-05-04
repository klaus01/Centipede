//
//  CE_PKAddPassesViewController.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import PassKit

public extension PKAddPassesViewController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: PKAddPassesViewController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? PKAddPassesViewController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: PKAddPassesViewController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is PKAddPassesViewController_Delegate {
                return obj as! PKAddPassesViewController_Delegate
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
    
    internal override func getDelegateInstance() -> PKAddPassesViewController_Delegate {
        return PKAddPassesViewController_Delegate()
    }
    
    public func ce_didFinish(handle: (controller: PKAddPassesViewController) -> Void) -> Self {
        ce._didFinish = handle
        rebindingDelegate()
        return self
    }
    
}

internal class PKAddPassesViewController_Delegate: UIViewController_Delegate, PKAddPassesViewControllerDelegate {
    
    var _didFinish: ((PKAddPassesViewController) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(addPassesViewControllerDidFinish(_:)) : _didFinish,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func addPassesViewControllerDidFinish(controller: PKAddPassesViewController) {
        _didFinish!(controller)
    }
}
