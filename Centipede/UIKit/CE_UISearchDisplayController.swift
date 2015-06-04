//
//  CE_UISearchDisplayController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UISearchDisplayController {
    
    private var ce: UISearchDisplayController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UISearchDisplayController_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UISearchDisplayController_Delegate {
                return delegate as! UISearchDisplayController_Delegate
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
        self.searchResultsDataSource = nil
        self.searchResultsDataSource = delegate
        self.searchResultsDelegate = nil
        self.searchResultsDelegate = delegate
    }
    
    internal func getDelegateInstance() -> UISearchDisplayController_Delegate {
        return UISearchDisplayController_Delegate()
    }
    
    public func ce_willBeginSearch(handle: (controller: UISearchDisplayController) -> Void) -> Self {
        ce._willBeginSearch = handle
        rebindingDelegate()
        return self
    }
    public func ce_didBeginSearch(handle: (controller: UISearchDisplayController) -> Void) -> Self {
        ce._didBeginSearch = handle
        rebindingDelegate()
        return self
    }
    public func ce_willEndSearch(handle: (controller: UISearchDisplayController) -> Void) -> Self {
        ce._willEndSearch = handle
        rebindingDelegate()
        return self
    }
    public func ce_didEndSearch(handle: (controller: UISearchDisplayController) -> Void) -> Self {
        ce._didEndSearch = handle
        rebindingDelegate()
        return self
    }
    public func ce_didLoadSearchResultsTableView(handle: (controller: UISearchDisplayController, tableView: UITableView) -> Void) -> Self {
        ce._didLoadSearchResultsTableView = handle
        rebindingDelegate()
        return self
    }
    public func ce_willUnloadSearchResultsTableView(handle: (controller: UISearchDisplayController, tableView: UITableView) -> Void) -> Self {
        ce._willUnloadSearchResultsTableView = handle
        rebindingDelegate()
        return self
    }
    public func ce_willShowSearchResultsTableView(handle: (controller: UISearchDisplayController, tableView: UITableView) -> Void) -> Self {
        ce._willShowSearchResultsTableView = handle
        rebindingDelegate()
        return self
    }
    public func ce_didShowSearchResultsTableView(handle: (controller: UISearchDisplayController, tableView: UITableView) -> Void) -> Self {
        ce._didShowSearchResultsTableView = handle
        rebindingDelegate()
        return self
    }
    public func ce_willHideSearchResultsTableView(handle: (controller: UISearchDisplayController, tableView: UITableView) -> Void) -> Self {
        ce._willHideSearchResultsTableView = handle
        rebindingDelegate()
        return self
    }
    public func ce_didHideSearchResultsTableView(handle: (controller: UISearchDisplayController, tableView: UITableView) -> Void) -> Self {
        ce._didHideSearchResultsTableView = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldReloadTableForSearchString(handle: (controller: UISearchDisplayController, searchString: String!) -> Bool) -> Self {
        ce._shouldReloadTableForSearchString = handle
        rebindingDelegate()
        return self
    }
    public func ce_shouldReloadTableForSearchScope(handle: (controller: UISearchDisplayController, searchOption: Int) -> Bool) -> Self {
        ce._shouldReloadTableForSearchScope = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UISearchDisplayController_Delegate: UITableView_Delegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var _willBeginSearch: ((UISearchDisplayController) -> Void)?
    var _didBeginSearch: ((UISearchDisplayController) -> Void)?
    var _willEndSearch: ((UISearchDisplayController) -> Void)?
    var _didEndSearch: ((UISearchDisplayController) -> Void)?
    var _didLoadSearchResultsTableView: ((UISearchDisplayController, UITableView) -> Void)?
    var _willUnloadSearchResultsTableView: ((UISearchDisplayController, UITableView) -> Void)?
    var _willShowSearchResultsTableView: ((UISearchDisplayController, UITableView) -> Void)?
    var _didShowSearchResultsTableView: ((UISearchDisplayController, UITableView) -> Void)?
    var _willHideSearchResultsTableView: ((UISearchDisplayController, UITableView) -> Void)?
    var _didHideSearchResultsTableView: ((UISearchDisplayController, UITableView) -> Void)?
    var _shouldReloadTableForSearchString: ((UISearchDisplayController, String!) -> Bool)?
    var _shouldReloadTableForSearchScope: ((UISearchDisplayController, Int) -> Bool)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "searchDisplayControllerWillBeginSearch:" : _willBeginSearch,
            "searchDisplayControllerDidBeginSearch:" : _didBeginSearch,
            "searchDisplayControllerWillEndSearch:" : _willEndSearch,
            "searchDisplayControllerDidEndSearch:" : _didEndSearch,
            "searchDisplayController:didLoadSearchResultsTableView:" : _didLoadSearchResultsTableView,
            "searchDisplayController:willUnloadSearchResultsTableView:" : _willUnloadSearchResultsTableView,
            "searchDisplayController:willShowSearchResultsTableView:" : _willShowSearchResultsTableView,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "searchDisplayController:didShowSearchResultsTableView:" : _didShowSearchResultsTableView,
            "searchDisplayController:willHideSearchResultsTableView:" : _willHideSearchResultsTableView,
            "searchDisplayController:didHideSearchResultsTableView:" : _didHideSearchResultsTableView,
            "searchDisplayController:shouldReloadTableForSearchString:" : _shouldReloadTableForSearchString,
            "searchDisplayController:shouldReloadTableForSearchScope:" : _shouldReloadTableForSearchScope,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func searchDisplayControllerWillBeginSearch(controller: UISearchDisplayController) {
        _willBeginSearch!(controller)
    }
    @objc func searchDisplayControllerDidBeginSearch(controller: UISearchDisplayController) {
        _didBeginSearch!(controller)
    }
    @objc func searchDisplayControllerWillEndSearch(controller: UISearchDisplayController) {
        _willEndSearch!(controller)
    }
    @objc func searchDisplayControllerDidEndSearch(controller: UISearchDisplayController) {
        _didEndSearch!(controller)
    }
    @objc func searchDisplayController(controller: UISearchDisplayController, didLoadSearchResultsTableView tableView: UITableView) {
        _didLoadSearchResultsTableView!(controller, tableView)
    }
    @objc func searchDisplayController(controller: UISearchDisplayController, willUnloadSearchResultsTableView tableView: UITableView) {
        _willUnloadSearchResultsTableView!(controller, tableView)
    }
    @objc func searchDisplayController(controller: UISearchDisplayController, willShowSearchResultsTableView tableView: UITableView) {
        _willShowSearchResultsTableView!(controller, tableView)
    }
    @objc func searchDisplayController(controller: UISearchDisplayController, didShowSearchResultsTableView tableView: UITableView) {
        _didShowSearchResultsTableView!(controller, tableView)
    }
    @objc func searchDisplayController(controller: UISearchDisplayController, willHideSearchResultsTableView tableView: UITableView) {
        _willHideSearchResultsTableView!(controller, tableView)
    }
    @objc func searchDisplayController(controller: UISearchDisplayController, didHideSearchResultsTableView tableView: UITableView) {
        _didHideSearchResultsTableView!(controller, tableView)
    }
    @objc func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        return _shouldReloadTableForSearchString!(controller, searchString)
    }
    @objc func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        return _shouldReloadTableForSearchScope!(controller, searchOption)
    }
}
