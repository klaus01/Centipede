//
//  CE_PKAddPassesViewController.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import PassKit

extension PKAddPassesViewController {
    
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
    
    @discardableResult
    public func ce_addPassesViewControllerDidFinish(handle: @escaping (PKAddPassesViewController) -> Void) -> Self {
        ce._addPassesViewControllerDidFinish = handle
        rebindingDelegate()
        return self
    }
    
}

internal class PKAddPassesViewController_Delegate: UIViewController_Delegate, PKAddPassesViewControllerDelegate {
    
    var _addPassesViewControllerDidFinish: ((PKAddPassesViewController) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(addPassesViewControllerDidFinish(_:)) : _addPassesViewControllerDidFinish,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func addPassesViewControllerDidFinish(_ controller: PKAddPassesViewController) {
        _addPassesViewControllerDidFinish!(controller)
    }
}
