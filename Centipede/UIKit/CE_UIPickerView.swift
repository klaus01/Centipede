//
//  CE_UIPickerView.swift
//  Centipede
//
//  Created by kelei on 2016/9/15.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension UIPickerView {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: UIPickerView_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? UIPickerView_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: UIPickerView_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.dataSource {
            if obj is UIPickerView_Delegate {
                return obj as! UIPickerView_Delegate
            }
        }
        let obj = getDelegateInstance()
        _delegate = obj
        return obj
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
    
    @discardableResult
    public func ce_numberOfComponents_in(handle: @escaping (UIPickerView) -> Int) -> Self {
        ce._numberOfComponents_in = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_pickerView_numberOfRowsInComponent(handle: @escaping (UIPickerView, Int) -> Int) -> Self {
        ce._pickerView_numberOfRowsInComponent = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_pickerView_widthForComponent(handle: @escaping (UIPickerView, Int) -> CGFloat) -> Self {
        ce._pickerView_widthForComponent = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_pickerView_rowHeightForComponent(handle: @escaping (UIPickerView, Int) -> CGFloat) -> Self {
        ce._pickerView_rowHeightForComponent = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_pickerView_titleForRow(handle: @escaping (UIPickerView, Int, Int) -> String?) -> Self {
        ce._pickerView_titleForRow = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_pickerView_attributedTitleForRow(handle: @escaping (UIPickerView, Int, Int) -> NSAttributedString?) -> Self {
        ce._pickerView_attributedTitleForRow = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_pickerView_viewForRow(handle: @escaping (UIPickerView, Int, Int, UIView?) -> UIView) -> Self {
        ce._pickerView_viewForRow = handle
        rebindingDelegate()
        return self
    }
    @discardableResult
    public func ce_pickerView_didSelectRow(handle: @escaping (UIPickerView, Int, Int) -> Void) -> Self {
        ce._pickerView_didSelectRow = handle
        rebindingDelegate()
        return self
    }
    
}

internal class UIPickerView_Delegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var _numberOfComponents_in: ((UIPickerView) -> Int)?
    var _pickerView_numberOfRowsInComponent: ((UIPickerView, Int) -> Int)?
    var _pickerView_widthForComponent: ((UIPickerView, Int) -> CGFloat)?
    var _pickerView_rowHeightForComponent: ((UIPickerView, Int) -> CGFloat)?
    var _pickerView_titleForRow: ((UIPickerView, Int, Int) -> String?)?
    var _pickerView_attributedTitleForRow: ((UIPickerView, Int, Int) -> NSAttributedString?)?
    var _pickerView_viewForRow: ((UIPickerView, Int, Int, UIView?) -> UIView)?
    var _pickerView_didSelectRow: ((UIPickerView, Int, Int) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(numberOfComponents(in:)) : _numberOfComponents_in,
            #selector(pickerView(_:numberOfRowsInComponent:)) : _pickerView_numberOfRowsInComponent,
            #selector(pickerView(_:widthForComponent:)) : _pickerView_widthForComponent,
            #selector(pickerView(_:rowHeightForComponent:)) : _pickerView_rowHeightForComponent,
            #selector(pickerView(_:titleForRow:forComponent:)) : _pickerView_titleForRow,
            #selector(pickerView(_:attributedTitleForRow:forComponent:)) : _pickerView_attributedTitleForRow,
            #selector(pickerView(_:viewForRow:forComponent:reusing:)) : _pickerView_viewForRow,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(pickerView(_:didSelectRow:inComponent:)) : _pickerView_didSelectRow,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return _numberOfComponents_in!(pickerView)
    }
    @objc func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return _pickerView_numberOfRowsInComponent!(pickerView, component)
    }
    @objc func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return _pickerView_widthForComponent!(pickerView, component)
    }
    @objc func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return _pickerView_rowHeightForComponent!(pickerView, component)
    }
    @objc func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return _pickerView_titleForRow!(pickerView, row, component)
    }
    @objc func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return _pickerView_attributedTitleForRow!(pickerView, row, component)
    }
    @objc func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return _pickerView_viewForRow!(pickerView, row, component, view)
    }
    @objc func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _pickerView_didSelectRow!(pickerView, row, component)
    }
}
