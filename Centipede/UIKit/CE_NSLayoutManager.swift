//
//  CE_NSLayoutManager.swift
//  Centipede
//
//  Created by kelei on 2016/9/14.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import UIKit

public extension NSLayoutManager {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NSLayoutManager_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NSLayoutManager_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: NSLayoutManager_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is NSLayoutManager_Delegate {
                return obj as! NSLayoutManager_Delegate
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
    
    internal func getDelegateInstance() -> NSLayoutManager_Delegate {
        return NSLayoutManager_Delegate()
    }
    
    public func ce_layoutManager_shouldGenerateGlyphs(handle: @escaping (NSLayoutManager, UnsafePointer<CGGlyph>, UnsafePointer<NSGlyphProperty>, UnsafePointer<Int>, UIFont, NSRange) -> Int) -> Self {
        ce._layoutManager_shouldGenerateGlyphs = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutManager_lineSpacingAfterGlyphAt(handle: @escaping (NSLayoutManager, Int, CGRect) -> CGFloat) -> Self {
        ce._layoutManager_lineSpacingAfterGlyphAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutManager_paragraphSpacingBeforeGlyphAt(handle: @escaping (NSLayoutManager, Int, CGRect) -> CGFloat) -> Self {
        ce._layoutManager_paragraphSpacingBeforeGlyphAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutManager_paragraphSpacingAfterGlyphAt(handle: @escaping (NSLayoutManager, Int, CGRect) -> CGFloat) -> Self {
        ce._layoutManager_paragraphSpacingAfterGlyphAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutManager_shouldUse(handle: @escaping (NSLayoutManager, NSControlCharacterAction, Int) -> NSControlCharacterAction) -> Self {
        ce._layoutManager_shouldUse = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutManager_shouldBreakLineByWordBeforeCharacterAt(handle: @escaping (NSLayoutManager, Int) -> Bool) -> Self {
        ce._layoutManager_shouldBreakLineByWordBeforeCharacterAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutManager_shouldBreakLineByHyphenatingBeforeCharacterAt(handle: @escaping (NSLayoutManager, Int) -> Bool) -> Self {
        ce._layoutManager_shouldBreakLineByHyphenatingBeforeCharacterAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutManager_boundingBoxForControlGlyphAt(handle: @escaping (NSLayoutManager, Int, NSTextContainer, CGRect, CGPoint, Int) -> CGRect) -> Self {
        ce._layoutManager_boundingBoxForControlGlyphAt = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutManagerDidInvalidateLayout(handle: @escaping (NSLayoutManager) -> Void) -> Self {
        ce._layoutManagerDidInvalidateLayout = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutManager_didCompleteLayoutFor(handle: @escaping (NSLayoutManager, NSTextContainer?, Bool) -> Void) -> Self {
        ce._layoutManager_didCompleteLayoutFor = handle
        rebindingDelegate()
        return self
    }
    public func ce_layoutManager_textContainer(handle: @escaping (NSLayoutManager, NSTextContainer, CGSize) -> Void) -> Self {
        ce._layoutManager_textContainer = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSLayoutManager_Delegate: NSObject, NSLayoutManagerDelegate {
    
    var _layoutManager_shouldGenerateGlyphs: ((NSLayoutManager, UnsafePointer<CGGlyph>, UnsafePointer<NSGlyphProperty>, UnsafePointer<Int>, UIFont, NSRange) -> Int)?
    var _layoutManager_lineSpacingAfterGlyphAt: ((NSLayoutManager, Int, CGRect) -> CGFloat)?
    var _layoutManager_paragraphSpacingBeforeGlyphAt: ((NSLayoutManager, Int, CGRect) -> CGFloat)?
    var _layoutManager_paragraphSpacingAfterGlyphAt: ((NSLayoutManager, Int, CGRect) -> CGFloat)?
    var _layoutManager_shouldUse: ((NSLayoutManager, NSControlCharacterAction, Int) -> NSControlCharacterAction)?
    var _layoutManager_shouldBreakLineByWordBeforeCharacterAt: ((NSLayoutManager, Int) -> Bool)?
    var _layoutManager_shouldBreakLineByHyphenatingBeforeCharacterAt: ((NSLayoutManager, Int) -> Bool)?
    var _layoutManager_boundingBoxForControlGlyphAt: ((NSLayoutManager, Int, NSTextContainer, CGRect, CGPoint, Int) -> CGRect)?
    var _layoutManagerDidInvalidateLayout: ((NSLayoutManager) -> Void)?
    var _layoutManager_didCompleteLayoutFor: ((NSLayoutManager, NSTextContainer?, Bool) -> Void)?
    var _layoutManager_textContainer: ((NSLayoutManager, NSTextContainer, CGSize) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(layoutManager(_:shouldGenerateGlyphs:properties:characterIndexes:font:forGlyphRange:)) : _layoutManager_shouldGenerateGlyphs,
            #selector(layoutManager(_:lineSpacingAfterGlyphAt:withProposedLineFragmentRect:)) : _layoutManager_lineSpacingAfterGlyphAt,
            #selector(layoutManager(_:paragraphSpacingBeforeGlyphAt:withProposedLineFragmentRect:)) : _layoutManager_paragraphSpacingBeforeGlyphAt,
            #selector(layoutManager(_:paragraphSpacingAfterGlyphAt:withProposedLineFragmentRect:)) : _layoutManager_paragraphSpacingAfterGlyphAt,
            #selector(layoutManager(_:shouldUse:forControlCharacterAt:)) : _layoutManager_shouldUse,
            #selector(layoutManager(_:shouldBreakLineByWordBeforeCharacterAt:)) : _layoutManager_shouldBreakLineByWordBeforeCharacterAt,
            #selector(layoutManager(_:shouldBreakLineByHyphenatingBeforeCharacterAt:)) : _layoutManager_shouldBreakLineByHyphenatingBeforeCharacterAt,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(layoutManager(_:boundingBoxForControlGlyphAt:for:proposedLineFragment:glyphPosition:characterIndex:)) : _layoutManager_boundingBoxForControlGlyphAt,
            #selector(layoutManagerDidInvalidateLayout(_:)) : _layoutManagerDidInvalidateLayout,
            #selector(layoutManager(_:didCompleteLayoutFor:atEnd:)) : _layoutManager_didCompleteLayoutFor,
            #selector(layoutManager(_:textContainer:didChangeGeometryFrom:)) : _layoutManager_textContainer,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func layoutManager(_ layoutManager: NSLayoutManager, shouldGenerateGlyphs glyphs: UnsafePointer<CGGlyph>, properties props: UnsafePointer<NSGlyphProperty>, characterIndexes charIndexes: UnsafePointer<Int>, font aFont: UIFont, forGlyphRange glyphRange: NSRange) -> Int {
        return _layoutManager_shouldGenerateGlyphs!(layoutManager, glyphs, props, charIndexes, aFont, glyphRange)
    }
    @objc func layoutManager(_ layoutManager: NSLayoutManager, lineSpacingAfterGlyphAt glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> CGFloat {
        return _layoutManager_lineSpacingAfterGlyphAt!(layoutManager, glyphIndex, rect)
    }
    @objc func layoutManager(_ layoutManager: NSLayoutManager, paragraphSpacingBeforeGlyphAt glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> CGFloat {
        return _layoutManager_paragraphSpacingBeforeGlyphAt!(layoutManager, glyphIndex, rect)
    }
    @objc func layoutManager(_ layoutManager: NSLayoutManager, paragraphSpacingAfterGlyphAt glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> CGFloat {
        return _layoutManager_paragraphSpacingAfterGlyphAt!(layoutManager, glyphIndex, rect)
    }
    @objc func layoutManager(_ layoutManager: NSLayoutManager, shouldUse action: NSControlCharacterAction, forControlCharacterAt charIndex: Int) -> NSControlCharacterAction {
        return _layoutManager_shouldUse!(layoutManager, action, charIndex)
    }
    @objc func layoutManager(_ layoutManager: NSLayoutManager, shouldBreakLineByWordBeforeCharacterAt charIndex: Int) -> Bool {
        return _layoutManager_shouldBreakLineByWordBeforeCharacterAt!(layoutManager, charIndex)
    }
    @objc func layoutManager(_ layoutManager: NSLayoutManager, shouldBreakLineByHyphenatingBeforeCharacterAt charIndex: Int) -> Bool {
        return _layoutManager_shouldBreakLineByHyphenatingBeforeCharacterAt!(layoutManager, charIndex)
    }
    @objc func layoutManager(_ layoutManager: NSLayoutManager, boundingBoxForControlGlyphAt glyphIndex: Int, for textContainer: NSTextContainer, proposedLineFragment proposedRect: CGRect, glyphPosition: CGPoint, characterIndex charIndex: Int) -> CGRect {
        return _layoutManager_boundingBoxForControlGlyphAt!(layoutManager, glyphIndex, textContainer, proposedRect, glyphPosition, charIndex)
    }
    @objc func layoutManagerDidInvalidateLayout(_ sender: NSLayoutManager) {
        _layoutManagerDidInvalidateLayout!(sender)
    }
    @objc func layoutManager(_ layoutManager: NSLayoutManager, didCompleteLayoutFor textContainer: NSTextContainer?, atEnd layoutFinishedFlag: Bool) {
        _layoutManager_didCompleteLayoutFor!(layoutManager, textContainer, layoutFinishedFlag)
    }
    @objc func layoutManager(_ layoutManager: NSLayoutManager, textContainer: NSTextContainer, didChangeGeometryFrom oldSize: CGSize) {
        _layoutManager_textContainer!(layoutManager, textContainer, oldSize)
    }
}
