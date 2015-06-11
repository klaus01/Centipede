//
//  CE_GLKViewController.swift
//  Centipede
//
//  Created by kelei on 2015/6/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import GLKit

public extension GLKViewController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: GLKViewController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? GLKViewController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: GLKViewController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
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
    
    public func ce_glUpdate(handle: (controller: GLKViewController) -> Void) -> Self {
        ce._glUpdate = handle
        rebindingDelegate()
        return self
    }
    public func ce_gl(handle: (controller: GLKViewController, pause: Bool) -> Void) -> Self {
        ce._gl = handle
        rebindingDelegate()
        return self
    }
    
}

internal class GLKViewController_Delegate: UIViewController_Delegate, GLKViewControllerDelegate {
    
    var _glUpdate: ((GLKViewController) -> Void)?
    var _gl: ((GLKViewController, Bool) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "glkViewControllerUpdate:" : _glUpdate,
            "glkViewController:willPause:" : _gl,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func glkViewControllerUpdate(controller: GLKViewController) {
        _glUpdate!(controller)
    }
    @objc func glkViewController(controller: GLKViewController, willPause pause: Bool) {
        _gl!(controller, pause)
    }
}
