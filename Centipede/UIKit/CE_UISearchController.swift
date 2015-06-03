//
//  CE_UISearchController.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UISearchController {
    
    private var ce: UISearchController_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UISearchController_Delegate {
            return obj
        }
        if let delegate = self.delegate {
            if delegate is UISearchController_Delegate {
                return delegate as! UISearchController_Delegate
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
        self.searchResultsUpdater = nil
        self.searchResultsUpdater = delegate
        self.transitioningDelegate = nil
        self.transitioningDelegate = delegate
    }
    
    internal override func getDelegateInstance() -> UISearchController_Delegate {
        return UISearchController_Delegate()
    }
    
    public func ce_UpdateSearchResultsFor(handle: (searchController: UISearchController) -> Void) -> Self {
        ce.UpdateSearchResultsFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillPresent(handle: (searchController: UISearchController) -> Void) -> Self {
        ce.WillPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidPresent(handle: (searchController: UISearchController) -> Void) -> Self {
        ce.DidPresent = handle
        rebindingDelegate()
        return self
    }
    public func ce_WillDismiss(handle: (searchController: UISearchController) -> Void) -> Self {
        ce.WillDismiss = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidDismiss(handle: (searchController: UISearchController) -> Void) -> Self {
        ce.DidDismiss = handle
        rebindingDelegate()
        return self
    }
    public func ce_Present(handle: (searchController: UISearchController) -> Void) -> Self {
        ce.Present = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UISearchController_Delegate: UIViewController_Delegate, UISearchResultsUpdating, UISearchControllerDelegate {
    
    var UpdateSearchResultsFor: ((UISearchController) -> Void)?
    var WillPresent: ((UISearchController) -> Void)?
    var DidPresent: ((UISearchController) -> Void)?
    var WillDismiss: ((UISearchController) -> Void)?
    var DidDismiss: ((UISearchController) -> Void)?
    var Present: ((UISearchController) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "updateSearchResultsForSearchController:" : UpdateSearchResultsFor,
            "willPresentSearchController:" : WillPresent,
            "didPresentSearchController:" : DidPresent,
            "willDismissSearchController:" : WillDismiss,
            "didDismissSearchController:" : DidDismiss,
            "presentSearchController:" : Present,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func updateSearchResultsForSearchController(searchController: UISearchController) {
        UpdateSearchResultsFor!(searchController)
    }
    @objc func willPresentSearchController(searchController: UISearchController) {
        WillPresent!(searchController)
    }
    @objc func didPresentSearchController(searchController: UISearchController) {
        DidPresent!(searchController)
    }
    @objc func willDismissSearchController(searchController: UISearchController) {
        WillDismiss!(searchController)
    }
    @objc func didDismissSearchController(searchController: UISearchController) {
        DidDismiss!(searchController)
    }
    @objc func presentSearchController(searchController: UISearchController) {
        Present!(searchController)
    }
}
