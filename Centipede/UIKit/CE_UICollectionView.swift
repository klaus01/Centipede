//
//  UICollectionView+CE.swift
//  Centipede
//
//  Created by kelei on 15/4/8.
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
    
    public func ce_NumberOfItemsInSection(handle: (collectionView: UICollectionView, section: Int) -> Int) -> Self {
        ce.NumberOfItemsInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_CellForItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> UICollectionViewCell) -> Self {
        ce.CellForItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_NumberOfSectionsIn(handle: (collectionView: UICollectionView) -> Int) -> Self {
        ce.NumberOfSectionsIn = handle
        rebindingDelegate()
        return self
    }
    public func ce_ViewForSupplementaryElementOfKind(handle: (collectionView: UICollectionView, kind: String, indexPath: NSIndexPath) -> UICollectionReusableView) -> Self {
        ce.ViewForSupplementaryElementOfKind = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldHighlightItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce.ShouldHighlightItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidHighlightItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> Void) -> Self {
        ce.DidHighlightItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidUnhighlightItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> Void) -> Self {
        ce.DidUnhighlightItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldSelectItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce.ShouldSelectItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldDeselectItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce.ShouldDeselectItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidSelectItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> Void) -> Self {
        ce.DidSelectItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidDeselectItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> Void) -> Self {
        ce.DidDeselectItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillDisplayCell(handle: (collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: NSIndexPath) -> Void) -> Self {
        ce.WillDisplayCell = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillDisplaySupplementaryView(handle: (collectionView: UICollectionView, view: UICollectionReusableView, elementKind: String, indexPath: NSIndexPath) -> Void) -> Self {
        ce.WillDisplaySupplementaryView = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndDisplayingCell(handle: (collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: NSIndexPath) -> Void) -> Self {
        ce.DidEndDisplayingCell = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndDisplayingSupplementaryView(handle: (collectionView: UICollectionView, view: UICollectionReusableView, elementKind: String, indexPath: NSIndexPath) -> Void) -> Self {
        ce.DidEndDisplayingSupplementaryView = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldShowMenuForItemAtIndexPath(handle: (collectionView: UICollectionView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce.ShouldShowMenuForItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_CanPerformAction(handle: (collectionView: UICollectionView, action: Selector, indexPath: NSIndexPath, sender: AnyObject!) -> Bool) -> Self {
        ce.CanPerformAction = handle
        rebindingDelegate()
        return self
    }
    public func ce_PerformAction(handle: (collectionView: UICollectionView, action: Selector, indexPath: NSIndexPath, sender: AnyObject!) -> Void) -> Self {
        ce.PerformAction = handle
        rebindingDelegate()
        return self
    }
    public func ce_TransitionLayoutForOldLayout(handle: (collectionView: UICollectionView, fromLayout: UICollectionViewLayout, toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout!) -> Self {
        ce.TransitionLayoutForOldLayout = handle
        rebindingDelegate()
        return self
    }
    public func ce_LayoutSizeForItemAtIndexPath(handle: (collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, indexPath: NSIndexPath) -> CGSize) -> Self {
        ce.LayoutSizeForItemAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_LayoutInsetForSectionAtIndex(handle: (collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, section: Int) -> UIEdgeInsets) -> Self {
        ce.LayoutInsetForSectionAtIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_LayoutMinimumLineSpacingForSectionAtIndex(handle: (collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, section: Int) -> CGFloat) -> Self {
        ce.LayoutMinimumLineSpacingForSectionAtIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_LayoutMinimumInteritemSpacingForSectionAtIndex(handle: (collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, section: Int) -> CGFloat) -> Self {
        ce.LayoutMinimumInteritemSpacingForSectionAtIndex = handle
        rebindingDelegate()
        return self
    }
    public func ce_LayoutReferenceSizeForHeaderInSection(handle: (collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, section: Int) -> CGSize) -> Self {
        ce.LayoutReferenceSizeForHeaderInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_LayoutReferenceSizeForFooterInSection(handle: (collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, section: Int) -> CGSize) -> Self {
        ce.LayoutReferenceSizeForFooterInSection = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UICollectionView_Delegate: UIScrollView_Delegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var NumberOfItemsInSection: ((UICollectionView, Int) -> Int)?
    var CellForItemAtIndexPath: ((UICollectionView, NSIndexPath) -> UICollectionViewCell)?
    var NumberOfSectionsIn: ((UICollectionView) -> Int)?
    var ViewForSupplementaryElementOfKind: ((UICollectionView, String, NSIndexPath) -> UICollectionReusableView)?
    var ShouldHighlightItemAtIndexPath: ((UICollectionView, NSIndexPath) -> Bool)?
    var DidHighlightItemAtIndexPath: ((UICollectionView, NSIndexPath) -> Void)?
    var DidUnhighlightItemAtIndexPath: ((UICollectionView, NSIndexPath) -> Void)?
    var ShouldSelectItemAtIndexPath: ((UICollectionView, NSIndexPath) -> Bool)?
    var ShouldDeselectItemAtIndexPath: ((UICollectionView, NSIndexPath) -> Bool)?
    var DidSelectItemAtIndexPath: ((UICollectionView, NSIndexPath) -> Void)?
    var DidDeselectItemAtIndexPath: ((UICollectionView, NSIndexPath) -> Void)?
    var WillDisplayCell: ((UICollectionView, UICollectionViewCell, NSIndexPath) -> Void)?
    var WillDisplaySupplementaryView: ((UICollectionView, UICollectionReusableView, String, NSIndexPath) -> Void)?
    var DidEndDisplayingCell: ((UICollectionView, UICollectionViewCell, NSIndexPath) -> Void)?
    var DidEndDisplayingSupplementaryView: ((UICollectionView, UICollectionReusableView, String, NSIndexPath) -> Void)?
    var ShouldShowMenuForItemAtIndexPath: ((UICollectionView, NSIndexPath) -> Bool)?
    var CanPerformAction: ((UICollectionView, Selector, NSIndexPath, AnyObject!) -> Bool)?
    var PerformAction: ((UICollectionView, Selector, NSIndexPath, AnyObject!) -> Void)?
    var TransitionLayoutForOldLayout: ((UICollectionView, UICollectionViewLayout, UICollectionViewLayout) -> UICollectionViewTransitionLayout!)?
    var LayoutSizeForItemAtIndexPath: ((UICollectionView, UICollectionViewLayout, NSIndexPath) -> CGSize)?
    var LayoutInsetForSectionAtIndex: ((UICollectionView, UICollectionViewLayout, Int) -> UIEdgeInsets)?
    var LayoutMinimumLineSpacingForSectionAtIndex: ((UICollectionView, UICollectionViewLayout, Int) -> CGFloat)?
    var LayoutMinimumInteritemSpacingForSectionAtIndex: ((UICollectionView, UICollectionViewLayout, Int) -> CGFloat)?
    var LayoutReferenceSizeForHeaderInSection: ((UICollectionView, UICollectionViewLayout, Int) -> CGSize)?
    var LayoutReferenceSizeForFooterInSection: ((UICollectionView, UICollectionViewLayout, Int) -> CGSize)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "collectionView:numberOfItemsInSection:" : NumberOfItemsInSection,
            "collectionView:cellForItemAtIndexPath:" : CellForItemAtIndexPath,
            "numberOfSectionsInCollectionView:" : NumberOfSectionsIn,
            "collectionView:viewForSupplementaryElementOfKind:atIndexPath:" : ViewForSupplementaryElementOfKind,
            "collectionView:shouldHighlightItemAtIndexPath:" : ShouldHighlightItemAtIndexPath,
            "collectionView:didHighlightItemAtIndexPath:" : DidHighlightItemAtIndexPath,
            "collectionView:didUnhighlightItemAtIndexPath:" : DidUnhighlightItemAtIndexPath,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "collectionView:shouldSelectItemAtIndexPath:" : ShouldSelectItemAtIndexPath,
            "collectionView:shouldDeselectItemAtIndexPath:" : ShouldDeselectItemAtIndexPath,
            "collectionView:didSelectItemAtIndexPath:" : DidSelectItemAtIndexPath,
            "collectionView:didDeselectItemAtIndexPath:" : DidDeselectItemAtIndexPath,
            "collectionView:willDisplayCell:forItemAtIndexPath:" : WillDisplayCell,
            "collectionView:willDisplaySupplementaryView:forElementKind:atIndexPath:" : WillDisplaySupplementaryView,
            "collectionView:didEndDisplayingCell:forItemAtIndexPath:" : DidEndDisplayingCell,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        let funcDic3: [Selector : Any?] = [
            "collectionView:didEndDisplayingSupplementaryView:forElementOfKind:atIndexPath:" : DidEndDisplayingSupplementaryView,
            "collectionView:shouldShowMenuForItemAtIndexPath:" : ShouldShowMenuForItemAtIndexPath,
            "collectionView:canPerformAction:forItemAtIndexPath:withSender:" : CanPerformAction,
            "collectionView:performAction:forItemAtIndexPath:withSender:" : PerformAction,
            "collectionView:transitionLayoutForOldLayout:newLayout:" : TransitionLayoutForOldLayout,
            "collectionView:layout:sizeForItemAtIndexPath:" : LayoutSizeForItemAtIndexPath,
            "collectionView:layout:insetForSectionAtIndex:" : LayoutInsetForSectionAtIndex,
        ]
        if let f = funcDic3[aSelector] {
            return f != nil
        }
        
        let funcDic4: [Selector : Any?] = [
            "collectionView:layout:minimumLineSpacingForSectionAtIndex:" : LayoutMinimumLineSpacingForSectionAtIndex,
            "collectionView:layout:minimumInteritemSpacingForSectionAtIndex:" : LayoutMinimumInteritemSpacingForSectionAtIndex,
            "collectionView:layout:referenceSizeForHeaderInSection:" : LayoutReferenceSizeForHeaderInSection,
            "collectionView:layout:referenceSizeForFooterInSection:" : LayoutReferenceSizeForFooterInSection,
        ]
        if let f = funcDic4[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NumberOfItemsInSection!(collectionView, section)
    }
    @objc func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return CellForItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return NumberOfSectionsIn!(collectionView)
    }
    @objc func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        return ViewForSupplementaryElementOfKind!(collectionView, kind, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return ShouldHighlightItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        DidHighlightItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        DidUnhighlightItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return ShouldSelectItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return ShouldDeselectItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        DidSelectItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        DidDeselectItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        WillDisplayCell!(collectionView, cell, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, atIndexPath indexPath: NSIndexPath) {
        WillDisplaySupplementaryView!(collectionView, view, elementKind, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        DidEndDisplayingCell!(collectionView, cell, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, atIndexPath indexPath: NSIndexPath) {
        DidEndDisplayingSupplementaryView!(collectionView, view, elementKind, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return ShouldShowMenuForItemAtIndexPath!(collectionView, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!) -> Bool {
        return CanPerformAction!(collectionView, action, indexPath, sender)
    }
    @objc func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!) {
        PerformAction!(collectionView, action, indexPath, sender)
    }
    @objc func collectionView(collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout! {
        return TransitionLayoutForOldLayout!(collectionView, fromLayout, toLayout)
    }
    @objc func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return LayoutSizeForItemAtIndexPath!(collectionView, collectionViewLayout, indexPath)
    }
    @objc func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return LayoutInsetForSectionAtIndex!(collectionView, collectionViewLayout, section)
    }
    @objc func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return LayoutMinimumLineSpacingForSectionAtIndex!(collectionView, collectionViewLayout, section)
    }
    @objc func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return LayoutMinimumInteritemSpacingForSectionAtIndex!(collectionView, collectionViewLayout, section)
    }
    @objc func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return LayoutReferenceSizeForHeaderInSection!(collectionView, collectionViewLayout, section)
    }
    @objc func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return LayoutReferenceSizeForFooterInSection!(collectionView, collectionViewLayout, section)
    }
}