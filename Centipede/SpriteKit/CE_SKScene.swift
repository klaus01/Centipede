//
//  CE_SKScene.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import SpriteKit

public extension SKScene {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: SKScene_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? SKScene_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: SKScene_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is SKScene_Delegate {
                return obj as! SKScene_Delegate
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
    
    internal func getDelegateInstance() -> SKScene_Delegate {
        return SKScene_Delegate()
    }
    
    @discardableResult
    public func ce_update_for(handle: @escaping (TimeInterval, SKScene) -> Void) -> Self {
        ce._update_for = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_didEvaluateActions_for(handle: @escaping (SKScene) -> Void) -> Self {
        ce._didEvaluateActions_for = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_didSimulatePhysics_for(handle: @escaping (SKScene) -> Void) -> Self {
        ce._didSimulatePhysics_for = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_didApplyConstraints_for(handle: @escaping (SKScene) -> Void) -> Self {
        ce._didApplyConstraints_for = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_didFinishUpdate_for(handle: @escaping (SKScene) -> Void) -> Self {
        ce._didFinishUpdate_for = handle
        rebindingDelegate()
        return self
    }
    
}

internal class SKScene_Delegate: NSObject, SKSceneDelegate {
    
    var _update_for: ((TimeInterval, SKScene) -> Void)?
    var _didEvaluateActions_for: ((SKScene) -> Void)?
    var _didSimulatePhysics_for: ((SKScene) -> Void)?
    var _didApplyConstraints_for: ((SKScene) -> Void)?
    var _didFinishUpdate_for: ((SKScene) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(update(_:for:)) : _update_for,
            #selector(didEvaluateActions(for:)) : _didEvaluateActions_for,
            #selector(didSimulatePhysics(for:)) : _didSimulatePhysics_for,
            #selector(didApplyConstraints(for:)) : _didApplyConstraints_for,
            #selector(didFinishUpdate(for:)) : _didFinishUpdate_for,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func update(_ currentTime: TimeInterval, for scene: SKScene) {
        _update_for!(currentTime, scene)
    }
    @objc func didEvaluateActions(for scene: SKScene) {
        _didEvaluateActions_for!(scene)
    }
    @objc func didSimulatePhysics(for scene: SKScene) {
        _didSimulatePhysics_for!(scene)
    }
    @objc func didApplyConstraints(for scene: SKScene) {
        _didApplyConstraints_for!(scene)
    }
    @objc func didFinishUpdate(for scene: SKScene) {
        _didFinishUpdate_for!(scene)
    }
}
