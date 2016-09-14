//
//  CE_UISearchController.swift
//  Centipede
//
//  Created by kelei on 2016/9/14.
//  Copyright (c) 2016年 kelei. All rights reserved.
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
        if let obj: AnyObject = self.delegate {
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
    
    public func ce_updateSearchResults_for(handle: @escaping (UISearchController) -> Void) -> Self {
        ce._updateSearchResults_for = handle
        rebindingDelegate()
        return self
    }
    public func ce_willPresentSearchController(handle: @escaping (UISearchController) -> Void) -> Self {
        ce._willPresentSearchController = handle
        rebindingDelegate()
        return self
    }
    public func ce_didPresentSearchController(handle: @escaping (UISearchController) -> Void) -> Self {
        ce._didPresentSearchController = handle
        rebindingDelegate()
        return self
    }
    public func ce_willDismissSearchController(handle: @escaping (UISearchController) -> Void) -> Self {
        ce._willDismissSearchController = handle
        rebindingDelegate()
        return self
    }
    public func ce_didDismissSearchController(handle: @escaping (UISearchController) -> Void) -> Self {
        ce._didDismissSearchController = handle
        rebindingDelegate()
        return self
    }
    public func ce_presentSearchController(handle: @escaping (UISearchController) -> Void) -> Self {
        ce._presentSearchController = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UISearchController_Delegate: UIViewController_Delegate, UISearchResultsUpdating, UISearchControllerDelegate {
    
    var _updateSearchResults_for: ((UISearchController) -> Void)?
    var _willPresentSearchController: ((UISearchController) -> Void)?
    var _didPresentSearchController: ((UISearchController) -> Void)?
    var _willDismissSearchController: ((UISearchController) -> Void)?
    var _didDismissSearchController: ((UISearchController) -> Void)?
    var _presentSearchController: ((UISearchController) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(updateSearchResults(for:)) : _updateSearchResults_for,
            #selector(willPresentSearchController(_:)) : _willPresentSearchController,
            #selector(didPresentSearchController(_:)) : _didPresentSearchController,
            #selector(willDismissSearchController(_:)) : _willDismissSearchController,
            #selector(didDismissSearchController(_:)) : _didDismissSearchController,
            #selector(presentSearchController(_:)) : _presentSearchController,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func updateSearchResults(for searchController: UISearchController) {
        _updateSearchResults_for!(searchController)
    }
    @objc func willPresentSearchController(_ searchController: UISearchController) {
        _willPresentSearchController!(searchController)
    }
    @objc func didPresentSearchController(_ searchController: UISearchController) {
        _didPresentSearchController!(searchController)
    }
    @objc func willDismissSearchController(_ searchController: UISearchController) {
        _willDismissSearchController!(searchController)
    }
    @objc func didDismissSearchController(_ searchController: UISearchController) {
        _didDismissSearchController!(searchController)
    }
    @objc func presentSearchController(_ searchController: UISearchController) {
        _presentSearchController!(searchController)
    }
}
