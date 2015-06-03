//
//  CE_UISearchBar.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    private var ce: UISearchBar_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UISearchBar_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UISearchBar_Delegate {
                return delegate as! UISearchBar_Delegate
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
    }
    
    internal func getDelegateInstance() -> UISearchBar_Delegate {
        return UISearchBar_Delegate()
    }
    
    public func ce_ShouldBeginEditing(handle: (searchBar: UISearchBar) -> Bool) -> Self {
        ce.ShouldBeginEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_TextDidBeginEditing(handle: (searchBar: UISearchBar) -> Void) -> Self {
        ce.TextDidBeginEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldEndEditing(handle: (searchBar: UISearchBar) -> Bool) -> Self {
        ce.ShouldEndEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_TextDidEndEditing(handle: (searchBar: UISearchBar) -> Void) -> Self {
        ce.TextDidEndEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_TextDidChange(handle: (searchBar: UISearchBar, searchText: String) -> Void) -> Self {
        ce.TextDidChange = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldChangeTextInRange(handle: (searchBar: UISearchBar, range: NSRange, text: String) -> Bool) -> Self {
        ce.ShouldChangeTextInRange = handle
        rebindingDelegate()
        return self
    }
    public func ce_SearchButtonClicked(handle: (searchBar: UISearchBar) -> Void) -> Self {
        ce.SearchButtonClicked = handle
        rebindingDelegate()
        return self
    }
    public func ce_BookmarkButtonClicked(handle: (searchBar: UISearchBar) -> Void) -> Self {
        ce.BookmarkButtonClicked = handle
        rebindingDelegate()
        return self
    }
    public func ce_CancelButtonClicked(handle: (searchBar: UISearchBar) -> Void) -> Self {
        ce.CancelButtonClicked = handle
        rebindingDelegate()
        return self
    }
    public func ce_ResultsListButtonClicked(handle: (searchBar: UISearchBar) -> Void) -> Self {
        ce.ResultsListButtonClicked = handle
        rebindingDelegate()
        return self
    }
    public func ce_SelectedScopeButtonIndexDidChange(handle: (searchBar: UISearchBar, selectedScope: Int) -> Void) -> Self {
        ce.SelectedScopeButtonIndexDidChange = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UISearchBar_Delegate: NSObject, UISearchBarDelegate {
    
    var ShouldBeginEditing: ((UISearchBar) -> Bool)?
    var TextDidBeginEditing: ((UISearchBar) -> Void)?
    var ShouldEndEditing: ((UISearchBar) -> Bool)?
    var TextDidEndEditing: ((UISearchBar) -> Void)?
    var TextDidChange: ((UISearchBar, String) -> Void)?
    var ShouldChangeTextInRange: ((UISearchBar, NSRange, String) -> Bool)?
    var SearchButtonClicked: ((UISearchBar) -> Void)?
    var BookmarkButtonClicked: ((UISearchBar) -> Void)?
    var CancelButtonClicked: ((UISearchBar) -> Void)?
    var ResultsListButtonClicked: ((UISearchBar) -> Void)?
    var SelectedScopeButtonIndexDidChange: ((UISearchBar, Int) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "searchBarShouldBeginEditing:" : ShouldBeginEditing,
            "searchBarTextDidBeginEditing:" : TextDidBeginEditing,
            "searchBarShouldEndEditing:" : ShouldEndEditing,
            "searchBarTextDidEndEditing:" : TextDidEndEditing,
            "searchBar:textDidChange:" : TextDidChange,
            "searchBar:shouldChangeTextInRange:replacementText:" : ShouldChangeTextInRange,
            "searchBarSearchButtonClicked:" : SearchButtonClicked,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "searchBarBookmarkButtonClicked:" : BookmarkButtonClicked,
            "searchBarCancelButtonClicked:" : CancelButtonClicked,
            "searchBarResultsListButtonClicked:" : ResultsListButtonClicked,
            "searchBar:selectedScopeButtonIndexDidChange:" : SelectedScopeButtonIndexDidChange,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        return ShouldBeginEditing!(searchBar)
    }
    @objc func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        TextDidBeginEditing!(searchBar)
    }
    @objc func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        return ShouldEndEditing!(searchBar)
    }
    @objc func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        TextDidEndEditing!(searchBar)
    }
    @objc func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        TextDidChange!(searchBar, searchText)
    }
    @objc func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return ShouldChangeTextInRange!(searchBar, range, text)
    }
    @objc func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        SearchButtonClicked!(searchBar)
    }
    @objc func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
        BookmarkButtonClicked!(searchBar)
    }
    @objc func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        CancelButtonClicked!(searchBar)
    }
    @objc func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
        ResultsListButtonClicked!(searchBar)
    }
    @objc func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        SelectedScopeButtonIndexDidChange!(searchBar, selectedScope)
    }
}
