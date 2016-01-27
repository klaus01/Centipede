//
//  CE_NSFetchedResultsController.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import CoreData

public extension NSFetchedResultsController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NSFetchedResultsController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NSFetchedResultsController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: NSFetchedResultsController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is NSFetchedResultsController_Delegate {
                return obj as! NSFetchedResultsController_Delegate
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
    
    internal func getDelegateInstance() -> NSFetchedResultsController_Delegate {
        return NSFetchedResultsController_Delegate()
    }
    
    public func ce_controller(handle: (controller: NSFetchedResultsController, anObject: AnyObject, indexPath: NSIndexPath?, type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) -> Void) -> Self {
        ce._controller = handle
        rebindingDelegate()
        return self
    }
    public func ce_controllerAndDidChangeSection(handle: (controller: NSFetchedResultsController, sectionInfo: NSFetchedResultsSectionInfo, sectionIndex: Int, type: NSFetchedResultsChangeType) -> Void) -> Self {
        ce._controllerAndDidChangeSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_controllerWillChangeContent(handle: (controller: NSFetchedResultsController) -> Void) -> Self {
        ce._controllerWillChangeContent = handle
        rebindingDelegate()
        return self
    }
    public func ce_controllerDidChangeContent(handle: (controller: NSFetchedResultsController) -> Void) -> Self {
        ce._controllerDidChangeContent = handle
        rebindingDelegate()
        return self
    }
    public func ce_controllerAndSectionIndexTitleForSectionName(handle: (controller: NSFetchedResultsController, sectionName: String) -> String?) -> Self {
        ce._controllerAndSectionIndexTitleForSectionName = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSFetchedResultsController_Delegate: NSObject, NSFetchedResultsControllerDelegate {
    
    var _controller: ((NSFetchedResultsController, AnyObject, NSIndexPath?, NSFetchedResultsChangeType, NSIndexPath?) -> Void)?
    var _controllerAndDidChangeSection: ((NSFetchedResultsController, NSFetchedResultsSectionInfo, Int, NSFetchedResultsChangeType) -> Void)?
    var _controllerWillChangeContent: ((NSFetchedResultsController) -> Void)?
    var _controllerDidChangeContent: ((NSFetchedResultsController) -> Void)?
    var _controllerAndSectionIndexTitleForSectionName: ((NSFetchedResultsController, String) -> String?)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "controller:didChangeObject:atIndexPath:forChangeType:newIndexPath:" : _controller,
            "controller:didChangeSection:atIndex:forChangeType:" : _controllerAndDidChangeSection,
            "controllerWillChangeContent:" : _controllerWillChangeContent,
            "controllerDidChangeContent:" : _controllerDidChangeContent,
            "controller:sectionIndexTitleForSectionName:" : _controllerAndSectionIndexTitleForSectionName,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        _controller!(controller, anObject, indexPath, type, newIndexPath)
    }
    @objc func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        _controllerAndDidChangeSection!(controller, sectionInfo, sectionIndex, type)
    }
    @objc func controllerWillChangeContent(controller: NSFetchedResultsController) {
        _controllerWillChangeContent!(controller)
    }
    @objc func controllerDidChangeContent(controller: NSFetchedResultsController) {
        _controllerDidChangeContent!(controller)
    }
    @objc func controller(controller: NSFetchedResultsController, sectionIndexTitleForSectionName sectionName: String) -> String? {
        return _controllerAndSectionIndexTitleForSectionName!(controller, sectionName)
    }
}
