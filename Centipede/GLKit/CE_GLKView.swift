//
//  CE_GLKView.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import GLKit

public extension GLKView {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: GLKView_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? GLKView_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: GLKView_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is GLKView_Delegate {
                return obj as! GLKView_Delegate
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
    
    internal func getDelegateInstance() -> GLKView_Delegate {
        return GLKView_Delegate()
    }
    
    public func ce_gl(handle: (view: GLKView, rect: CGRect) -> Void) -> Self {
        ce._gl = handle
        rebindingDelegate()
        return self
    }
    
}

internal class GLKView_Delegate: NSObject, GLKViewDelegate {
    
    var _gl: ((GLKView, CGRect) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "glkView:drawInRect:" : _gl,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func glkView(view: GLKView, drawInRect rect: CGRect) {
        _gl!(view, rect)
    }
}
