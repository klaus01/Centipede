//
//  CE_UIPickerView.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

extension UIPickerView {
    
    private var ce: UIPickerView_Delegate {
        struct Static {
            static var AssociationKey: UInt8 = 0
        }
        if let obj = objc_getAssociatedObject(self, &Static.AssociationKey) as? UIPickerView_Delegate {
            return obj
        }
        if let delegate = self.dataSource {
            if delegate is UIPickerView_Delegate {
                return delegate as! UIPickerView_Delegate
            }
        }
        let delegate = getDelegateInstance()
        objc_setAssociatedObject(self, &Static.AssociationKey, delegate, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        return delegate
    }
    
    private func rebindingDelegate() {
        let delegate = ce
        self.dataSource = nil
        self.dataSource = delegate
        self.delegate = nil
        self.delegate = delegate
    }
    
    internal func getDelegateInstance() -> UIPickerView_Delegate {
        return UIPickerView_Delegate()
    }
    
    public func ce_NumberOfComponentsIn(handle: (pickerView: UIPickerView) -> Int) -> Self {
        ce.NumberOfComponentsIn = handle
        rebindingDelegate()
        return self
    }
    public func ce_NumberOfRowsInComponent(handle: (pickerView: UIPickerView, component: Int) -> Int) -> Self {
        ce.NumberOfRowsInComponent = handle
        rebindingDelegate()
        return self
    }
    public func ce_WidthForComponent(handle: (pickerView: UIPickerView, component: Int) -> CGFloat) -> Self {
        ce.WidthForComponent = handle
        rebindingDelegate()
        return self
    }
    public func ce_RowHeightForComponent(handle: (pickerView: UIPickerView, component: Int) -> CGFloat) -> Self {
        ce.RowHeightForComponent = handle
        rebindingDelegate()
        return self
    }
    public func ce_TitleForRow(handle: (pickerView: UIPickerView, row: Int, component: Int) -> String!) -> Self {
        ce.TitleForRow = handle
        rebindingDelegate()
        return self
    }
    public func ce_AttributedTitleForRow(handle: (pickerView: UIPickerView, row: Int, component: Int) -> NSAttributedString?) -> Self {
        ce.AttributedTitleForRow = handle
        rebindingDelegate()
        return self
    }
    public func ce_ViewForRow(handle: (pickerView: UIPickerView, row: Int, component: Int, view: UIView!) -> UIView) -> Self {
        ce.ViewForRow = handle
        rebindingDelegate()
        return self
    }
    public func ce_DidSelectRow(handle: (pickerView: UIPickerView, row: Int, component: Int) -> Void) -> Self {
        ce.DidSelectRow = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPickerView_Delegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var NumberOfComponentsIn: ((UIPickerView) -> Int)?
    var NumberOfRowsInComponent: ((UIPickerView, Int) -> Int)?
    var WidthForComponent: ((UIPickerView, Int) -> CGFloat)?
    var RowHeightForComponent: ((UIPickerView, Int) -> CGFloat)?
    var TitleForRow: ((UIPickerView, Int, Int) -> String!)?
    var AttributedTitleForRow: ((UIPickerView, Int, Int) -> NSAttributedString?)?
    var ViewForRow: ((UIPickerView, Int, Int, UIView!) -> UIView)?
    var DidSelectRow: ((UIPickerView, Int, Int) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "numberOfComponentsInPickerView:" : NumberOfComponentsIn,
            "pickerView:numberOfRowsInComponent:" : NumberOfRowsInComponent,
            "pickerView:widthForComponent:" : WidthForComponent,
            "pickerView:rowHeightForComponent:" : RowHeightForComponent,
            "pickerView:titleForRow:forComponent:" : TitleForRow,
            "pickerView:attributedTitleForRow:forComponent:" : AttributedTitleForRow,
            "pickerView:viewForRow:forComponent:reusingView:" : ViewForRow,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "pickerView:didSelectRow:inComponent:" : DidSelectRow,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return NumberOfComponentsIn!(pickerView)
    }
    @objc func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return NumberOfRowsInComponent!(pickerView, component)
    }
    @objc func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return WidthForComponent!(pickerView, component)
    }
    @objc func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return RowHeightForComponent!(pickerView, component)
    }
    @objc func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return TitleForRow!(pickerView, row, component)
    }
    @objc func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return AttributedTitleForRow!(pickerView, row, component)
    }
    @objc func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        return ViewForRow!(pickerView, row, component, view)
    }
    @objc func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DidSelectRow!(pickerView, row, component)
    }
}
