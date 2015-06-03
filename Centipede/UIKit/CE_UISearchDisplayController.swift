//
//  CE_UISearchDisplayController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UISearchDisplayController {
    
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
    
    public func ce_WillBeginSearch(handle: (controller: UISearchDisplayController) -> Void) -> Self {
        ce.WillBeginSearch = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidBeginSearch(handle: (controller: UISearchDisplayController) -> Void) -> Self {
        ce.DidBeginSearch = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillEndSearch(handle: (controller: UISearchDisplayController) -> Void) -> Self {
        ce.WillEndSearch = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidEndSearch(handle: (controller: UISearchDisplayController) -> Void) -> Self {
        ce.DidEndSearch = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidLoadSearchResultsTableView(handle: (controller: UISearchDisplayController, tableView: UITableView) -> Void) -> Self {
        ce.DidLoadSearchResultsTableView = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillUnloadSearchResultsTableView(handle: (controller: UISearchDisplayController, tableView: UITableView) -> Void) -> Self {
        ce.WillUnloadSearchResultsTableView = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillShowSearchResultsTableView(handle: (controller: UISearchDisplayController, tableView: UITableView) -> Void) -> Self {
        ce.WillShowSearchResultsTableView = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidShowSearchResultsTableView(handle: (controller: UISearchDisplayController, tableView: UITableView) -> Void) -> Self {
        ce.DidShowSearchResultsTableView = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillHideSearchResultsTableView(handle: (controller: UISearchDisplayController, tableView: UITableView) -> Void) -> Self {
        ce.WillHideSearchResultsTableView = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidHideSearchResultsTableView(handle: (controller: UISearchDisplayController, tableView: UITableView) -> Void) -> Self {
        ce.DidHideSearchResultsTableView = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldReloadTableForSearchString(handle: (controller: UISearchDisplayController, searchString: String!) -> Bool) -> Self {
        ce.ShouldReloadTableForSearchString = handle
        rebindingDelegate()
        return self
    }
    public func ce_ShouldReloadTableForSearchScope(handle: (controller: UISearchDisplayController, searchOption: Int) -> Bool) -> Self {
        ce.ShouldReloadTableForSearchScope = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UISearchDisplayController_Delegate: UITableView_Delegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var WillBeginSearch: ((UISearchDisplayController) -> Void)?
    var DidBeginSearch: ((UISearchDisplayController) -> Void)?
    var WillEndSearch: ((UISearchDisplayController) -> Void)?
    var DidEndSearch: ((UISearchDisplayController) -> Void)?
    var DidLoadSearchResultsTableView: ((UISearchDisplayController, UITableView) -> Void)?
    var WillUnloadSearchResultsTableView: ((UISearchDisplayController, UITableView) -> Void)?
    var WillShowSearchResultsTableView: ((UISearchDisplayController, UITableView) -> Void)?
    var DidShowSearchResultsTableView: ((UISearchDisplayController, UITableView) -> Void)?
    var WillHideSearchResultsTableView: ((UISearchDisplayController, UITableView) -> Void)?
    var DidHideSearchResultsTableView: ((UISearchDisplayController, UITableView) -> Void)?
    var ShouldReloadTableForSearchString: ((UISearchDisplayController, String!) -> Bool)?
    var ShouldReloadTableForSearchScope: ((UISearchDisplayController, Int) -> Bool)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "searchDisplayControllerWillBeginSearch:" : WillBeginSearch,
            "searchDisplayControllerDidBeginSearch:" : DidBeginSearch,
            "searchDisplayControllerWillEndSearch:" : WillEndSearch,
            "searchDisplayControllerDidEndSearch:" : DidEndSearch,
            "searchDisplayController:didLoadSearchResultsTableView:" : DidLoadSearchResultsTableView,
            "searchDisplayController:willUnloadSearchResultsTableView:" : WillUnloadSearchResultsTableView,
            "searchDisplayController:willShowSearchResultsTableView:" : WillShowSearchResultsTableView,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "searchDisplayController:didShowSearchResultsTableView:" : DidShowSearchResultsTableView,
            "searchDisplayController:willHideSearchResultsTableView:" : WillHideSearchResultsTableView,
            "searchDisplayController:didHideSearchResultsTableView:" : DidHideSearchResultsTableView,
            "searchDisplayController:shouldReloadTableForSearchString:" : ShouldReloadTableForSearchString,
            "searchDisplayController:shouldReloadTableForSearchScope:" : ShouldReloadTableForSearchScope,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func searchDisplayControllerWillBeginSearch(controller: UISearchDisplayController) {
        WillBeginSearch!(controller)
    }
    @objc func searchDisplayControllerDidBeginSearch(controller: UISearchDisplayController) {
        DidBeginSearch!(controller)
    }
    @objc func searchDisplayControllerWillEndSearch(controller: UISearchDisplayController) {
        WillEndSearch!(controller)
    }
    @objc func searchDisplayControllerDidEndSearch(controller: UISearchDisplayController) {
        DidEndSearch!(controller)
    }
    @objc func searchDisplayController(controller: UISearchDisplayController, didLoadSearchResultsTableView tableView: UITableView) {
        DidLoadSearchResultsTableView!(controller, tableView)
    }
    @objc func searchDisplayController(controller: UISearchDisplayController, willUnloadSearchResultsTableView tableView: UITableView) {
        WillUnloadSearchResultsTableView!(controller, tableView)
    }
    @objc func searchDisplayController(controller: UISearchDisplayController, willShowSearchResultsTableView tableView: UITableView) {
        WillShowSearchResultsTableView!(controller, tableView)
    }
    @objc func searchDisplayController(controller: UISearchDisplayController, didShowSearchResultsTableView tableView: UITableView) {
        DidShowSearchResultsTableView!(controller, tableView)
    }
    @objc func searchDisplayController(controller: UISearchDisplayController, willHideSearchResultsTableView tableView: UITableView) {
        WillHideSearchResultsTableView!(controller, tableView)
    }
    @objc func searchDisplayController(controller: UISearchDisplayController, didHideSearchResultsTableView tableView: UITableView) {
        DidHideSearchResultsTableView!(controller, tableView)
    }
    @objc func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        return ShouldReloadTableForSearchString!(controller, searchString)
    }
    @objc func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        return ShouldReloadTableForSearchScope!(controller, searchOption)
    }
}
