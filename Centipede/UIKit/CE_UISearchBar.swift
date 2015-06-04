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
    
    public func ce_shouldBeginEditing(handle: (searchBar: UISearchBar) -> Bool) -> Self {
        ce._shouldBeginEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_textDidBeginEditing(handle: (searchBar: UISearchBar) -> Void) -> Self {
        ce._textDidBeginEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldEndEditing(handle: (searchBar: UISearchBar) -> Bool) -> Self {
        ce._shouldEndEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_textDidEndEditing(handle: (searchBar: UISearchBar) -> Void) -> Self {
        ce._textDidEndEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_textDidChange(handle: (searchBar: UISearchBar, searchText: String) -> Void) -> Self {
        ce._textDidChange = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldChangeTextInRange(handle: (searchBar: UISearchBar, range: NSRange, text: String) -> Bool) -> Self {
        ce._shouldChangeTextInRange = handle
        rebindingDelegate()
        return self
    }
    public func ce_searchButtonClicked(handle: (searchBar: UISearchBar) -> Void) -> Self {
        ce._searchButtonClicked = handle
        rebindingDelegate()
        return self
    }
    public func ce_bookmarkButtonClicked(handle: (searchBar: UISearchBar) -> Void) -> Self {
        ce._bookmarkButtonClicked = handle
        rebindingDelegate()
        return self
    }
    public func ce_cancelButtonClicked(handle: (searchBar: UISearchBar) -> Void) -> Self {
        ce._cancelButtonClicked = handle
        rebindingDelegate()
        return self
    }
    public func ce_resultsListButtonClicked(handle: (searchBar: UISearchBar) -> Void) -> Self {
        ce._resultsListButtonClicked = handle
        rebindingDelegate()
        return self
    }
    public func ce_selectedScopeButtonIndexDidChange(handle: (searchBar: UISearchBar, selectedScope: Int) -> Void) -> Self {
        ce._selectedScopeButtonIndexDidChange = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UISearchBar_Delegate: NSObject, UISearchBarDelegate {
    
    var _shouldBeginEditing: ((UISearchBar) -> Bool)?
    var _textDidBeginEditing: ((UISearchBar) -> Void)?
    var _shouldEndEditing: ((UISearchBar) -> Bool)?
    var _textDidEndEditing: ((UISearchBar) -> Void)?
    var _textDidChange: ((UISearchBar, String) -> Void)?
    var _shouldChangeTextInRange: ((UISearchBar, NSRange, String) -> Bool)?
    var _searchButtonClicked: ((UISearchBar) -> Void)?
    var _bookmarkButtonClicked: ((UISearchBar) -> Void)?
    var _cancelButtonClicked: ((UISearchBar) -> Void)?
    var _resultsListButtonClicked: ((UISearchBar) -> Void)?
    var _selectedScopeButtonIndexDidChange: ((UISearchBar, Int) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "searchBarShouldBeginEditing:" : _shouldBeginEditing,
            "searchBarTextDidBeginEditing:" : _textDidBeginEditing,
            "searchBarShouldEndEditing:" : _shouldEndEditing,
            "searchBarTextDidEndEditing:" : _textDidEndEditing,
            "searchBar:textDidChange:" : _textDidChange,
            "searchBar:shouldChangeTextInRange:replacementText:" : _shouldChangeTextInRange,
            "searchBarSearchButtonClicked:" : _searchButtonClicked,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "searchBarBookmarkButtonClicked:" : _bookmarkButtonClicked,
            "searchBarCancelButtonClicked:" : _cancelButtonClicked,
            "searchBarResultsListButtonClicked:" : _resultsListButtonClicked,
            "searchBar:selectedScopeButtonIndexDidChange:" : _selectedScopeButtonIndexDidChange,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        return _shouldBeginEditing!(searchBar)
    }
    @objc func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        _textDidBeginEditing!(searchBar)
    }
    @objc func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        return _shouldEndEditing!(searchBar)
    }
    @objc func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        _textDidEndEditing!(searchBar)
    }
    @objc func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        _textDidChange!(searchBar, searchText)
    }
    @objc func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return _shouldChangeTextInRange!(searchBar, range, text)
    }
    @objc func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        _searchButtonClicked!(searchBar)
    }
    @objc func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
        _bookmarkButtonClicked!(searchBar)
    }
    @objc func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        _cancelButtonClicked!(searchBar)
    }
    @objc func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
        _resultsListButtonClicked!(searchBar)
    }
    @objc func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        _selectedScopeButtonIndexDidChange!(searchBar, selectedScope)
    }
}
