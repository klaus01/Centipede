//
//  CE_SKScene.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
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
    
    public func ce_update(handle: ((TimeInterval, SKScene) -> Void)) -> Self {
        ce._update = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEvaluateActions(handle: ((SKScene) -> Void)) -> Self {
        ce._didEvaluateActions = handle
        rebindingDelegate()
        return self
    }
    public func ce_didSimulatePhysics(handle: ((SKScene) -> Void)) -> Self {
        ce._didSimulatePhysics = handle
        rebindingDelegate()
        return self
    }
    public func ce_didApplyConstraints(handle: ((SKScene) -> Void)) -> Self {
        ce._didApplyConstraints = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFinishUpdate(handle: ((SKScene) -> Void)) -> Self {
        ce._didFinishUpdate = handle
        rebindingDelegate()
        return self
    }
    
}

internal class SKScene_Delegate: NSObject, SKSceneDelegate {
    
    var _update: ((TimeInterval, SKScene) -> Void)?
    var _didEvaluateActions: ((SKScene) -> Void)?
    var _didSimulatePhysics: ((SKScene) -> Void)?
    var _didApplyConstraints: ((SKScene) -> Void)?
    var _didFinishUpdate: ((SKScene) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(update(_:for:)) : _update,
            #selector(didEvaluateActions(for:)) : _didEvaluateActions,
            #selector(didSimulatePhysics(for:)) : _didSimulatePhysics,
            #selector(didApplyConstraints(for:)) : _didApplyConstraints,
            #selector(didFinishUpdate(for:)) : _didFinishUpdate,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func update(_ currentTime: TimeInterval, for scene: SKScene) {
        _update!(currentTime, scene)
    }
    @objc func didEvaluateActions(for scene: SKScene) {
        _didEvaluateActions!(scene)
    }
    @objc func didSimulatePhysics(for scene: SKScene) {
        _didSimulatePhysics!(scene)
    }
    @objc func didApplyConstraints(for scene: SKScene) {
        _didApplyConstraints!(scene)
    }
    @objc func didFinishUpdate(for scene: SKScene) {
        _didFinishUpdate!(scene)
    }
}
