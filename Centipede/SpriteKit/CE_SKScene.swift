//
//  CE_SKScene.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
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
    
    public func ce_update(handle: (currentTime: NSTimeInterval, scene: SKScene) -> Void) -> Self {
        ce._update = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEvaluateActionsFor(handle: (scene: SKScene) -> Void) -> Self {
        ce._didEvaluateActionsFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_didSimulatePhysicsFor(handle: (scene: SKScene) -> Void) -> Self {
        ce._didSimulatePhysicsFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_didApplyConstraintsFor(handle: (scene: SKScene) -> Void) -> Self {
        ce._didApplyConstraintsFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFinishUpdateFor(handle: (scene: SKScene) -> Void) -> Self {
        ce._didFinishUpdateFor = handle
        rebindingDelegate()
        return self
    }
    
}

internal class SKScene_Delegate: NSObject, SKSceneDelegate {
    
    var _update: ((NSTimeInterval, SKScene) -> Void)?
    var _didEvaluateActionsFor: ((SKScene) -> Void)?
    var _didSimulatePhysicsFor: ((SKScene) -> Void)?
    var _didApplyConstraintsFor: ((SKScene) -> Void)?
    var _didFinishUpdateFor: ((SKScene) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(update(_:forScene:)) : _update,
            #selector(didEvaluateActionsForScene(_:)) : _didEvaluateActionsFor,
            #selector(didSimulatePhysicsForScene(_:)) : _didSimulatePhysicsFor,
            #selector(didApplyConstraintsForScene(_:)) : _didApplyConstraintsFor,
            #selector(didFinishUpdateForScene(_:)) : _didFinishUpdateFor,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func update(currentTime: NSTimeInterval, forScene scene: SKScene) {
        _update!(currentTime, scene)
    }
    @objc func didEvaluateActionsForScene(scene: SKScene) {
        _didEvaluateActionsFor!(scene)
    }
    @objc func didSimulatePhysicsForScene(scene: SKScene) {
        _didSimulatePhysicsFor!(scene)
    }
    @objc func didApplyConstraintsForScene(scene: SKScene) {
        _didApplyConstraintsFor!(scene)
    }
    @objc func didFinishUpdateForScene(scene: SKScene) {
        _didFinishUpdateFor!(scene)
    }
}
