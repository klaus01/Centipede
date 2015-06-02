//
//  CE_UITableView.swift
//  Centipede
//
//  Created by kelei on 15/4/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UITableView {
    
    private var ce: UITableView_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UITableView_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UITableView_Delegate {
                return delegate as! UITableView_Delegate
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
    
    internal override func getDelegateInstance() -> UITableView_Delegate {
        return UITableView_Delegate()
    }
    
    public func ce_NumberOfRowsInSection(handle: (tableView: UITableView, section: Int) -> Int) -> Self {
        ce.NumberOfRowsInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_CellForRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell) -> Self {
        ce.CellForRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_NumberOfSectionsIn(handle: (tableView: UITableView) -> Int) -> Self {
        ce.NumberOfSectionsIn = handle
        rebindingDelegate()
        return self
    }
    public func ce_TitleForHeaderInSection(handle: (tableView: UITableView, section: Int) -> String?) -> Self {
        ce.TitleForHeaderInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_TitleForFooterInSection(handle: (tableView: UITableView, section: Int) -> String?) -> Self {
        ce.TitleForFooterInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_CanEditRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce.CanEditRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_CanMoveRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce.CanMoveRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_SectionIndexTitlesFor(handle: (tableView: UITableView) -> [AnyObject]!) -> Self {
        ce.SectionIndexTitlesFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_SectionForSectionIndexTitle(handle: (tableView: UITableView, title: String, index: Int) -> Int) -> Self {
        ce.SectionForSectionIndexTitle = handle
        rebindingDelegate()
        return self
    }
    public func ce_CommitEditingStyle(handle: (tableView: UITableView, editingStyle: UITableViewCellEditingStyle, indexPath: NSIndexPath) -> Void) -> Self {
        ce.CommitEditingStyle = handle
        rebindingDelegate()
        return self
    }
    public func ce_MoveRowAtIndexPath(handle: (tableView: UITableView, sourceIndexPath: NSIndexPath, destinationIndexPath: NSIndexPath) -> Void) -> Self {
        ce.MoveRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillDisplayCell(handle: (tableView: UITableView, cell: UITableViewCell, indexPath: NSIndexPath) -> Void) -> Self {
        ce.WillDisplayCell = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillDisplayHeaderView(handle: (tableView: UITableView, view: UIView, section: Int) -> Void) -> Self {
        ce.WillDisplayHeaderView = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillDisplayFooterView(handle: (tableView: UITableView, view: UIView, section: Int) -> Void) -> Self {
        ce.WillDisplayFooterView = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndDisplayingCell(handle: (tableView: UITableView, cell: UITableViewCell, indexPath: NSIndexPath) -> Void) -> Self {
        ce.DidEndDisplayingCell = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndDisplayingHeaderView(handle: (tableView: UITableView, view: UIView, section: Int) -> Void) -> Self {
        ce.DidEndDisplayingHeaderView = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndDisplayingFooterView(handle: (tableView: UITableView, view: UIView, section: Int) -> Void) -> Self {
        ce.DidEndDisplayingFooterView = handle
        rebindingDelegate()
        return self
    }
    public func ce_HeightForRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> CGFloat) -> Self {
        ce.HeightForRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_HeightForHeaderInSection(handle: (tableView: UITableView, section: Int) -> CGFloat) -> Self {
        ce.HeightForHeaderInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_HeightForFooterInSection(handle: (tableView: UITableView, section: Int) -> CGFloat) -> Self {
        ce.HeightForFooterInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_EstimatedHeightForRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> CGFloat) -> Self {
        ce.EstimatedHeightForRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_EstimatedHeightForHeaderInSection(handle: (tableView: UITableView, section: Int) -> CGFloat) -> Self {
        ce.EstimatedHeightForHeaderInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_EstimatedHeightForFooterInSection(handle: (tableView: UITableView, section: Int) -> CGFloat) -> Self {
        ce.EstimatedHeightForFooterInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_ViewForHeaderInSection(handle: (tableView: UITableView, section: Int) -> UIView?) -> Self {
        ce.ViewForHeaderInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_ViewForFooterInSection(handle: (tableView: UITableView, section: Int) -> UIView?) -> Self {
        ce.ViewForFooterInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_AccessoryButtonTappedForRowWithIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Void) -> Self {
        ce.AccessoryButtonTappedForRowWithIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldHighlightRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce.ShouldHighlightRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidHighlightRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Void) -> Self {
        ce.DidHighlightRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidUnhighlightRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Void) -> Self {
        ce.DidUnhighlightRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillSelectRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> NSIndexPath?) -> Self {
        ce.WillSelectRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillDeselectRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> NSIndexPath?) -> Self {
        ce.WillDeselectRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidSelectRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Void) -> Self {
        ce.DidSelectRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidDeselectRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Void) -> Self {
        ce.DidDeselectRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_EditingStyleForRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCellEditingStyle) -> Self {
        ce.EditingStyleForRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_TitleForDeleteConfirmationButtonForRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> String!) -> Self {
        ce.TitleForDeleteConfirmationButtonForRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_EditActionsForRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> [AnyObject]?) -> Self {
        ce.EditActionsForRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldIndentWhileEditingRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce.ShouldIndentWhileEditingRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillBeginEditingRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Void) -> Self {
        ce.WillBeginEditingRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndEditingRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Void) -> Self {
        ce.DidEndEditingRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_TargetIndexPathForMoveFromRowAtIndexPath(handle: (tableView: UITableView, sourceIndexPath: NSIndexPath, proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath) -> Self {
        ce.TargetIndexPathForMoveFromRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_IndentationLevelForRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Int) -> Self {
        ce.IndentationLevelForRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldShowMenuForRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce.ShouldShowMenuForRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_CanPerformAction(handle: (tableView: UITableView, action: Selector, indexPath: NSIndexPath, sender: AnyObject) -> Bool) -> Self {
        ce.CanPerformAction = handle
        rebindingDelegate()
        return self
    }
    public func ce_PerformAction(handle: (tableView: UITableView, action: Selector, indexPath: NSIndexPath, sender: AnyObject!) -> Void) -> Self {
        ce.PerformAction = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UITableView_Delegate: UIScrollView_Delegate, UITableViewDataSource, UITableViewDelegate {
    
    var NumberOfRowsInSection: ((UITableView, Int) -> Int)?
    var CellForRowAtIndexPath: ((UITableView, NSIndexPath) -> UITableViewCell)?
    var NumberOfSectionsIn: ((UITableView) -> Int)?
    var TitleForHeaderInSection: ((UITableView, Int) -> String?)?
    var TitleForFooterInSection: ((UITableView, Int) -> String?)?
    var CanEditRowAtIndexPath: ((UITableView, NSIndexPath) -> Bool)?
    var CanMoveRowAtIndexPath: ((UITableView, NSIndexPath) -> Bool)?
    var SectionIndexTitlesFor: ((UITableView) -> [AnyObject]!)?
    var SectionForSectionIndexTitle: ((UITableView, String, Int) -> Int)?
    var CommitEditingStyle: ((UITableView, UITableViewCellEditingStyle, NSIndexPath) -> Void)?
    var MoveRowAtIndexPath: ((UITableView, NSIndexPath, NSIndexPath) -> Void)?
    var WillDisplayCell: ((UITableView, UITableViewCell, NSIndexPath) -> Void)?
    var WillDisplayHeaderView: ((UITableView, UIView, Int) -> Void)?
    var WillDisplayFooterView: ((UITableView, UIView, Int) -> Void)?
    var DidEndDisplayingCell: ((UITableView, UITableViewCell, NSIndexPath) -> Void)?
    var DidEndDisplayingHeaderView: ((UITableView, UIView, Int) -> Void)?
    var DidEndDisplayingFooterView: ((UITableView, UIView, Int) -> Void)?
    var HeightForRowAtIndexPath: ((UITableView, NSIndexPath) -> CGFloat)?
    var HeightForHeaderInSection: ((UITableView, Int) -> CGFloat)?
    var HeightForFooterInSection: ((UITableView, Int) -> CGFloat)?
    var EstimatedHeightForRowAtIndexPath: ((UITableView, NSIndexPath) -> CGFloat)?
    var EstimatedHeightForHeaderInSection: ((UITableView, Int) -> CGFloat)?
    var EstimatedHeightForFooterInSection: ((UITableView, Int) -> CGFloat)?
    var ViewForHeaderInSection: ((UITableView, Int) -> UIView?)?
    var ViewForFooterInSection: ((UITableView, Int) -> UIView?)?
    var AccessoryButtonTappedForRowWithIndexPath: ((UITableView, NSIndexPath) -> Void)?
    var ShouldHighlightRowAtIndexPath: ((UITableView, NSIndexPath) -> Bool)?
    var DidHighlightRowAtIndexPath: ((UITableView, NSIndexPath) -> Void)?
    var DidUnhighlightRowAtIndexPath: ((UITableView, NSIndexPath) -> Void)?
    var WillSelectRowAtIndexPath: ((UITableView, NSIndexPath) -> NSIndexPath?)?
    var WillDeselectRowAtIndexPath: ((UITableView, NSIndexPath) -> NSIndexPath?)?
    var DidSelectRowAtIndexPath: ((UITableView, NSIndexPath) -> Void)?
    var DidDeselectRowAtIndexPath: ((UITableView, NSIndexPath) -> Void)?
    var EditingStyleForRowAtIndexPath: ((UITableView, NSIndexPath) -> UITableViewCellEditingStyle)?
    var TitleForDeleteConfirmationButtonForRowAtIndexPath: ((UITableView, NSIndexPath) -> String!)?
    var EditActionsForRowAtIndexPath: ((UITableView, NSIndexPath) -> [AnyObject]?)?
    var ShouldIndentWhileEditingRowAtIndexPath: ((UITableView, NSIndexPath) -> Bool)?
    var WillBeginEditingRowAtIndexPath: ((UITableView, NSIndexPath) -> Void)?
    var DidEndEditingRowAtIndexPath: ((UITableView, NSIndexPath) -> Void)?
    var TargetIndexPathForMoveFromRowAtIndexPath: ((UITableView, NSIndexPath, NSIndexPath) -> NSIndexPath)?
    var IndentationLevelForRowAtIndexPath: ((UITableView, NSIndexPath) -> Int)?
    var ShouldShowMenuForRowAtIndexPath: ((UITableView, NSIndexPath) -> Bool)?
    var CanPerformAction: ((UITableView, Selector, NSIndexPath, AnyObject) -> Bool)?
    var PerformAction: ((UITableView, Selector, NSIndexPath, AnyObject!) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "tableView:numberOfRowsInSection:" : NumberOfRowsInSection,
            "tableView:cellForRowAtIndexPath:" : CellForRowAtIndexPath,
            "numberOfSectionsInTableView:" : NumberOfSectionsIn,
            "tableView:titleForHeaderInSection:" : TitleForHeaderInSection,
            "tableView:titleForFooterInSection:" : TitleForFooterInSection,
            "tableView:canEditRowAtIndexPath:" : CanEditRowAtIndexPath,
            "tableView:canMoveRowAtIndexPath:" : CanMoveRowAtIndexPath,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "sectionIndexTitlesForTableView:" : SectionIndexTitlesFor,
            "tableView:sectionForSectionIndexTitle:atIndex:" : SectionForSectionIndexTitle,
            "tableView:commitEditingStyle:forRowAtIndexPath:" : CommitEditingStyle,
            "tableView:moveRowAtIndexPath:toIndexPath:" : MoveRowAtIndexPath,
            "tableView:willDisplayCell:forRowAtIndexPath:" : WillDisplayCell,
            "tableView:willDisplayHeaderView:forSection:" : WillDisplayHeaderView,
            "tableView:willDisplayFooterView:forSection:" : WillDisplayFooterView,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        let funcDic3: [Selector : Any?] = [
            "tableView:didEndDisplayingCell:forRowAtIndexPath:" : DidEndDisplayingCell,
            "tableView:didEndDisplayingHeaderView:forSection:" : DidEndDisplayingHeaderView,
            "tableView:didEndDisplayingFooterView:forSection:" : DidEndDisplayingFooterView,
            "tableView:heightForRowAtIndexPath:" : HeightForRowAtIndexPath,
            "tableView:heightForHeaderInSection:" : HeightForHeaderInSection,
            "tableView:heightForFooterInSection:" : HeightForFooterInSection,
            "tableView:estimatedHeightForRowAtIndexPath:" : EstimatedHeightForRowAtIndexPath,
        ]
        if let f = funcDic3[aSelector] {
            return f != nil
        }
        
        let funcDic4: [Selector : Any?] = [
            "tableView:estimatedHeightForHeaderInSection:" : EstimatedHeightForHeaderInSection,
            "tableView:estimatedHeightForFooterInSection:" : EstimatedHeightForFooterInSection,
            "tableView:viewForHeaderInSection:" : ViewForHeaderInSection,
            "tableView:viewForFooterInSection:" : ViewForFooterInSection,
            "tableView:accessoryButtonTappedForRowWithIndexPath:" : AccessoryButtonTappedForRowWithIndexPath,
            "tableView:shouldHighlightRowAtIndexPath:" : ShouldHighlightRowAtIndexPath,
            "tableView:didHighlightRowAtIndexPath:" : DidHighlightRowAtIndexPath,
        ]
        if let f = funcDic4[aSelector] {
            return f != nil
        }
        
        let funcDic5: [Selector : Any?] = [
            "tableView:didUnhighlightRowAtIndexPath:" : DidUnhighlightRowAtIndexPath,
            "tableView:willSelectRowAtIndexPath:" : WillSelectRowAtIndexPath,
            "tableView:willDeselectRowAtIndexPath:" : WillDeselectRowAtIndexPath,
            "tableView:didSelectRowAtIndexPath:" : DidSelectRowAtIndexPath,
            "tableView:didDeselectRowAtIndexPath:" : DidDeselectRowAtIndexPath,
            "tableView:editingStyleForRowAtIndexPath:" : EditingStyleForRowAtIndexPath,
            "tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:" : TitleForDeleteConfirmationButtonForRowAtIndexPath,
        ]
        if let f = funcDic5[aSelector] {
            return f != nil
        }
        
        let funcDic6: [Selector : Any?] = [
            "tableView:editActionsForRowAtIndexPath:" : EditActionsForRowAtIndexPath,
            "tableView:shouldIndentWhileEditingRowAtIndexPath:" : ShouldIndentWhileEditingRowAtIndexPath,
            "tableView:willBeginEditingRowAtIndexPath:" : WillBeginEditingRowAtIndexPath,
            "tableView:didEndEditingRowAtIndexPath:" : DidEndEditingRowAtIndexPath,
            "tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:" : TargetIndexPathForMoveFromRowAtIndexPath,
            "tableView:indentationLevelForRowAtIndexPath:" : IndentationLevelForRowAtIndexPath,
            "tableView:shouldShowMenuForRowAtIndexPath:" : ShouldShowMenuForRowAtIndexPath,
        ]
        if let f = funcDic6[aSelector] {
            return f != nil
        }
        
        let funcDic7: [Selector : Any?] = [
            "tableView:canPerformAction:forRowAtIndexPath:withSender:" : CanPerformAction,
            "tableView:performAction:forRowAtIndexPath:withSender:" : PerformAction,
        ]
        if let f = funcDic7[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NumberOfRowsInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return CellForRowAtIndexPath!(tableView, indexPath)
    }
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return NumberOfSectionsIn!(tableView)
    }
    @objc func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TitleForHeaderInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return TitleForFooterInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return CanEditRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return CanMoveRowAtIndexPath!(tableView, indexPath)
    }
    @objc func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        return SectionIndexTitlesFor!(tableView)
    }
    @objc func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return SectionForSectionIndexTitle!(tableView, title, index)
    }
    @objc func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        CommitEditingStyle!(tableView, editingStyle, indexPath)
    }
    @objc func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        MoveRowAtIndexPath!(tableView, sourceIndexPath, destinationIndexPath)
    }
    @objc func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        WillDisplayCell!(tableView, cell, indexPath)
    }
    @objc func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        WillDisplayHeaderView!(tableView, view, section)
    }
    @objc func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        WillDisplayFooterView!(tableView, view, section)
    }
    @objc func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        DidEndDisplayingCell!(tableView, cell, indexPath)
    }
    @objc func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        DidEndDisplayingHeaderView!(tableView, view, section)
    }
    @objc func tableView(tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        DidEndDisplayingFooterView!(tableView, view, section)
    }
    @objc func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return HeightForRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HeightForHeaderInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return HeightForFooterInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return EstimatedHeightForRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return EstimatedHeightForHeaderInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return EstimatedHeightForFooterInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ViewForHeaderInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return ViewForFooterInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        AccessoryButtonTappedForRowWithIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return ShouldHighlightRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        DidHighlightRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        DidUnhighlightRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return WillSelectRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return WillDeselectRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        DidSelectRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        DidDeselectRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return EditingStyleForRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        return TitleForDeleteConfirmationButtonForRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        return EditActionsForRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return ShouldIndentWhileEditingRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath) {
        WillBeginEditingRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {
        DidEndEditingRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        return TargetIndexPathForMoveFromRowAtIndexPath!(tableView, sourceIndexPath, proposedDestinationIndexPath)
    }
    @objc func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        return IndentationLevelForRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return ShouldShowMenuForRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject) -> Bool {
        return CanPerformAction!(tableView, action, indexPath, sender)
    }
    @objc func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!) {
        PerformAction!(tableView, action, indexPath, sender)
    }
}