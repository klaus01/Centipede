//
//  CE_UISearchController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UISearchController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UISearchController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UISearchController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UISearchController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj = self.delegate {
            if obj is UISearchController_Delegate {
                return obj as! UISearchController_Delegate
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
        self.searchResultsUpdater = nil
        self.searchResultsUpdater = delegate
        self.transitioningDelegate = nil
        self.transitioningDelegate = delegate
    }
    
    internal override func getDelegateInstance() -> UISearchController_Delegate {
        return UISearchController_Delegate()
    }
    
    public func ce_updateSearchResultsFor(handle: (searchController: UISearchController) -> Void) -> Self {
        ce._updateSearchResultsFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_willPresent(handle: (searchController: UISearchController) -> Void) -> Self {
        ce._willPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_didPresent(handle: (searchController: UISearchController) -> Void) -> Self {
        ce._didPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_willDismiss(handle: (searchController: UISearchController) -> Void) -> Self {
        ce._willDismiss = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDismiss(handle: (searchController: UISearchController) -> Void) -> Self {
        ce._didDismiss = handle
        rebindingDelegate()
        return self
    }
    public func ce_present(handle: (searchController: UISearchController) -> Void) -> Self {
        ce._present = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UISearchController_Delegate: UIViewController_Delegate, UISearchResultsUpdating, UISearchControllerDelegate {
    
    var _updateSearchResultsFor: ((UISearchController) -> Void)?
    var _willPresent: ((UISearchController) -> Void)?
    var _didPresent: ((UISearchController) -> Void)?
    var _willDismiss: ((UISearchController) -> Void)?
    var _didDismiss: ((UISearchController) -> Void)?
    var _present: ((UISearchController) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "updateSearchResultsForSearchController:" : _updateSearchResultsFor,
            "willPresentSearchController:" : _willPresent,
            "didPresentSearchController:" : _didPresent,
            "willDismissSearchController:" : _willDismiss,
            "didDismissSearchController:" : _didDismiss,
            "presentSearchController:" : _present,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func updateSearchResultsForSearchController(searchController: UISearchController) {
        _updateSearchResultsFor!(searchController)
    }
    @objc func willPresentSearchController(searchController: UISearchController) {
        _willPresent!(searchController)
    }
    @objc func didPresentSearchController(searchController: UISearchController) {
        _didPresent!(searchController)
    }
    @objc func willDismissSearchController(searchController: UISearchController) {
        _willDismiss!(searchController)
    }
    @objc func didDismissSearchController(searchController: UISearchController) {
        _didDismiss!(searchController)
    }
    @objc func presentSearchController(searchController: UISearchController) {
        _present!(searchController)
    }
}
