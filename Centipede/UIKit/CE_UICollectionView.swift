//
//  CE_UICollectionView.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UICollectionView_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UICollectionView_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UICollectionView_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is UICollectionView_Delegate {
                return obj as! UICollectionView_Delegate
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
    
    internal override func getDelegateInstance() -> UICollectionView_Delegate {
        return UICollectionView_Delegate()
    }
    
    @discardableResult
    public func ce_collectionView_numberOfItemsInSection(handle: @escaping (UICollectionView, Int) -> Int) -> Self {
        ce._collectionView_numberOfItemsInSection = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_cellForItemAt(handle: @escaping (UICollectionView, IndexPath) -> UICollectionViewCell) -> Self {
        ce._collectionView_cellForItemAt = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_numberOfSections_in(handle: @escaping (UICollectionView) -> Int) -> Self {
        ce._numberOfSections_in = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_viewForSupplementaryElementOfKind(handle: @escaping (UICollectionView, String, IndexPath) -> UICollectionReusableView) -> Self {
        ce._collectionView_viewForSupplementaryElementOfKind = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_shouldHighlightItemAt(handle: @escaping (UICollectionView, IndexPath) -> Bool) -> Self {
        ce._collectionView_shouldHighlightItemAt = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_didHighlightItemAt(handle: @escaping (UICollectionView, IndexPath) -> Void) -> Self {
        ce._collectionView_didHighlightItemAt = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_didUnhighlightItemAt(handle: @escaping (UICollectionView, IndexPath) -> Void) -> Self {
        ce._collectionView_didUnhighlightItemAt = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_shouldSelectItemAt(handle: @escaping (UICollectionView, IndexPath) -> Bool) -> Self {
        ce._collectionView_shouldSelectItemAt = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_shouldDeselectItemAt(handle: @escaping (UICollectionView, IndexPath) -> Bool) -> Self {
        ce._collectionView_shouldDeselectItemAt = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_didSelectItemAt(handle: @escaping (UICollectionView, IndexPath) -> Void) -> Self {
        ce._collectionView_didSelectItemAt = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_didDeselectItemAt(handle: @escaping (UICollectionView, IndexPath) -> Void) -> Self {
        ce._collectionView_didDeselectItemAt = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_willDisplay(handle: @escaping (UICollectionView, UICollectionViewCell, IndexPath) -> Void) -> Self {
        ce._collectionView_willDisplay = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_willDisplaySupplementaryView(handle: @escaping (UICollectionView, UICollectionReusableView, String, IndexPath) -> Void) -> Self {
        ce._collectionView_willDisplaySupplementaryView = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_didEndDisplaying(handle: @escaping (UICollectionView, UICollectionViewCell, IndexPath) -> Void) -> Self {
        ce._collectionView_didEndDisplaying = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_didEndDisplayingSupplementaryView(handle: @escaping (UICollectionView, UICollectionReusableView, String, IndexPath) -> Void) -> Self {
        ce._collectionView_didEndDisplayingSupplementaryView = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_shouldShowMenuForItemAt(handle: @escaping (UICollectionView, IndexPath) -> Bool) -> Self {
        ce._collectionView_shouldShowMenuForItemAt = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_canPerformAction(handle: @escaping (UICollectionView, Selector, IndexPath, Any?) -> Bool) -> Self {
        ce._collectionView_canPerformAction = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_performAction(handle: @escaping (UICollectionView, Selector, IndexPath, Any?) -> Void) -> Self {
        ce._collectionView_performAction = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_transitionLayoutForOldLayout(handle: @escaping (UICollectionView, UICollectionViewLayout, UICollectionViewLayout) -> UICollectionViewTransitionLayout) -> Self {
        ce._collectionView_transitionLayoutForOldLayout = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_layout(handle: @escaping (UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize) -> Self {
        ce._collectionView_layout = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_layout_layout(handle: @escaping (UICollectionView, UICollectionViewLayout, Int) -> UIEdgeInsets) -> Self {
        ce._collectionView_layout_layout = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_layout_layout_layout(handle: @escaping (UICollectionView, UICollectionViewLayout, Int) -> CGFloat) -> Self {
        ce._collectionView_layout_layout_layout = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_layout_layout_layout_layout(handle: @escaping (UICollectionView, UICollectionViewLayout, Int) -> CGFloat) -> Self {
        ce._collectionView_layout_layout_layout_layout = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_layout_layout_layout_layout_layout(handle: @escaping (UICollectionView, UICollectionViewLayout, Int) -> CGSize) -> Self {
        ce._collectionView_layout_layout_layout_layout_layout = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_collectionView_layout_layout_layout_layout_layout_layout(handle: @escaping (UICollectionView, UICollectionViewLayout, Int) -> CGSize) -> Self {
        ce._collectionView_layout_layout_layout_layout_layout_layout = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UICollectionView_Delegate: UIScrollView_Delegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var _collectionView_numberOfItemsInSection: ((UICollectionView, Int) -> Int)?
    var _collectionView_cellForItemAt: ((UICollectionView, IndexPath) -> UICollectionViewCell)?
    var _numberOfSections_in: ((UICollectionView) -> Int)?
    var _collectionView_viewForSupplementaryElementOfKind: ((UICollectionView, String, IndexPath) -> UICollectionReusableView)?
    var _collectionView_shouldHighlightItemAt: ((UICollectionView, IndexPath) -> Bool)?
    var _collectionView_didHighlightItemAt: ((UICollectionView, IndexPath) -> Void)?
    var _collectionView_didUnhighlightItemAt: ((UICollectionView, IndexPath) -> Void)?
    var _collectionView_shouldSelectItemAt: ((UICollectionView, IndexPath) -> Bool)?
    var _collectionView_shouldDeselectItemAt: ((UICollectionView, IndexPath) -> Bool)?
    var _collectionView_didSelectItemAt: ((UICollectionView, IndexPath) -> Void)?
    var _collectionView_didDeselectItemAt: ((UICollectionView, IndexPath) -> Void)?
    var _collectionView_willDisplay: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)?
    var _collectionView_willDisplaySupplementaryView: ((UICollectionView, UICollectionReusableView, String, IndexPath) -> Void)?
    var _collectionView_didEndDisplaying: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)?
    var _collectionView_didEndDisplayingSupplementaryView: ((UICollectionView, UICollectionReusableView, String, IndexPath) -> Void)?
    var _collectionView_shouldShowMenuForItemAt: ((UICollectionView, IndexPath) -> Bool)?
    var _collectionView_canPerformAction: ((UICollectionView, Selector, IndexPath, Any?) -> Bool)?
    var _collectionView_performAction: ((UICollectionView, Selector, IndexPath, Any?) -> Void)?
    var _collectionView_transitionLayoutForOldLayout: ((UICollectionView, UICollectionViewLayout, UICollectionViewLayout) -> UICollectionViewTransitionLayout)?
    var _collectionView_layout: ((UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize)?
    var _collectionView_layout_layout: ((UICollectionView, UICollectionViewLayout, Int) -> UIEdgeInsets)?
    var _collectionView_layout_layout_layout: ((UICollectionView, UICollectionViewLayout, Int) -> CGFloat)?
    var _collectionView_layout_layout_layout_layout: ((UICollectionView, UICollectionViewLayout, Int) -> CGFloat)?
    var _collectionView_layout_layout_layout_layout_layout: ((UICollectionView, UICollectionViewLayout, Int) -> CGSize)?
    var _collectionView_layout_layout_layout_layout_layout_layout: ((UICollectionView, UICollectionViewLayout, Int) -> CGSize)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(collectionView(_:numberOfItemsInSection:)) : _collectionView_numberOfItemsInSection,
            #selector(collectionView(_:cellForItemAt:)) : _collectionView_cellForItemAt,
            #selector(numberOfSections(in:)) : _numberOfSections_in,
            #selector(collectionView(_:viewForSupplementaryElementOfKind:at:)) : _collectionView_viewForSupplementaryElementOfKind,
            #selector(collectionView(_:shouldHighlightItemAt:)) : _collectionView_shouldHighlightItemAt,
            #selector(collectionView(_:didHighlightItemAt:)) : _collectionView_didHighlightItemAt,
            #selector(collectionView(_:didUnhighlightItemAt:)) : _collectionView_didUnhighlightItemAt,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(collectionView(_:shouldSelectItemAt:)) : _collectionView_shouldSelectItemAt,
            #selector(collectionView(_:shouldDeselectItemAt:)) : _collectionView_shouldDeselectItemAt,
            #selector(collectionView(_:didSelectItemAt:)) : _collectionView_didSelectItemAt,
            #selector(collectionView(_:didDeselectItemAt:)) : _collectionView_didDeselectItemAt,
            #selector(collectionView(_:willDisplay:forItemAt:)) : _collectionView_willDisplay,
            #selector(collectionView(_:willDisplaySupplementaryView:forElementKind:at:)) : _collectionView_willDisplaySupplementaryView,
            #selector(collectionView(_:didEndDisplaying:forItemAt:)) : _collectionView_didEndDisplaying,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        let funcDic3: [Selector : Any?] = [
            #selector(collectionView(_:didEndDisplayingSupplementaryView:forElementOfKind:at:)) : _collectionView_didEndDisplayingSupplementaryView,
            #selector(collectionView(_:shouldShowMenuForItemAt:)) : _collectionView_shouldShowMenuForItemAt,
            #selector(collectionView(_:canPerformAction:forItemAt:withSender:)) : _collectionView_canPerformAction,
            #selector(collectionView(_:performAction:forItemAt:withSender:)) : _collectionView_performAction,
            #selector(collectionView(_:transitionLayoutForOldLayout:newLayout:)) : _collectionView_transitionLayoutForOldLayout,
            #selector(collectionView(_:layout:sizeForItemAt:)) : _collectionView_layout,
            #selector(collectionView(_:layout:insetForSectionAt:)) : _collectionView_layout_layout,
        ]
        if let f = funcDic3[aSelector] {
            return f != nil
        }
        
        let funcDic4: [Selector : Any?] = [
            #selector(collectionView(_:layout:minimumLineSpacingForSectionAt:)) : _collectionView_layout_layout_layout,
            #selector(collectionView(_:layout:minimumInteritemSpacingForSectionAt:)) : _collectionView_layout_layout_layout_layout,
            #selector(collectionView(_:layout:referenceSizeForHeaderInSection:)) : _collectionView_layout_layout_layout_layout_layout,
            #selector(collectionView(_:layout:referenceSizeForFooterInSection:)) : _collectionView_layout_layout_layout_layout_layout_layout,
        ]
        if let f = funcDic4[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _collectionView_numberOfItemsInSection!(collectionView, section)
    }
    @objc func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return _collectionView_cellForItemAt!(collectionView, indexPath)
    }
    @objc func numberOfSections(in collectionView: UICollectionView) -> Int {
        return _numberOfSections_in!(collectionView)
    }
    @objc func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return _collectionView_viewForSupplementaryElementOfKind!(collectionView, kind, indexPath)
    }
    @objc func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return _collectionView_shouldHighlightItemAt!(collectionView, indexPath)
    }
    @objc func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        _collectionView_didHighlightItemAt!(collectionView, indexPath)
    }
    @objc func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        _collectionView_didUnhighlightItemAt!(collectionView, indexPath)
    }
    @objc func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return _collectionView_shouldSelectItemAt!(collectionView, indexPath)
    }
    @objc func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return _collectionView_shouldDeselectItemAt!(collectionView, indexPath)
    }
    @objc func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _collectionView_didSelectItemAt!(collectionView, indexPath)
    }
    @objc func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        _collectionView_didDeselectItemAt!(collectionView, indexPath)
    }
    @objc func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        _collectionView_willDisplay!(collectionView, cell, indexPath)
    }
    @objc func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        _collectionView_willDisplaySupplementaryView!(collectionView, view, elementKind, indexPath)
    }
    @objc func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        _collectionView_didEndDisplaying!(collectionView, cell, indexPath)
    }
    @objc func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        _collectionView_didEndDisplayingSupplementaryView!(collectionView, view, elementKind, indexPath)
    }
    @objc func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return _collectionView_shouldShowMenuForItemAt!(collectionView, indexPath)
    }
    @objc func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return _collectionView_canPerformAction!(collectionView, action, indexPath, sender)
    }
    @objc func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        _collectionView_performAction!(collectionView, action, indexPath, sender)
    }
    @objc func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        return _collectionView_transitionLayoutForOldLayout!(collectionView, fromLayout, toLayout)
    }
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return _collectionView_layout!(collectionView, collectionViewLayout, indexPath)
    }
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return _collectionView_layout_layout!(collectionView, collectionViewLayout, section)
    }
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return _collectionView_layout_layout_layout!(collectionView, collectionViewLayout, section)
    }
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return _collectionView_layout_layout_layout_layout!(collectionView, collectionViewLayout, section)
    }
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return _collectionView_layout_layout_layout_layout_layout!(collectionView, collectionViewLayout, section)
    }
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return _collectionView_layout_layout_layout_layout_layout_layout!(collectionView, collectionViewLayout, section)
    }
}
