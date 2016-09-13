//
//  CE_UISearchBar.swift
//  Centipede
//
//  Created by kelei on 2016/9/13.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension UISearchBar {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UISearchBar_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UISearchBar_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UISearchBar_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is UISearchBar_Delegate {
                return obj as! UISearchBar_Delegate
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
    
    internal func getDelegateInstance() -> UISearchBar_Delegate {
        return UISearchBar_Delegate()
    }
    
    public func ce_searchBarShouldBeginEditing(handle: ((UISearchBar) -> Bool)) -> Self {
        ce._searchBarShouldBeginEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_searchBarTextDidBeginEditing(handle: ((UISearchBar) -> Void)) -> Self {
        ce._searchBarTextDidBeginEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_searchBarShouldEndEditing(handle: ((UISearchBar) -> Bool)) -> Self {
        ce._searchBarShouldEndEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_searchBarTextDidEndEditing(handle: ((UISearchBar) -> Void)) -> Self {
        ce._searchBarTextDidEndEditing = handle
        rebindingDelegate()
        return self
    }
    public func ce_searchBar_textDidChange(handle: ((UISearchBar, String) -> Void)) -> Self {
        ce._searchBar_textDidChange = handle
        rebindingDelegate()
        return self
    }
    public func ce_searchBar_shouldChangeTextIn(handle: ((UISearchBar, NSRange, String) -> Bool)) -> Self {
        ce._searchBar_shouldChangeTextIn = handle
        rebindingDelegate()
        return self
    }
    public func ce_searchBarSearchButtonClicked(handle: ((UISearchBar) -> Void)) -> Self {
        ce._searchBarSearchButtonClicked = handle
        rebindingDelegate()
        return self
    }
    public func ce_searchBarBookmarkButtonClicked(handle: ((UISearchBar) -> Void)) -> Self {
        ce._searchBarBookmarkButtonClicked = handle
        rebindingDelegate()
        return self
    }
    public func ce_searchBarCancelButtonClicked(handle: ((UISearchBar) -> Void)) -> Self {
        ce._searchBarCancelButtonClicked = handle
        rebindingDelegate()
        return self
    }
    public func ce_searchBarResultsListButtonClicked(handle: ((UISearchBar) -> Void)) -> Self {
        ce._searchBarResultsListButtonClicked = handle
        rebindingDelegate()
        return self
    }
    public func ce_searchBar_selectedScopeButtonIndexDidChange(handle: ((UISearchBar, Int) -> Void)) -> Self {
        ce._searchBar_selectedScopeButtonIndexDidChange = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UISearchBar_Delegate: NSObject, UISearchBarDelegate {
    
    var _searchBarShouldBeginEditing: ((UISearchBar) -> Bool)?
    var _searchBarTextDidBeginEditing: ((UISearchBar) -> Void)?
    var _searchBarShouldEndEditing: ((UISearchBar) -> Bool)?
    var _searchBarTextDidEndEditing: ((UISearchBar) -> Void)?
    var _searchBar_textDidChange: ((UISearchBar, String) -> Void)?
    var _searchBar_shouldChangeTextIn: ((UISearchBar, NSRange, String) -> Bool)?
    var _searchBarSearchButtonClicked: ((UISearchBar) -> Void)?
    var _searchBarBookmarkButtonClicked: ((UISearchBar) -> Void)?
    var _searchBarCancelButtonClicked: ((UISearchBar) -> Void)?
    var _searchBarResultsListButtonClicked: ((UISearchBar) -> Void)?
    var _searchBar_selectedScopeButtonIndexDidChange: ((UISearchBar, Int) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(searchBarShouldBeginEditing(_:)) : _searchBarShouldBeginEditing,
            #selector(searchBarTextDidBeginEditing(_:)) : _searchBarTextDidBeginEditing,
            #selector(searchBarShouldEndEditing(_:)) : _searchBarShouldEndEditing,
            #selector(searchBarTextDidEndEditing(_:)) : _searchBarTextDidEndEditing,
            #selector(searchBar(_:textDidChange:)) : _searchBar_textDidChange,
            #selector(searchBar(_:shouldChangeTextIn:replacementText:)) : _searchBar_shouldChangeTextIn,
            #selector(searchBarSearchButtonClicked(_:)) : _searchBarSearchButtonClicked,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(searchBarBookmarkButtonClicked(_:)) : _searchBarBookmarkButtonClicked,
            #selector(searchBarCancelButtonClicked(_:)) : _searchBarCancelButtonClicked,
            #selector(searchBarResultsListButtonClicked(_:)) : _searchBarResultsListButtonClicked,
            #selector(searchBar(_:selectedScopeButtonIndexDidChange:)) : _searchBar_selectedScopeButtonIndexDidChange,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return _searchBarShouldBeginEditing!(searchBar)
    }
    @objc func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        _searchBarTextDidBeginEditing!(searchBar)
    }
    @objc func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return _searchBarShouldEndEditing!(searchBar)
    }
    @objc func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        _searchBarTextDidEndEditing!(searchBar)
    }
    @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        _searchBar_textDidChange!(searchBar, searchText)
    }
    @objc func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return _searchBar_shouldChangeTextIn!(searchBar, range, text)
    }
    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        _searchBarSearchButtonClicked!(searchBar)
    }
    @objc func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        _searchBarBookmarkButtonClicked!(searchBar)
    }
    @objc func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        _searchBarCancelButtonClicked!(searchBar)
    }
    @objc func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        _searchBarResultsListButtonClicked!(searchBar)
    }
    @objc func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        _searchBar_selectedScopeButtonIndexDidChange!(searchBar, selectedScope)
    }
}
