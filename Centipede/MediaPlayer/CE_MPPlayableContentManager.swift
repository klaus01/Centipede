//
//  CE_MPPlayableContentManager.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import MediaPlayer

public extension MPPlayableContentManager {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: MPPlayableContentManager_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? MPPlayableContentManager_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
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
    
    public func ce_initiatePlaybackOfContentItemAtIndexPath(handle: (contentManager: MPPlayableContentManager, indexPath: NSIndexPath!, completionHandler: ((NSError!) -> Void)!) -> Void) -> Self {
        ce._initiatePlaybackOfContentItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_beginLoadingChildItemsAtIndexPath(handle: (indexPath: NSIndexPath, completionHandler: ((NSError!) -> Void)!) -> Void) -> Self {
        ce._beginLoadingChildItemsAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_childItemsDisplayPlaybackProgressAtIndexPath(handle: (indexPath: NSIndexPath) -> Bool) -> Self {
        ce._childItemsDisplayPlaybackProgressAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_numberOfChildItemsAtIndexPath(handle: (indexPath: NSIndexPath) -> Int) -> Self {
        ce._numberOfChildItemsAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_contentItemAtIndexPath(handle: (indexPath: NSIndexPath) -> MPContentItem!) -> Self {
        ce._contentItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    
}

internal class MPPlayableContentManager_Delegate: NSObject, MPPlayableContentDelegate, MPPlayableContentDataSource {
    
    var _initiatePlaybackOfContentItemAtIndexPath: ((MPPlayableContentManager, NSIndexPath!, ((NSError!) -> Void)!) -> Void)?
    var _beginLoadingChildItemsAtIndexPath: ((NSIndexPath, ((NSError!) -> Void)!) -> Void)?
    var _childItemsDisplayPlaybackProgressAtIndexPath: ((NSIndexPath) -> Bool)?
    var _numberOfChildItemsAtIndexPath: ((NSIndexPath) -> Int)?
    var _contentItemAtIndexPath: ((NSIndexPath) -> MPContentItem!)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "playableContentManager:initiatePlaybackOfContentItemAtIndexPath:completionHandler:" : _initiatePlaybackOfContentItemAtIndexPath,
            "beginLoadingChildItemsAtIndexPath:completionHandler:" : _beginLoadingChildItemsAtIndexPath,
            "childItemsDisplayPlaybackProgressAtIndexPath:" : _childItemsDisplayPlaybackProgressAtIndexPath,
            "numberOfChildItemsAtIndexPath:" : _numberOfChildItemsAtIndexPath,
            "contentItemAtIndexPath:" : _contentItemAtIndexPath,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func playableContentManager(contentManager: MPPlayableContentManager, initiatePlaybackOfContentItemAtIndexPath indexPath: NSIndexPath!, completionHandler: ((NSError!) -> Void)!) -> Void {
        return _initiatePlaybackOfContentItemAtIndexPath!(contentManager, indexPath, completionHandler)
    }
    @objc func beginLoadingChildItemsAtIndexPath(indexPath: NSIndexPath, completionHandler: ((NSError!) -> Void)!) -> Void {
        return _beginLoadingChildItemsAtIndexPath!(indexPath, completionHandler)
    }
    @objc func childItemsDisplayPlaybackProgressAtIndexPath(indexPath: NSIndexPath) -> Bool {
        return _childItemsDisplayPlaybackProgressAtIndexPath!(indexPath)
    }
    @objc func numberOfChildItemsAtIndexPath(indexPath: NSIndexPath) -> Int {
        return _numberOfChildItemsAtIndexPath!(indexPath)
    }
    @objc func contentItemAtIndexPath(indexPath: NSIndexPath) -> MPContentItem! {
        return _contentItemAtIndexPath!(indexPath)
    }
}
