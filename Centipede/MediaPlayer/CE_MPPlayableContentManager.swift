//
//  CE_MPPlayableContentManager.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import MediaPlayer

public extension MPPlayableContentManager {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: MPPlayableContentManager_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? MPPlayableContentManager_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: MPPlayableContentManager_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is MPPlayableContentManager_Delegate {
                return obj as! MPPlayableContentManager_Delegate
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
        self.dataSource = nil
        self.dataSource = delegate
    }
    
    internal func getDelegateInstance() -> MPPlayableContentManager_Delegate {
        return MPPlayableContentManager_Delegate()
    }
    
    public func ce_beginLoadingChildItems_at(handle: ((IndexPath, @escaping (Error?) -> Void) -> Void)) -> Self {
        ce._beginLoadingChildItems_at = handle
        rebindingDelegate()
        return self
    }
    public func ce_childItemsDisplayPlaybackProgress_at(handle: ((IndexPath) -> Bool)) -> Self {
        ce._childItemsDisplayPlaybackProgress_at = handle
        rebindingDelegate()
        return self
    }
    public func ce_numberOfChildItems_at(handle: ((IndexPath) -> Int)) -> Self {
        ce._numberOfChildItems_at = handle
        rebindingDelegate()
        return self
    }
    public func ce_contentItem_at(handle: ((IndexPath) -> MPContentItem?)) -> Self {
        ce._contentItem_at = handle
        rebindingDelegate()
        return self
    }
    public func ce_playableContentManager_initiatePlaybackOfContentItemAt(handle: ((MPPlayableContentManager, IndexPath, @escaping (Error?) -> Void) -> Void)) -> Self {
        ce._playableContentManager_initiatePlaybackOfContentItemAt = handle
        rebindingDelegate()
        return self
    }
    
}

internal class MPPlayableContentManager_Delegate: NSObject, MPPlayableContentDelegate, MPPlayableContentDataSource {
    
    var _beginLoadingChildItems_at: ((IndexPath, @escaping (Error?) -> Void) -> Void)?
    var _childItemsDisplayPlaybackProgress_at: ((IndexPath) -> Bool)?
    var _numberOfChildItems_at: ((IndexPath) -> Int)?
    var _contentItem_at: ((IndexPath) -> MPContentItem?)?
    var _playableContentManager_initiatePlaybackOfContentItemAt: ((MPPlayableContentManager, IndexPath, @escaping (Error?) -> Void) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(beginLoadingChildItems(at:completionHandler:)) : _beginLoadingChildItems_at,
            #selector(childItemsDisplayPlaybackProgress(at:)) : _childItemsDisplayPlaybackProgress_at,
            #selector(numberOfChildItems(at:)) : _numberOfChildItems_at,
            #selector(contentItem(at:)) : _contentItem_at,
            #selector(playableContentManager(_:initiatePlaybackOfContentItemAt:completionHandler:)) : _playableContentManager_initiatePlaybackOfContentItemAt,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func beginLoadingChildItems(at indexPath: IndexPath, completionHandler: @escaping (Error?) -> Void) {
        _beginLoadingChildItems_at!(indexPath, completionHandler)
    }
    @objc func childItemsDisplayPlaybackProgress(at indexPath: IndexPath) -> Bool {
        return _childItemsDisplayPlaybackProgress_at!(indexPath)
    }
    @objc func numberOfChildItems(at indexPath: IndexPath) -> Int {
        return _numberOfChildItems_at!(indexPath)
    }
    @objc func contentItem(at indexPath: IndexPath) -> MPContentItem? {
        return _contentItem_at!(indexPath)
    }
    @objc func playableContentManager(_ contentManager: MPPlayableContentManager, initiatePlaybackOfContentItemAt indexPath: IndexPath, completionHandler: @escaping (Error?) -> Void) {
        _playableContentManager_initiatePlaybackOfContentItemAt!(contentManager, indexPath, completionHandler)
    }
}
