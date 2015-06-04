//
//  CE_UICollectionView.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    private var ce: UICollectionView_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UICollectionView_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UICollectionView_Delegate {
                return delegate as! UICollectionView_Delegate
            }
        }
        let delegate = getDelegateInstance()
        objc_setAssociatedObject(self, &Static.AssociationKey, delegate, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        return delegate
    }
    
    private func rebindingDelegate() {
        let delegate = ce
        self.delegate = nil
        self.delegate = delegate
        self.dataSource = nil
        self.dataSource = delegate
    }
    
    internal override func getDelegateInstance() -> UICollectionView_Delegate {
        return UICollectionView_Delegate()
    }
    
    public func ce_numberOfItemsInSection(handle: (collectionView: UICollectionView, section: Int) -> Int) -> Self {
        ce._numberOfItemsInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_cellForItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> UICollectionViewCell) -> Self {
        ce._cellForItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_numberOfSectionsIn(handle: (collectionView: UICollectionView) -> Int) -> Self {
        ce._numberOfSectionsIn = handle
        rebindingDelegate()
        return self
    }
    public func ce_viewForSupplementaryElementOfKind(handle: (collectionView: UICollectionView, kind: String, indexPath: NSIndexPath) -> UICollectionReusableView) -> Self {
        ce._viewForSupplementaryElementOfKind = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldHighlightItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce._shouldHighlightItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_didHighlightItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> Void) -> Self {
        ce._didHighlightItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUnhighlightItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> Void) -> Self {
        ce._didUnhighlightItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldSelectItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce._shouldSelectItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldDeselectItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce._shouldDeselectItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_didSelectItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> Void) -> Self {
        ce._didSelectItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDeselectItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> Void) -> Self {
        ce._didDeselectItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_willDisplayCell(handle: (collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: NSIndexPath) -> Void) -> Self {
        ce._willDisplayCell = handle
        rebindingDelegate()
        return self
    }
    public func ce_willDisplaySupplementaryView(handle: (collectionView: UICollectionView, view: UICollectionReusableView, elementKind: String, indexPath: NSIndexPath) -> Void) -> Self {
        ce._willDisplaySupplementaryView = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndDisplayingCell(handle: (collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: NSIndexPath) -> Void) -> Self {
        ce._didEndDisplayingCell = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndDisplayingSupplementaryView(handle: (collectionView: UICollectionView, view: UICollectionReusableView, elementKind: String, indexPath: NSIndexPath) -> Void) -> Self {
        ce._didEndDisplayingSupplementaryView = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldShowMenuForItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce._shouldShowMenuForItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_canPerformAction(handle: (collectionView: UICollectionView, action: Selector, indexPath: NSIndexPath, sender: AnyObject!) -> Bool) -> Self {
        ce._canPerformAction = handle
        rebindingDelegate()
        return self
    }
    public func ce_performAction(handle: (collectionView: UICollectionView, action: Selector, indexPath: NSIndexPath, sender: AnyObject!) -> Void) -> Self {
        ce._performAction = handle
        rebindingDelegate()
        return self
    }
    public func ce_transitionLayoutForOldLayout(handle: (collectionView: UICollectionView, fromLayout: UICollectionViewLayout, toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout!) -> Self {
        ce._transitionLayoutForOldLayout = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutSizeForItemAtIndexPath(handle: (collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, indexPath: NSIndexPath) -> CGSize) -> Self {
        ce._layoutSizeForItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutInsetForSectionAtIndex(handle: (collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, section: Int) -> UIEdgeInsets) -> Self {
        ce._layoutInsetForSectionAtIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutMinimumLineSpacingForSectionAtIndex(handle: (collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, section: Int) -> CGFloat) -> Self {
        ce._layoutMinimumLineSpacingForSectionAtIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutMinimumInteritemSpacingForSectionAtIndex(handle: (collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, section: Int) -> CGFloat) -> Self {
        ce._layoutMinimumInteritemSpacingForSectionAtIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutReferenceSizeForHeaderInSection(handle: (collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, section: Int) -> CGSize) -> Self {
        ce._layoutReferenceSizeForHeaderInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutReferenceSizeForFooterInSection(handle: (collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, section: Int) -> CGSize) -> Self {
        ce._layoutReferenceSizeForFooterInSection = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UICollectionView_Delegate: UIScrollView_Delegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var _numberOfItemsInSection: ((UICollectionView, Int) -> Int)?
    var _cellForItemAtIndexPath: ((UICollectionView, NSIndexPath) -> UICollectionViewCell)?
    var _numberOfSectionsIn: ((UICollectionView) -> Int)?
    var _viewForSupplementaryElementOfKind: ((UICollectionView, String, NSIndexPath) -> UICollectionReusableView)?
    var _shouldHighlightItemAtIndexPath: ((UICollectionView, NSIndexPath) -> Bool)?
    var _didHighlightItemAtIndexPath: ((UICollectionView, NSIndexPath) -> Void)?
    var _didUnhighlightItemAtIndexPath: ((UICollectionView, NSIndexPath) -> Void)?
    var _shouldSelectItemAtIndexPath: ((UICollectionView, NSIndexPath) -> Bool)?
    var _shouldDeselectItemAtIndexPath: ((UICollectionView, NSIndexPath) -> Bool)?
    var _didSelectItemAtIndexPath: ((UICollectionView, NSIndexPath) -> Void)?
    var _didDeselectItemAtIndexPath: ((UICollectionView, NSIndexPath) -> Void)?
    var _willDisplayCell: ((UICollectionView, UICollectionViewCell, NSIndexPath) -> Void)?
    var _willDisplaySupplementaryView: ((UICollectionView, UICollectionReusableView, String, NSIndexPath) -> Void)?
    var _didEndDisplayingCell: ((UICollectionView, UICollectionViewCell, NSIndexPath) -> Void)?
    var _didEndDisplayingSupplementaryView: ((UICollectionView, UICollectionReusableView, String, NSIndexPath) -> Void)?
    var _shouldShowMenuForItemAtIndexPath: ((UICollectionView, NSIndexPath) -> Bool)?
    var _canPerformAction: ((UICollectionView, Selector, NSIndexPath, AnyObject!) -> Bool)?
    var _performAction: ((UICollectionView, Selector, NSIndexPath, AnyObject!) -> Void)?
    var _transitionLayoutForOldLayout: ((UICollectionView, UICollectionViewLayout, UICollectionViewLayout) -> UICollectionViewTransitionLayout!)?
    var _layoutSizeForItemAtIndexPath: ((UICollectionView, UICollectionViewLayout, NSIndexPath) -> CGSize)?
    var _layoutInsetForSectionAtIndex: ((UICollectionView, UICollectionViewLayout, Int) -> UIEdgeInsets)?
    var _layoutMinimumLineSpacingForSectionAtIndex: ((UICollectionView, UICollectionViewLayout, Int) -> CGFloat)?
    var _layoutMinimumInteritemSpacingForSectionAtIndex: ((UICollectionView, UICollectionViewLayout, Int) -> CGFloat)?
    var _layoutReferenceSizeForHeaderInSection: ((UICollectionView, UICollectionViewLayout, Int) -> CGSize)?
    var _layoutReferenceSizeForFooterInSection: ((UICollectionView, UICollectionViewLayout, Int) -> CGSize)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "collectionView:numberOfItemsInSection:" : _numberOfItemsInSection,
            "collectionView:cellForItemAtIndexPath:" : _cellForItemAtIndexPath,
            "numberOfSectionsInCollectionView:" : _numberOfSectionsIn,
            "collectionView:viewForSupplementaryElementOfKind:atIndexPath:" : _viewForSupplementaryElementOfKind,
            "collectionView:shouldHighlightItemAtIndexPath:" : _shouldHighlightItemAtIndexPath,
            "collectionView:didHighlightItemAtIndexPath:" : _didHighlightItemAtIndexPath,
            "collectionView:didUnhighlightItemAtIndexPath:" : _didUnhighlightItemAtIndexPath,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "collectionView:shouldSelectItemAtIndexPath:" : _shouldSelectItemAtIndexPath,
            "collectionView:shouldDeselectItemAtIndexPath:" : _shouldDeselectItemAtIndexPath,
            "collectionView:didSelectItemAtIndexPath:" : _didSelectItemAtIndexPath,
            "collectionView:didDeselectItemAtIndexPath:" : _didDeselectItemAtIndexPath,
            "collectionView:willDisplayCell:forItemAtIndexPath:" : _willDisplayCell,
            "collectionView:willDisplaySupplementaryView:forElementKind:atIndexPath:" : _willDisplaySupplementaryView,
            "collectionView:didEndDisplayingCell:forItemAtIndexPath:" : _didEndDisplayingCell,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        let funcDic3: [Selector : Any?] = [
            "collectionView:didEndDisplayingSupplementaryView:forElementOfKind:atIndexPath:" : _didEndDisplayingSupplementaryView,
            "collectionView:shouldShowMenuForItemAtIndexPath:" : _shouldShowMenuForItemAtIndexPath,
            "collectionView:canPerformAction:forItemAtIndexPath:withSender:" : _canPerformAction,
            "collectionView:performAction:forItemAtIndexPath:withSender:" : _performAction,
            "collectionView:transitionLayoutForOldLayout:newLayout:" : _transitionLayoutForOldLayout,
            "collectionView:layout:sizeForItemAtIndexPath:" : _layoutSizeForItemAtIndexPath,
            "collectionView:layout:insetForSectionAtIndex:" : _layoutInsetForSectionAtIndex,
        ]
        if let f = funcDic3[aSelector] {
            return f != nil
        }
        
        let funcDic4: [Selector : Any?] = [
            "collectionView:layout:minimumLineSpacingForSectionAtIndex:" : _layoutMinimumLineSpacingForSectionAtIndex,
            "collectionView:layout:minimumInteritemSpacingForSectionAtIndex:" : _layoutMinimumInteritemSpacingForSectionAtIndex,
            "collectionView:layout:referenceSizeForHeaderInSection:" : _layoutReferenceSizeForHeaderInSection,
            "collectionView:layout:referenceSizeForFooterInSection:" : _layoutReferenceSizeForFooterInSection,
        ]
        if let f = funcDic4[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _numberOfItemsInSection!(collectionView, section)
    }
    @objc func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return _cellForItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return _numberOfSectionsIn!(collectionView)
    }
    @objc func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        return _viewForSupplementaryElementOfKind!(collectionView, kind, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return _shouldHighlightItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        _didHighlightItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        _didUnhighlightItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return _shouldSelectItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return _shouldDeselectItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        _didSelectItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        _didDeselectItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        _willDisplayCell!(collectionView, cell, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, atIndexPath indexPath: NSIndexPath) {
        _willDisplaySupplementaryView!(collectionView, view, elementKind, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        _didEndDisplayingCell!(collectionView, cell, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, atIndexPath indexPath: NSIndexPath) {
        _didEndDisplayingSupplementaryView!(collectionView, view, elementKind, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return _shouldShowMenuForItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!) -> Bool {
        return _canPerformAction!(collectionView, action, indexPath, sender)
    }
    @objc func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!) {
        _performAction!(collectionView, action, indexPath, sender)
    }
    @objc func collectionView(collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout! {
        return _transitionLayoutForOldLayout!(collectionView, fromLayout, toLayout)
    }
    @objc func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return _layoutSizeForItemAtIndexPath!(collectionView, collectionViewLayout, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return _layoutInsetForSectionAtIndex!(collectionView, collectionViewLayout, section)
    }
    @objc func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return _layoutMinimumLineSpacingForSectionAtIndex!(collectionView, collectionViewLayout, section)
    }
    @objc func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return _layoutMinimumInteritemSpacingForSectionAtIndex!(collectionView, collectionViewLayout, section)
    }
    @objc func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return _layoutReferenceSizeForHeaderInSection!(collectionView, collectionViewLayout, section)
    }
    @objc func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return _layoutReferenceSizeForFooterInSection!(collectionView, collectionViewLayout, section)
    }
}
