//
//  CE_PKPaymentAuthorizationViewController.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import PassKit

public extension PKPaymentAuthorizationViewController {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: PKPaymentAuthorizationViewController_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? PKPaymentAuthorizationViewController_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: PKPaymentAuthorizationViewController_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is PKPaymentAuthorizationViewController_Delegate {
                return obj as! PKPaymentAuthorizationViewController_Delegate
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
    
    internal override func getDelegateInstance() -> PKPaymentAuthorizationViewController_Delegate {
        return PKPaymentAuthorizationViewController_Delegate()
    }
    
    public func ce_didAuthorizePayment(handle: (controller: PKPaymentAuthorizationViewController, payment: PKPayment, completion: (PKPaymentAuthorizationStatus) -> Void) -> Void) -> Self {
        ce._didAuthorizePayment = handle
        rebindingDelegate()
        return self
    }
    public func ce_didFinish(handle: (controller: PKPaymentAuthorizationViewController) -> Void) -> Self {
        ce._didFinish = handle
        rebindingDelegate()
        return self
    }
    public func ce_willAuthorizePayment(handle: (controller: PKPaymentAuthorizationViewController) -> Void) -> Self {
        ce._willAuthorizePayment = handle
        rebindingDelegate()
        return self
    }
    public func ce_didSelectShippingMethod(handle: (controller: PKPaymentAuthorizationViewController, shippingMethod: PKShippingMethod, completion: (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) -> Void) -> Self {
        ce._didSelectShippingMethod = handle
        rebindingDelegate()
        return self
    }
    public func ce_didSelectShippingAddress(handle: (controller: PKPaymentAuthorizationViewController, address: ABRecord, completion: (PKPaymentAuthorizationStatus, [PKShippingMethod], [PKPaymentSummaryItem]) -> Void) -> Void) -> Self {
        ce._didSelectShippingAddress = handle
        rebindingDelegate()
        return self
    }
    
}

internal class PKPaymentAuthorizationViewController_Delegate: UIViewController_Delegate, PKPaymentAuthorizationViewControllerDelegate {
    
    var _didAuthorizePayment: ((PKPaymentAuthorizationViewController, PKPayment, (PKPaymentAuthorizationStatus) -> Void) -> Void)?
    var _didFinish: ((PKPaymentAuthorizationViewController) -> Void)?
    var _willAuthorizePayment: ((PKPaymentAuthorizationViewController) -> Void)?
    var _didSelectShippingMethod: ((PKPaymentAuthorizationViewController, PKShippingMethod, (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) -> Void)?
    var _didSelectShippingAddress: ((PKPaymentAuthorizationViewController, ABRecord, (PKPaymentAuthorizationStatus, [PKShippingMethod], [PKPaymentSummaryItem]) -> Void) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "paymentAuthorizationViewController:didAuthorizePayment:completion:" : _didAuthorizePayment,
            "paymentAuthorizationViewControllerDidFinish:" : _didFinish,
            "paymentAuthorizationViewControllerWillAuthorizePayment:" : _willAuthorizePayment,
            "paymentAuthorizationViewController:didSelectShippingMethod:completion:" : _didSelectShippingMethod,
            "paymentAuthorizationViewController:didSelectShippingAddress:completion:" : _didSelectShippingAddress,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: ((PKPaymentAuthorizationStatus) -> Void)) -> Void {
        return _didAuthorizePayment!(controller, payment, completion)
    }
    @objc func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController) {
        _didFinish!(controller)
    }
    @objc func paymentAuthorizationViewControllerWillAuthorizePayment(controller: PKPaymentAuthorizationViewController) {
        _willAuthorizePayment!(controller)
    }
    @objc func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController, didSelectShippingMethod shippingMethod: PKShippingMethod, completion: (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) -> Void {
        return _didSelectShippingMethod!(controller, shippingMethod, completion)
    }
    @objc func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController, didSelectShippingAddress address: ABRecord, completion: (PKPaymentAuthorizationStatus, [PKShippingMethod], [PKPaymentSummaryItem]) -> Void) -> Void {
        return _didSelectShippingAddress!(controller, address, completion)
    }
}
