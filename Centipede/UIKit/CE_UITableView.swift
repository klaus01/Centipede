//
//  CE_UITableView.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
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
    
    public func ce_numberOfRowsInSection(handle: (tableView: UITableView, section: Int) -> Int) -> Self {
        ce._numberOfRowsInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_cellForRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell) -> Self {
        ce._cellForRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_numberOfSectionsIn(handle: (tableView: UITableView) -> Int) -> Self {
        ce._numberOfSectionsIn = handle
        rebindingDelegate()
        return self
    }
    public func ce_titleForHeaderInSection(handle: (tableView: UITableView, section: Int) -> String?) -> Self {
        ce._titleForHeaderInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_titleForFooterInSection(handle: (tableView: UITableView, section: Int) -> String?) -> Self {
        ce._titleForFooterInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_canEditRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce._canEditRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_canMoveRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce._canMoveRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_sectionIndexTitlesFor(handle: (tableView: UITableView) -> [AnyObject]!) -> Self {
        ce._sectionIndexTitlesFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_sectionForSectionIndexTitle(handle: (tableView: UITableView, title: String, index: Int) -> Int) -> Self {
        ce._sectionForSectionIndexTitle = handle
        rebindingDelegate()
        return self
    }
    public func ce_commitEditingStyle(handle: (tableView: UITableView, editingStyle: UITableViewCellEditingStyle, indexPath: NSIndexPath) -> Void) -> Self {
        ce._commitEditingStyle = handle
        rebindingDelegate()
        return self
    }
    public func ce_moveRowAtIndexPath(handle: (tableView: UITableView, sourceIndexPath: NSIndexPath, destinationIndexPath: NSIndexPath) -> Void) -> Self {
        ce._moveRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_willDisplayCell(handle: (tableView: UITableView, cell: UITableViewCell, indexPath: NSIndexPath) -> Void) -> Self {
        ce._willDisplayCell = handle
        rebindingDelegate()
        return self
    }
    public func ce_willDisplayHeaderView(handle: (tableView: UITableView, view: UIView, section: Int) -> Void) -> Self {
        ce._willDisplayHeaderView = handle
        rebindingDelegate()
        return self
    }
    public func ce_willDisplayFooterView(handle: (tableView: UITableView, view: UIView, section: Int) -> Void) -> Self {
        ce._willDisplayFooterView = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndDisplayingCell(handle: (tableView: UITableView, cell: UITableViewCell, indexPath: NSIndexPath) -> Void) -> Self {
        ce._didEndDisplayingCell = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndDisplayingHeaderView(handle: (tableView: UITableView, view: UIView, section: Int) -> Void) -> Self {
        ce._didEndDisplayingHeaderView = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndDisplayingFooterView(handle: (tableView: UITableView, view: UIView, section: Int) -> Void) -> Self {
        ce._didEndDisplayingFooterView = handle
        rebindingDelegate()
        return self
    }
    public func ce_heightForRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> CGFloat) -> Self {
        ce._heightForRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_heightForHeaderInSection(handle: (tableView: UITableView, section: Int) -> CGFloat) -> Self {
        ce._heightForHeaderInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_heightForFooterInSection(handle: (tableView: UITableView, section: Int) -> CGFloat) -> Self {
        ce._heightForFooterInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_estimatedHeightForRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> CGFloat) -> Self {
        ce._estimatedHeightForRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_estimatedHeightForHeaderInSection(handle: (tableView: UITableView, section: Int) -> CGFloat) -> Self {
        ce._estimatedHeightForHeaderInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_estimatedHeightForFooterInSection(handle: (tableView: UITableView, section: Int) -> CGFloat) -> Self {
        ce._estimatedHeightForFooterInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_viewForHeaderInSection(handle: (tableView: UITableView, section: Int) -> UIView?) -> Self {
        ce._viewForHeaderInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_viewForFooterInSection(handle: (tableView: UITableView, section: Int) -> UIView?) -> Self {
        ce._viewForFooterInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_accessoryButtonTappedForRowWithIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Void) -> Self {
        ce._accessoryButtonTappedForRowWithIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldHighlightRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce._shouldHighlightRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_didHighlightRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Void) -> Self {
        ce._didHighlightRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_didUnhighlightRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Void) -> Self {
        ce._didUnhighlightRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_willSelectRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> NSIndexPath?) -> Self {
        ce._willSelectRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_willDeselectRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> NSIndexPath?) -> Self {
        ce._willDeselectRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_didSelectRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Void) -> Self {
        ce._didSelectRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDeselectRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Void) -> Self {
        ce._didDeselectRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_editingStyleForRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCellEditingStyle) -> Self {
        ce._editingStyleForRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_titleForDeleteConfirmationButtonForRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> String!) -> Self {
        ce._titleForDeleteConfirmationButtonForRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_editActionsForRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> [AnyObject]?) -> Self {
        ce._editActionsForRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldIndentWhileEditingRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce._shouldIndentWhileEditingRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_willBeginEditingRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Void) -> Self {
        ce._willBeginEditingRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndEditingRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Void) -> Self {
        ce._didEndEditingRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_targetIndexPathForMoveFromRowAtIndexPath(handle: (tableView: UITableView, sourceIndexPath: NSIndexPath, proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath) -> Self {
        ce._targetIndexPathForMoveFromRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_indentationLevelForRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Int) -> Self {
        ce._indentationLevelForRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldShowMenuForRowAtIndexPath(handle: (tableView: UITableView, indexPath: NSIndexPath) -> Bool) -> Self {
        ce._shouldShowMenuForRowAtIndexPath = handle
        rebindingDelegate()
        return self
    }
    public func ce_canPerformAction(handle: (tableView: UITableView, action: Selector, indexPath: NSIndexPath, sender: AnyObject) -> Bool) -> Self {
        ce._canPerformAction = handle
        rebindingDelegate()
        return self
    }
    public func ce_performAction(handle: (tableView: UITableView, action: Selector, indexPath: NSIndexPath, sender: AnyObject!) -> Void) -> Self {
        ce._performAction = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UITableView_Delegate: UIScrollView_Delegate, UITableViewDataSource, UITableViewDelegate {
    
    var _numberOfRowsInSection: ((UITableView, Int) -> Int)?
    var _cellForRowAtIndexPath: ((UITableView, NSIndexPath) -> UITableViewCell)?
    var _numberOfSectionsIn: ((UITableView) -> Int)?
    var _titleForHeaderInSection: ((UITableView, Int) -> String?)?
    var _titleForFooterInSection: ((UITableView, Int) -> String?)?
    var _canEditRowAtIndexPath: ((UITableView, NSIndexPath) -> Bool)?
    var _canMoveRowAtIndexPath: ((UITableView, NSIndexPath) -> Bool)?
    var _sectionIndexTitlesFor: ((UITableView) -> [AnyObject]!)?
    var _sectionForSectionIndexTitle: ((UITableView, String, Int) -> Int)?
    var _commitEditingStyle: ((UITableView, UITableViewCellEditingStyle, NSIndexPath) -> Void)?
    var _moveRowAtIndexPath: ((UITableView, NSIndexPath, NSIndexPath) -> Void)?
    var _willDisplayCell: ((UITableView, UITableViewCell, NSIndexPath) -> Void)?
    var _willDisplayHeaderView: ((UITableView, UIView, Int) -> Void)?
    var _willDisplayFooterView: ((UITableView, UIView, Int) -> Void)?
    var _didEndDisplayingCell: ((UITableView, UITableViewCell, NSIndexPath) -> Void)?
    var _didEndDisplayingHeaderView: ((UITableView, UIView, Int) -> Void)?
    var _didEndDisplayingFooterView: ((UITableView, UIView, Int) -> Void)?
    var _heightForRowAtIndexPath: ((UITableView, NSIndexPath) -> CGFloat)?
    var _heightForHeaderInSection: ((UITableView, Int) -> CGFloat)?
    var _heightForFooterInSection: ((UITableView, Int) -> CGFloat)?
    var _estimatedHeightForRowAtIndexPath: ((UITableView, NSIndexPath) -> CGFloat)?
    var _estimatedHeightForHeaderInSection: ((UITableView, Int) -> CGFloat)?
    var _estimatedHeightForFooterInSection: ((UITableView, Int) -> CGFloat)?
    var _viewForHeaderInSection: ((UITableView, Int) -> UIView?)?
    var _viewForFooterInSection: ((UITableView, Int) -> UIView?)?
    var _accessoryButtonTappedForRowWithIndexPath: ((UITableView, NSIndexPath) -> Void)?
    var _shouldHighlightRowAtIndexPath: ((UITableView, NSIndexPath) -> Bool)?
    var _didHighlightRowAtIndexPath: ((UITableView, NSIndexPath) -> Void)?
    var _didUnhighlightRowAtIndexPath: ((UITableView, NSIndexPath) -> Void)?
    var _willSelectRowAtIndexPath: ((UITableView, NSIndexPath) -> NSIndexPath?)?
    var _willDeselectRowAtIndexPath: ((UITableView, NSIndexPath) -> NSIndexPath?)?
    var _didSelectRowAtIndexPath: ((UITableView, NSIndexPath) -> Void)?
    var _didDeselectRowAtIndexPath: ((UITableView, NSIndexPath) -> Void)?
    var _editingStyleForRowAtIndexPath: ((UITableView, NSIndexPath) -> UITableViewCellEditingStyle)?
    var _titleForDeleteConfirmationButtonForRowAtIndexPath: ((UITableView, NSIndexPath) -> String!)?
    var _editActionsForRowAtIndexPath: ((UITableView, NSIndexPath) -> [AnyObject]?)?
    var _shouldIndentWhileEditingRowAtIndexPath: ((UITableView, NSIndexPath) -> Bool)?
    var _willBeginEditingRowAtIndexPath: ((UITableView, NSIndexPath) -> Void)?
    var _didEndEditingRowAtIndexPath: ((UITableView, NSIndexPath) -> Void)?
    var _targetIndexPathForMoveFromRowAtIndexPath: ((UITableView, NSIndexPath, NSIndexPath) -> NSIndexPath)?
    var _indentationLevelForRowAtIndexPath: ((UITableView, NSIndexPath) -> Int)?
    var _shouldShowMenuForRowAtIndexPath: ((UITableView, NSIndexPath) -> Bool)?
    var _canPerformAction: ((UITableView, Selector, NSIndexPath, AnyObject) -> Bool)?
    var _performAction: ((UITableView, Selector, NSIndexPath, AnyObject!) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "tableView:numberOfRowsInSection:" : _numberOfRowsInSection,
            "tableView:cellForRowAtIndexPath:" : _cellForRowAtIndexPath,
            "numberOfSectionsInTableView:" : _numberOfSectionsIn,
            "tableView:titleForHeaderInSection:" : _titleForHeaderInSection,
            "tableView:titleForFooterInSection:" : _titleForFooterInSection,
            "tableView:canEditRowAtIndexPath:" : _canEditRowAtIndexPath,
            "tableView:canMoveRowAtIndexPath:" : _canMoveRowAtIndexPath,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "sectionIndexTitlesForTableView:" : _sectionIndexTitlesFor,
            "tableView:sectionForSectionIndexTitle:atIndex:" : _sectionForSectionIndexTitle,
            "tableView:commitEditingStyle:forRowAtIndexPath:" : _commitEditingStyle,
            "tableView:moveRowAtIndexPath:toIndexPath:" : _moveRowAtIndexPath,
            "tableView:willDisplayCell:forRowAtIndexPath:" : _willDisplayCell,
            "tableView:willDisplayHeaderView:forSection:" : _willDisplayHeaderView,
            "tableView:willDisplayFooterView:forSection:" : _willDisplayFooterView,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        let funcDic3: [Selector : Any?] = [
            "tableView:didEndDisplayingCell:forRowAtIndexPath:" : _didEndDisplayingCell,
            "tableView:didEndDisplayingHeaderView:forSection:" : _didEndDisplayingHeaderView,
            "tableView:didEndDisplayingFooterView:forSection:" : _didEndDisplayingFooterView,
            "tableView:heightForRowAtIndexPath:" : _heightForRowAtIndexPath,
            "tableView:heightForHeaderInSection:" : _heightForHeaderInSection,
            "tableView:heightForFooterInSection:" : _heightForFooterInSection,
            "tableView:estimatedHeightForRowAtIndexPath:" : _estimatedHeightForRowAtIndexPath,
        ]
        if let f = funcDic3[aSelector] {
            return f != nil
        }
        
        let funcDic4: [Selector : Any?] = [
            "tableView:estimatedHeightForHeaderInSection:" : _estimatedHeightForHeaderInSection,
            "tableView:estimatedHeightForFooterInSection:" : _estimatedHeightForFooterInSection,
            "tableView:viewForHeaderInSection:" : _viewForHeaderInSection,
            "tableView:viewForFooterInSection:" : _viewForFooterInSection,
            "tableView:accessoryButtonTappedForRowWithIndexPath:" : _accessoryButtonTappedForRowWithIndexPath,
            "tableView:shouldHighlightRowAtIndexPath:" : _shouldHighlightRowAtIndexPath,
            "tableView:didHighlightRowAtIndexPath:" : _didHighlightRowAtIndexPath,
        ]
        if let f = funcDic4[aSelector] {
            return f != nil
        }
        
        let funcDic5: [Selector : Any?] = [
            "tableView:didUnhighlightRowAtIndexPath:" : _didUnhighlightRowAtIndexPath,
            "tableView:willSelectRowAtIndexPath:" : _willSelectRowAtIndexPath,
            "tableView:willDeselectRowAtIndexPath:" : _willDeselectRowAtIndexPath,
            "tableView:didSelectRowAtIndexPath:" : _didSelectRowAtIndexPath,
            "tableView:didDeselectRowAtIndexPath:" : _didDeselectRowAtIndexPath,
            "tableView:editingStyleForRowAtIndexPath:" : _editingStyleForRowAtIndexPath,
            "tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:" : _titleForDeleteConfirmationButtonForRowAtIndexPath,
        ]
        if let f = funcDic5[aSelector] {
            return f != nil
        }
        
        let funcDic6: [Selector : Any?] = [
            "tableView:editActionsForRowAtIndexPath:" : _editActionsForRowAtIndexPath,
            "tableView:shouldIndentWhileEditingRowAtIndexPath:" : _shouldIndentWhileEditingRowAtIndexPath,
            "tableView:willBeginEditingRowAtIndexPath:" : _willBeginEditingRowAtIndexPath,
            "tableView:didEndEditingRowAtIndexPath:" : _didEndEditingRowAtIndexPath,
            "tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:" : _targetIndexPathForMoveFromRowAtIndexPath,
            "tableView:indentationLevelForRowAtIndexPath:" : _indentationLevelForRowAtIndexPath,
            "tableView:shouldShowMenuForRowAtIndexPath:" : _shouldShowMenuForRowAtIndexPath,
        ]
        if let f = funcDic6[aSelector] {
            return f != nil
        }
        
        let funcDic7: [Selector : Any?] = [
            "tableView:canPerformAction:forRowAtIndexPath:withSender:" : _canPerformAction,
            "tableView:performAction:forRowAtIndexPath:withSender:" : _performAction,
        ]
        if let f = funcDic7[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _numberOfRowsInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return _cellForRowAtIndexPath!(tableView, indexPath)
    }
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return _numberOfSectionsIn!(tableView)
    }
    @objc func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return _titleForHeaderInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return _titleForFooterInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return _canEditRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return _canMoveRowAtIndexPath!(tableView, indexPath)
    }
    @objc func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        return _sectionIndexTitlesFor!(tableView)
    }
    @objc func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return _sectionForSectionIndexTitle!(tableView, title, index)
    }
    @objc func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        _commitEditingStyle!(tableView, editingStyle, indexPath)
    }
    @objc func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        _moveRowAtIndexPath!(tableView, sourceIndexPath, destinationIndexPath)
    }
    @objc func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        _willDisplayCell!(tableView, cell, indexPath)
    }
    @objc func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        _willDisplayHeaderView!(tableView, view, section)
    }
    @objc func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        _willDisplayFooterView!(tableView, view, section)
    }
    @objc func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        _didEndDisplayingCell!(tableView, cell, indexPath)
    }
    @objc func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        _didEndDisplayingHeaderView!(tableView, view, section)
    }
    @objc func tableView(tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        _didEndDisplayingFooterView!(tableView, view, section)
    }
    @objc func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return _heightForRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return _heightForHeaderInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return _heightForFooterInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return _estimatedHeightForRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return _estimatedHeightForHeaderInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return _estimatedHeightForFooterInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return _viewForHeaderInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return _viewForFooterInSection!(tableView, section)
    }
    @objc func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        _accessoryButtonTappedForRowWithIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return _shouldHighlightRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        _didHighlightRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        _didUnhighlightRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return _willSelectRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return _willDeselectRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        _didSelectRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        _didDeselectRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return _editingStyleForRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        return _titleForDeleteConfirmationButtonForRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        return _editActionsForRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return _shouldIndentWhileEditingRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath) {
        _willBeginEditingRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {
        _didEndEditingRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        return _targetIndexPathForMoveFromRowAtIndexPath!(tableView, sourceIndexPath, proposedDestinationIndexPath)
    }
    @objc func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        return _indentationLevelForRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return _shouldShowMenuForRowAtIndexPath!(tableView, indexPath)
    }
    @objc func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject) -> Bool {
        return _canPerformAction!(tableView, action, indexPath, sender)
    }
    @objc func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!) {
        _performAction!(tableView, action, indexPath, sender)
    }
}
