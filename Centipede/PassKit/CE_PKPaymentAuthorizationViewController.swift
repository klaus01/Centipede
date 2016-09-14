//
//  CE_PKPaymentAuthorizationViewController.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
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
    
    @discardableResult
    public func ce_paymentAuthorizationViewController_didAuthorizePayment(handle: @escaping (PKPaymentAuthorizationViewController, PKPayment, @escaping (PKPaymentAuthorizationStatus) -> Void) -> Void) -> Self {
        ce._paymentAuthorizationViewController_didAuthorizePayment = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_paymentAuthorizationViewControllerDidFinish(handle: @escaping (PKPaymentAuthorizationViewController) -> Void) -> Self {
        ce._paymentAuthorizationViewControllerDidFinish = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_paymentAuthorizationViewController_didSelect(handle: @escaping (PKPaymentAuthorizationViewController, PKShippingMethod, @escaping (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) -> Void) -> Self {
        ce._paymentAuthorizationViewController_didSelect = handle
        rebindingDelegate()
        return self
    }
    
}

internal class PKPaymentAuthorizationViewController_Delegate: UIViewController_Delegate, PKPaymentAuthorizationViewControllerDelegate {
    
    var _paymentAuthorizationViewController_didAuthorizePayment: ((PKPaymentAuthorizationViewController, PKPayment, @escaping (PKPaymentAuthorizationStatus) -> Void) -> Void)?
    var _paymentAuthorizationViewControllerDidFinish: ((PKPaymentAuthorizationViewController) -> Void)?
    var _paymentAuthorizationViewController_didSelect: ((PKPaymentAuthorizationViewController, PKShippingMethod, @escaping (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(paymentAuthorizationViewController(_:didAuthorizePayment:completion:)) : _paymentAuthorizationViewController_didAuthorizePayment,
            #selector(paymentAuthorizationViewControllerDidFinish(_:)) : _paymentAuthorizationViewControllerDidFinish,
            #selector(paymentAuthorizationViewController(_:didSelect:completion:)) : _paymentAuthorizationViewController_didSelect,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        _paymentAuthorizationViewController_didAuthorizePayment!(controller, payment, completion)
    }
    @objc func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        _paymentAuthorizationViewControllerDidFinish!(controller)
    }
    @objc func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didSelect shippingMethod: PKShippingMethod, completion: @escaping (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) {
        _paymentAuthorizationViewController_didSelect!(controller, shippingMethod, completion)
    }
}
