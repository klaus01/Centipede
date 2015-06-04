//
//  CE_UIPickerView.swift
//  Centipede
//
//  Created by kelei on 2015/6/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import UIKit

public extension UIPickerView {
    
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
    
    public func ce_numberOfComponentsIn(handle: (pickerView: UIPickerView) -> Int) -> Self {
        ce._numberOfComponentsIn = handle
        rebindingDelegate()
        return self
    }
    public func ce_numberOfRowsInComponent(handle: (pickerView: UIPickerView, component: Int) -> Int) -> Self {
        ce._numberOfRowsInComponent = handle
        rebindingDelegate()
        return self
    }
    public func ce_widthForComponent(handle: (pickerView: UIPickerView, component: Int) -> CGFloat) -> Self {
        ce._widthForComponent = handle
        rebindingDelegate()
        return self
    }
    public func ce_rowHeightForComponent(handle: (pickerView: UIPickerView, component: Int) -> CGFloat) -> Self {
        ce._rowHeightForComponent = handle
        rebindingDelegate()
        return self
    }
    public func ce_titleForRow(handle: (pickerView: UIPickerView, row: Int, component: Int) -> String!) -> Self {
        ce._titleForRow = handle
        rebindingDelegate()
        return self
    }
    public func ce_attributedTitleForRow(handle: (pickerView: UIPickerView, row: Int, component: Int) -> NSAttributedString?) -> Self {
        ce._attributedTitleForRow = handle
        rebindingDelegate()
        return self
    }
    public func ce_viewForRow(handle: (pickerView: UIPickerView, row: Int, component: Int, view: UIView!) -> UIView) -> Self {
        ce._viewForRow = handle
        rebindingDelegate()
        return self
    }
    public func ce_didSelectRow(handle: (pickerView: UIPickerView, row: Int, component: Int) -> Void) -> Self {
        ce._didSelectRow = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPickerView_Delegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var _numberOfComponentsIn: ((UIPickerView) -> Int)?
    var _numberOfRowsInComponent: ((UIPickerView, Int) -> Int)?
    var _widthForComponent: ((UIPickerView, Int) -> CGFloat)?
    var _rowHeightForComponent: ((UIPickerView, Int) -> CGFloat)?
    var _titleForRow: ((UIPickerView, Int, Int) -> String!)?
    var _attributedTitleForRow: ((UIPickerView, Int, Int) -> NSAttributedString?)?
    var _viewForRow: ((UIPickerView, Int, Int, UIView!) -> UIView)?
    var _didSelectRow: ((UIPickerView, Int, Int) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "numberOfComponentsInPickerView:" : _numberOfComponentsIn,
            "pickerView:numberOfRowsInComponent:" : _numberOfRowsInComponent,
            "pickerView:widthForComponent:" : _widthForComponent,
            "pickerView:rowHeightForComponent:" : _rowHeightForComponent,
            "pickerView:titleForRow:forComponent:" : _titleForRow,
            "pickerView:attributedTitleForRow:forComponent:" : _attributedTitleForRow,
            "pickerView:viewForRow:forComponent:reusingView:" : _viewForRow,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "pickerView:didSelectRow:inComponent:" : _didSelectRow,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return _numberOfComponentsIn!(pickerView)
    }
    @objc func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return _numberOfRowsInComponent!(pickerView, component)
    }
    @objc func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return _widthForComponent!(pickerView, component)
    }
    @objc func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return _rowHeightForComponent!(pickerView, component)
    }
    @objc func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return _titleForRow!(pickerView, row, component)
    }
    @objc func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return _attributedTitleForRow!(pickerView, row, component)
    }
    @objc func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        return _viewForRow!(pickerView, row, component, view)
    }
    @objc func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _didSelectRow!(pickerView, row, component)
    }
}
