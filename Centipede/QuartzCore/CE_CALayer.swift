//
//  CE_CALayer.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import QuartzCore

public extension CALayer {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: CALayer_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? CALayer_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: CALayer_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is CALayer_Delegate {
                return obj as! CALayer_Delegate
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
    
    internal func getDelegateInstance() -> CALayer_Delegate {
        return CALayer_Delegate()
    }
    
    public func ce_display(handle: ((CALayer) -> Void)) -> Self {
        ce._display = handle
        rebindingDelegate()
        return self
    }
    public func ce_draw_in(handle: ((CALayer, CGContext) -> Void)) -> Self {
        ce._draw_in = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutSublayers_of(handle: ((CALayer) -> Void)) -> Self {
        ce._layoutSublayers_of = handle
        rebindingDelegate()
        return self
    }
    public func ce_action_for(handle: ((CALayer, String) -> CAAction?)) -> Self {
        ce._action_for = handle
        rebindingDelegate()
        return self
    }
    
}

internal class CALayer_Delegate: NSObject, CALayerDelegate {
    
    var _display: ((CALayer) -> Void)?
    var _draw_in: ((CALayer, CGContext) -> Void)?
    var _layoutSublayers_of: ((CALayer) -> Void)?
    var _action_for: ((CALayer, String) -> CAAction?)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(display(_:)) : _display,
            #selector(draw(_:in:)) : _draw_in,
            #selector(layoutSublayers(of:)) : _layoutSublayers_of,
            #selector(action(for:forKey:)) : _action_for,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func display(_ layer: CALayer) {
        _display!(layer)
    }
    @objc func draw(_ layer: CALayer, in ctx: CGContext) {
        _draw_in!(layer, ctx)
    }
    @objc func layoutSublayers(of layer: CALayer) {
        _layoutSublayers_of!(layer)
    }
    @objc func action(for layer: CALayer, forKey event: String) -> CAAction? {
        return _action_for!(layer, event)
    }
}
