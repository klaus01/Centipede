//
//  CE_UITableView.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension UITableView {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UITableView_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UITableView_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UITableView_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is UITableView_Delegate {
                return obj as! UITableView_Delegate
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
    
    internal override func getDelegateInstance() -> UITableView_Delegate {
        return UITableView_Delegate()
    }
    
    public func ce_tableView_numberOfRowsInSection(handle: ((UITableView, Int) -> Int)) -> Self {
        ce._tableView_numberOfRowsInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_cellForRowAt(handle: ((UITableView, IndexPath) -> UITableViewCell)) -> Self {
        ce._tableView_cellForRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_numberOfSections_in(handle: ((UITableView) -> Int)) -> Self {
        ce._numberOfSections_in = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_titleForHeaderInSection(handle: ((UITableView, Int) -> String?)) -> Self {
        ce._tableView_titleForHeaderInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_titleForFooterInSection(handle: ((UITableView, Int) -> String?)) -> Self {
        ce._tableView_titleForFooterInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_canEditRowAt(handle: ((UITableView, IndexPath) -> Bool)) -> Self {
        ce._tableView_canEditRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_canMoveRowAt(handle: ((UITableView, IndexPath) -> Bool)) -> Self {
        ce._tableView_canMoveRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_sectionIndexTitles_for(handle: ((UITableView) -> [String]?)) -> Self {
        ce._sectionIndexTitles_for = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_sectionForSectionIndexTitle(handle: ((UITableView, String, Int) -> Int)) -> Self {
        ce._tableView_sectionForSectionIndexTitle = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_commit(handle: ((UITableView, UITableViewCellEditingStyle, IndexPath) -> Void)) -> Self {
        ce._tableView_commit = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_moveRowAt(handle: ((UITableView, IndexPath, IndexPath) -> Void)) -> Self {
        ce._tableView_moveRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_willDisplay(handle: ((UITableView, UITableViewCell, IndexPath) -> Void)) -> Self {
        ce._tableView_willDisplay = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_willDisplayHeaderView(handle: ((UITableView, UIView, Int) -> Void)) -> Self {
        ce._tableView_willDisplayHeaderView = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_willDisplayFooterView(handle: ((UITableView, UIView, Int) -> Void)) -> Self {
        ce._tableView_willDisplayFooterView = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_didEndDisplaying(handle: ((UITableView, UITableViewCell, IndexPath) -> Void)) -> Self {
        ce._tableView_didEndDisplaying = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_didEndDisplayingHeaderView(handle: ((UITableView, UIView, Int) -> Void)) -> Self {
        ce._tableView_didEndDisplayingHeaderView = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_didEndDisplayingFooterView(handle: ((UITableView, UIView, Int) -> Void)) -> Self {
        ce._tableView_didEndDisplayingFooterView = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_heightForRowAt(handle: ((UITableView, IndexPath) -> CGFloat)) -> Self {
        ce._tableView_heightForRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_heightForHeaderInSection(handle: ((UITableView, Int) -> CGFloat)) -> Self {
        ce._tableView_heightForHeaderInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_heightForFooterInSection(handle: ((UITableView, Int) -> CGFloat)) -> Self {
        ce._tableView_heightForFooterInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_estimatedHeightForRowAt(handle: ((UITableView, IndexPath) -> CGFloat)) -> Self {
        ce._tableView_estimatedHeightForRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_estimatedHeightForHeaderInSection(handle: ((UITableView, Int) -> CGFloat)) -> Self {
        ce._tableView_estimatedHeightForHeaderInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_estimatedHeightForFooterInSection(handle: ((UITableView, Int) -> CGFloat)) -> Self {
        ce._tableView_estimatedHeightForFooterInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_viewForHeaderInSection(handle: ((UITableView, Int) -> UIView?)) -> Self {
        ce._tableView_viewForHeaderInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_viewForFooterInSection(handle: ((UITableView, Int) -> UIView?)) -> Self {
        ce._tableView_viewForFooterInSection = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_accessoryButtonTappedForRowWith(handle: ((UITableView, IndexPath) -> Void)) -> Self {
        ce._tableView_accessoryButtonTappedForRowWith = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_shouldHighlightRowAt(handle: ((UITableView, IndexPath) -> Bool)) -> Self {
        ce._tableView_shouldHighlightRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_didHighlightRowAt(handle: ((UITableView, IndexPath) -> Void)) -> Self {
        ce._tableView_didHighlightRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_didUnhighlightRowAt(handle: ((UITableView, IndexPath) -> Void)) -> Self {
        ce._tableView_didUnhighlightRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_willSelectRowAt(handle: ((UITableView, IndexPath) -> IndexPath?)) -> Self {
        ce._tableView_willSelectRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_willDeselectRowAt(handle: ((UITableView, IndexPath) -> IndexPath?)) -> Self {
        ce._tableView_willDeselectRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_didSelectRowAt(handle: ((UITableView, IndexPath) -> Void)) -> Self {
        ce._tableView_didSelectRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_didDeselectRowAt(handle: ((UITableView, IndexPath) -> Void)) -> Self {
        ce._tableView_didDeselectRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_editingStyleForRowAt(handle: ((UITableView, IndexPath) -> UITableViewCellEditingStyle)) -> Self {
        ce._tableView_editingStyleForRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_titleForDeleteConfirmationButtonForRowAt(handle: ((UITableView, IndexPath) -> String?)) -> Self {
        ce._tableView_titleForDeleteConfirmationButtonForRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_editActionsForRowAt(handle: ((UITableView, IndexPath) -> [UITableViewRowAction]?)) -> Self {
        ce._tableView_editActionsForRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_shouldIndentWhileEditingRowAt(handle: ((UITableView, IndexPath) -> Bool)) -> Self {
        ce._tableView_shouldIndentWhileEditingRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_willBeginEditingRowAt(handle: ((UITableView, IndexPath) -> Void)) -> Self {
        ce._tableView_willBeginEditingRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_didEndEditingRowAt(handle: ((UITableView, IndexPath?) -> Void)) -> Self {
        ce._tableView_didEndEditingRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_targetIndexPathForMoveFromRowAt(handle: ((UITableView, IndexPath, IndexPath) -> IndexPath)) -> Self {
        ce._tableView_targetIndexPathForMoveFromRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_indentationLevelForRowAt(handle: ((UITableView, IndexPath) -> Int)) -> Self {
        ce._tableView_indentationLevelForRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_shouldShowMenuForRowAt(handle: ((UITableView, IndexPath) -> Bool)) -> Self {
        ce._tableView_shouldShowMenuForRowAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_canPerformAction(handle: ((UITableView, Selector, IndexPath, Any?) -> Bool)) -> Self {
        ce._tableView_canPerformAction = handle
        rebindingDelegate()
        return self
    }
    public func ce_tableView_performAction(handle: ((UITableView, Selector, IndexPath, Any?) -> Void)) -> Self {
        ce._tableView_performAction = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UITableView_Delegate: UIScrollView_Delegate, UITableViewDataSource, UITableViewDelegate {
    
    var _tableView_numberOfRowsInSection: ((UITableView, Int) -> Int)?
    var _tableView_cellForRowAt: ((UITableView, IndexPath) -> UITableViewCell)?
    var _numberOfSections_in: ((UITableView) -> Int)?
    var _tableView_titleForHeaderInSection: ((UITableView, Int) -> String?)?
    var _tableView_titleForFooterInSection: ((UITableView, Int) -> String?)?
    var _tableView_canEditRowAt: ((UITableView, IndexPath) -> Bool)?
    var _tableView_canMoveRowAt: ((UITableView, IndexPath) -> Bool)?
    var _sectionIndexTitles_for: ((UITableView) -> [String]?)?
    var _tableView_sectionForSectionIndexTitle: ((UITableView, String, Int) -> Int)?
    var _tableView_commit: ((UITableView, UITableViewCellEditingStyle, IndexPath) -> Void)?
    var _tableView_moveRowAt: ((UITableView, IndexPath, IndexPath) -> Void)?
    var _tableView_willDisplay: ((UITableView, UITableViewCell, IndexPath) -> Void)?
    var _tableView_willDisplayHeaderView: ((UITableView, UIView, Int) -> Void)?
    var _tableView_willDisplayFooterView: ((UITableView, UIView, Int) -> Void)?
    var _tableView_didEndDisplaying: ((UITableView, UITableViewCell, IndexPath) -> Void)?
    var _tableView_didEndDisplayingHeaderView: ((UITableView, UIView, Int) -> Void)?
    var _tableView_didEndDisplayingFooterView: ((UITableView, UIView, Int) -> Void)?
    var _tableView_heightForRowAt: ((UITableView, IndexPath) -> CGFloat)?
    var _tableView_heightForHeaderInSection: ((UITableView, Int) -> CGFloat)?
    var _tableView_heightForFooterInSection: ((UITableView, Int) -> CGFloat)?
    var _tableView_estimatedHeightForRowAt: ((UITableView, IndexPath) -> CGFloat)?
    var _tableView_estimatedHeightForHeaderInSection: ((UITableView, Int) -> CGFloat)?
    var _tableView_estimatedHeightForFooterInSection: ((UITableView, Int) -> CGFloat)?
    var _tableView_viewForHeaderInSection: ((UITableView, Int) -> UIView?)?
    var _tableView_viewForFooterInSection: ((UITableView, Int) -> UIView?)?
    var _tableView_accessoryButtonTappedForRowWith: ((UITableView, IndexPath) -> Void)?
    var _tableView_shouldHighlightRowAt: ((UITableView, IndexPath) -> Bool)?
    var _tableView_didHighlightRowAt: ((UITableView, IndexPath) -> Void)?
    var _tableView_didUnhighlightRowAt: ((UITableView, IndexPath) -> Void)?
    var _tableView_willSelectRowAt: ((UITableView, IndexPath) -> IndexPath?)?
    var _tableView_willDeselectRowAt: ((UITableView, IndexPath) -> IndexPath?)?
    var _tableView_didSelectRowAt: ((UITableView, IndexPath) -> Void)?
    var _tableView_didDeselectRowAt: ((UITableView, IndexPath) -> Void)?
    var _tableView_editingStyleForRowAt: ((UITableView, IndexPath) -> UITableViewCellEditingStyle)?
    var _tableView_titleForDeleteConfirmationButtonForRowAt: ((UITableView, IndexPath) -> String?)?
    var _tableView_editActionsForRowAt: ((UITableView, IndexPath) -> [UITableViewRowAction]?)?
    var _tableView_shouldIndentWhileEditingRowAt: ((UITableView, IndexPath) -> Bool)?
    var _tableView_willBeginEditingRowAt: ((UITableView, IndexPath) -> Void)?
    var _tableView_didEndEditingRowAt: ((UITableView, IndexPath?) -> Void)?
    var _tableView_targetIndexPathForMoveFromRowAt: ((UITableView, IndexPath, IndexPath) -> IndexPath)?
    var _tableView_indentationLevelForRowAt: ((UITableView, IndexPath) -> Int)?
    var _tableView_shouldShowMenuForRowAt: ((UITableView, IndexPath) -> Bool)?
    var _tableView_canPerformAction: ((UITableView, Selector, IndexPath, Any?) -> Bool)?
    var _tableView_performAction: ((UITableView, Selector, IndexPath, Any?) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(tableView(_:numberOfRowsInSection:)) : _tableView_numberOfRowsInSection,
            #selector(tableView(_:cellForRowAt:)) : _tableView_cellForRowAt,
            #selector(numberOfSections(in:)) : _numberOfSections_in,
            #selector(tableView(_:titleForHeaderInSection:)) : _tableView_titleForHeaderInSection,
            #selector(tableView(_:titleForFooterInSection:)) : _tableView_titleForFooterInSection,
            #selector(tableView(_:canEditRowAt:)) : _tableView_canEditRowAt,
            #selector(tableView(_:canMoveRowAt:)) : _tableView_canMoveRowAt,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(sectionIndexTitles(for:)) : _sectionIndexTitles_for,
            #selector(tableView(_:sectionForSectionIndexTitle:at:)) : _tableView_sectionForSectionIndexTitle,
            #selector(tableView(_:commit:forRowAt:)) : _tableView_commit,
            #selector(tableView(_:moveRowAt:to:)) : _tableView_moveRowAt,
            #selector(tableView(_:willDisplay:forRowAt:)) : _tableView_willDisplay,
            #selector(tableView(_:willDisplayHeaderView:forSection:)) : _tableView_willDisplayHeaderView,
            #selector(tableView(_:willDisplayFooterView:forSection:)) : _tableView_willDisplayFooterView,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        let funcDic3: [Selector : Any?] = [
            #selector(tableView(_:didEndDisplaying:forRowAt:)) : _tableView_didEndDisplaying,
            #selector(tableView(_:didEndDisplayingHeaderView:forSection:)) : _tableView_didEndDisplayingHeaderView,
            #selector(tableView(_:didEndDisplayingFooterView:forSection:)) : _tableView_didEndDisplayingFooterView,
            #selector(tableView(_:heightForRowAt:)) : _tableView_heightForRowAt,
            #selector(tableView(_:heightForHeaderInSection:)) : _tableView_heightForHeaderInSection,
            #selector(tableView(_:heightForFooterInSection:)) : _tableView_heightForFooterInSection,
            #selector(tableView(_:estimatedHeightForRowAt:)) : _tableView_estimatedHeightForRowAt,
        ]
        if let f = funcDic3[aSelector] {
            return f != nil
        }
        
        let funcDic4: [Selector : Any?] = [
            #selector(tableView(_:estimatedHeightForHeaderInSection:)) : _tableView_estimatedHeightForHeaderInSection,
            #selector(tableView(_:estimatedHeightForFooterInSection:)) : _tableView_estimatedHeightForFooterInSection,
            #selector(tableView(_:viewForHeaderInSection:)) : _tableView_viewForHeaderInSection,
            #selector(tableView(_:viewForFooterInSection:)) : _tableView_viewForFooterInSection,
            #selector(tableView(_:accessoryButtonTappedForRowWith:)) : _tableView_accessoryButtonTappedForRowWith,
            #selector(tableView(_:shouldHighlightRowAt:)) : _tableView_shouldHighlightRowAt,
            #selector(tableView(_:didHighlightRowAt:)) : _tableView_didHighlightRowAt,
        ]
        if let f = funcDic4[aSelector] {
            return f != nil
        }
        
        let funcDic5: [Selector : Any?] = [
            #selector(tableView(_:didUnhighlightRowAt:)) : _tableView_didUnhighlightRowAt,
            #selector(tableView(_:willSelectRowAt:)) : _tableView_willSelectRowAt,
            #selector(tableView(_:willDeselectRowAt:)) : _tableView_willDeselectRowAt,
            #selector(tableView(_:didSelectRowAt:)) : _tableView_didSelectRowAt,
            #selector(tableView(_:didDeselectRowAt:)) : _tableView_didDeselectRowAt,
            #selector(tableView(_:editingStyleForRowAt:)) : _tableView_editingStyleForRowAt,
            #selector(tableView(_:titleForDeleteConfirmationButtonForRowAt:)) : _tableView_titleForDeleteConfirmationButtonForRowAt,
        ]
        if let f = funcDic5[aSelector] {
            return f != nil
        }
        
        let funcDic6: [Selector : Any?] = [
            #selector(tableView(_:editActionsForRowAt:)) : _tableView_editActionsForRowAt,
            #selector(tableView(_:shouldIndentWhileEditingRowAt:)) : _tableView_shouldIndentWhileEditingRowAt,
            #selector(tableView(_:willBeginEditingRowAt:)) : _tableView_willBeginEditingRowAt,
            #selector(tableView(_:didEndEditingRowAt:)) : _tableView_didEndEditingRowAt,
            #selector(tableView(_:targetIndexPathForMoveFromRowAt:toProposedIndexPath:)) : _tableView_targetIndexPathForMoveFromRowAt,
            #selector(tableView(_:indentationLevelForRowAt:)) : _tableView_indentationLevelForRowAt,
            #selector(tableView(_:shouldShowMenuForRowAt:)) : _tableView_shouldShowMenuForRowAt,
        ]
        if let f = funcDic6[aSelector] {
            return f != nil
        }
        
        let funcDic7: [Selector : Any?] = [
            #selector(tableView(_:canPerformAction:forRowAt:withSender:)) : _tableView_canPerformAction,
            #selector(tableView(_:performAction:forRowAt:withSender:)) : _tableView_performAction,
        ]
        if let f = funcDic7[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _tableView_numberOfRowsInSection!(tableView, section)
    }
    @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return _tableView_cellForRowAt!(tableView, indexPath)
    }
    @objc func numberOfSections(in tableView: UITableView) -> Int {
        return _numberOfSections_in!(tableView)
    }
    @objc func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return _tableView_titleForHeaderInSection!(tableView, section)
    }
    @objc func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return _tableView_titleForFooterInSection!(tableView, section)
    }
    @objc func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return _tableView_canEditRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return _tableView_canMoveRowAt!(tableView, indexPath)
    }
    @objc func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return _sectionIndexTitles_for!(tableView)
    }
    @objc func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return _tableView_sectionForSectionIndexTitle!(tableView, title, index)
    }
    @objc func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        _tableView_commit!(tableView, editingStyle, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        _tableView_moveRowAt!(tableView, sourceIndexPath, destinationIndexPath)
    }
    @objc func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        _tableView_willDisplay!(tableView, cell, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        _tableView_willDisplayHeaderView!(tableView, view, section)
    }
    @objc func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        _tableView_willDisplayFooterView!(tableView, view, section)
    }
    @objc func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        _tableView_didEndDisplaying!(tableView, cell, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        _tableView_didEndDisplayingHeaderView!(tableView, view, section)
    }
    @objc func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        _tableView_didEndDisplayingFooterView!(tableView, view, section)
    }
    @objc func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return _tableView_heightForRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return _tableView_heightForHeaderInSection!(tableView, section)
    }
    @objc func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return _tableView_heightForFooterInSection!(tableView, section)
    }
    @objc func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return _tableView_estimatedHeightForRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return _tableView_estimatedHeightForHeaderInSection!(tableView, section)
    }
    @objc func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return _tableView_estimatedHeightForFooterInSection!(tableView, section)
    }
    @objc func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return _tableView_viewForHeaderInSection!(tableView, section)
    }
    @objc func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return _tableView_viewForFooterInSection!(tableView, section)
    }
    @objc func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        _tableView_accessoryButtonTappedForRowWith!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return _tableView_shouldHighlightRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        _tableView_didHighlightRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        _tableView_didUnhighlightRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return _tableView_willSelectRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return _tableView_willDeselectRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _tableView_didSelectRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        _tableView_didDeselectRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return _tableView_editingStyleForRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return _tableView_titleForDeleteConfirmationButtonForRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return _tableView_editActionsForRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return _tableView_shouldIndentWhileEditingRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        _tableView_willBeginEditingRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        _tableView_didEndEditingRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return _tableView_targetIndexPathForMoveFromRowAt!(tableView, sourceIndexPath, proposedDestinationIndexPath)
    }
    @objc func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return _tableView_indentationLevelForRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return _tableView_shouldShowMenuForRowAt!(tableView, indexPath)
    }
    @objc func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return _tableView_canPerformAction!(tableView, action, indexPath, sender)
    }
    @objc func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        _tableView_performAction!(tableView, action, indexPath, sender)
    }
}
