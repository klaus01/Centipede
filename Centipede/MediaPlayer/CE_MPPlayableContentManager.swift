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
    
    public func ce_beginLoadingChildItems(handle: ((IndexPath, @escaping (Error?) -> Void) -> Void)) -> Self {
        ce._beginLoadingChildItems = handle
        rebindingDelegate()
        return self
    }
    public func ce_childItemsDisplayPlaybackProgress(handle: ((IndexPath) -> Bool)) -> Self {
        ce._childItemsDisplayPlaybackProgress = handle
        rebindingDelegate()
        return self
    }
    public func ce_numberOfChildItems(handle: ((IndexPath) -> Int)) -> Self {
        ce._numberOfChildItems = handle
        rebindingDelegate()
        return self
    }
    public func ce_contentItem(handle: ((IndexPath) -> MPContentItem?)) -> Self {
        ce._contentItem = handle
        rebindingDelegate()
        return self
    }
    public func ce_playableContentManager(handle: ((MPPlayableContentManager, IndexPath, @escaping (Error?) -> Void) -> Void)) -> Self {
        ce._playableContentManager = handle
        rebindingDelegate()
        return self
    }
    
}

internal class MPPlayableContentManager_Delegate: NSObject, MPPlayableContentDelegate, MPPlayableContentDataSource {
    
    var _beginLoadingChildItems: ((IndexPath, @escaping (Error?) -> Void) -> Void)?
    var _childItemsDisplayPlaybackProgress: ((IndexPath) -> Bool)?
    var _numberOfChildItems: ((IndexPath) -> Int)?
    var _contentItem: ((IndexPath) -> MPContentItem?)?
    var _playableContentManager: ((MPPlayableContentManager, IndexPath, @escaping (Error?) -> Void) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(beginLoadingChildItems(at:completionHandler:)) : _beginLoadingChildItems,
            #selector(childItemsDisplayPlaybackProgress(at:)) : _childItemsDisplayPlaybackProgress,
            #selector(numberOfChildItems(at:)) : _numberOfChildItems,
            #selector(contentItem(at:)) : _contentItem,
            #selector(playableContentManager(_:initiatePlaybackOfContentItemAt:completionHandler:)) : _playableContentManager,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func beginLoadingChildItems(at indexPath: IndexPath, completionHandler: @escaping (Error?) -> Void) {
        _beginLoadingChildItems!(indexPath, completionHandler)
    }
    @objc func childItemsDisplayPlaybackProgress(at indexPath: IndexPath) -> Bool {
        return _childItemsDisplayPlaybackProgress!(indexPath)
    }
    @objc func numberOfChildItems(at indexPath: IndexPath) -> Int {
        return _numberOfChildItems!(indexPath)
    }
    @objc func contentItem(at indexPath: IndexPath) -> MPContentItem? {
        return _contentItem!(indexPath)
    }
    @objc func playableContentManager(_ contentManager: MPPlayableContentManager, initiatePlaybackOfContentItemAt indexPath: IndexPath, completionHandler: @escaping (Error?) -> Void) {
        _playableContentManager!(contentManager, indexPath, completionHandler)
    }
}
