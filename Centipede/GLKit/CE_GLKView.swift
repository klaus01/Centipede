//
//  CE_GLKView.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import GLKit

public extension GLKView {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: GLKView_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? GLKView_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
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
    
    public func ce_g(handle: ((GLKView, CGRect) -> Void)) -> Self {
        ce._g = handle
        rebindingDelegate()
        return self
    }
    
}

internal class GLKView_Delegate: NSObject, GLKViewDelegate {
    
    var _g: ((GLKView, CGRect) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(glkView(_:drawIn:)) : _g,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func glkView(_ view: GLKView, drawIn rect: CGRect) {
        _g!(view, rect)
    }
}
