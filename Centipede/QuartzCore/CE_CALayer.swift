//
//  CE_CALayer.swift
//  Centipede
//
//  Created by kelei on 2015/6/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
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
    
    public func ce_display(handle: (layer: CALayer) -> Void) -> Self {
        ce._display = handle
        rebindingDelegate()
        return self
    }
    public func ce_draw(handle: (layer: CALayer, ctx: CGContext) -> Void) -> Self {
        ce._draw = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutSubsOfLayer(handle: (layer: CALayer) -> Void) -> Self {
        ce._layoutSubsOfLayer = handle
        rebindingDelegate()
        return self
    }
    public func ce_actionFor(handle: (layer: CALayer, event: String) -> CAAction) -> Self {
        ce._actionFor = handle
        rebindingDelegate()
        return self
    }
    
}

internal class CALayer_Delegate: NSObject {
    
    var _display: ((CALayer) -> Void)?
    var _draw: ((CALayer, CGContext) -> Void)?
    var _layoutSubsOfLayer: ((CALayer) -> Void)?
    var _actionFor: ((CALayer, String) -> CAAction)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(displayLayer(_:)) : _display,
            #selector(drawLayer(_:inContext:)) : _draw,
            #selector(layoutSublayersOfLayer(_:)) : _layoutSubsOfLayer,
            #selector(actionForLayer(_:forKey:)) : _actionFor,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc override func displayLayer(layer: CALayer) {
        super.displayLayer(layer)
        _display!(layer)
    }
    @objc override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        super.drawLayer(layer, inContext: ctx)
        _draw!(layer, ctx)
    }
    @objc override func layoutSublayersOfLayer(layer: CALayer) {
        super.layoutSublayersOfLayer(layer)
        _layoutSubsOfLayer!(layer)
    }
    @objc override func actionForLayer(layer: CALayer, forKey event: String) -> CAAction {
        super.actionForLayer(layer, forKey: event)
        return _actionFor!(layer, event)
    }
}
