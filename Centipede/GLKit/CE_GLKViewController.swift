//
//  CE_GLKViewController.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import GLKit

public extension GLKViewController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: GLKViewController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? GLKViewController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: GLKViewController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is GLKViewController_Delegate {
                return obj as! GLKViewController_Delegate
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
    
    internal override func getDelegateInstance() -> GLKViewController_Delegate {
        return GLKViewController_Delegate()
    }
    
    public func ce_glkViewControllerUpdate(handle: ((GLKViewController) -> Void)) -> Self {
        ce._glkViewControllerUpdate = handle
        rebindingDelegate()
        return self
    }
    public func ce_glkViewController_willPause(handle: ((GLKViewController, Bool) -> Void)) -> Self {
        ce._glkViewController_willPause = handle
        rebindingDelegate()
        return self
    }
    
}

internal class GLKViewController_Delegate: UIViewController_Delegate, GLKViewControllerDelegate {
    
    var _glkViewControllerUpdate: ((GLKViewController) -> Void)?
    var _glkViewController_willPause: ((GLKViewController, Bool) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(glkViewControllerUpdate(_:)) : _glkViewControllerUpdate,
            #selector(glkViewController(_:willPause:)) : _glkViewController_willPause,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func glkViewControllerUpdate(_ controller: GLKViewController) {
        _glkViewControllerUpdate!(controller)
    }
    @objc func glkViewController(_ controller: GLKViewController, willPause pause: Bool) {
        _glkViewController_willPause!(controller, pause)
    }
}
