//
//  CE_NSXMLParser.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import Foundation

public extension NSXMLParser {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NSXMLParser_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NSXMLParser_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: NSXMLParser_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is NSXMLParser_Delegate {
                return obj as! NSXMLParser_Delegate
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
    
    internal func getDelegateInstance() -> NSXMLParser_Delegate {
        return NSXMLParser_Delegate()
    }
    
    public func ce_parserDidStartDocument(handle: (parser: NSXMLParser) -> Void) -> Self {
        ce._parserDidStartDocument = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserDidEndDocument(handle: (parser: NSXMLParser) -> Void) -> Self {
        ce._parserDidEndDocument = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser(handle: (parser: NSXMLParser, name: String, publicID: String?, systemID: String?) -> Void) -> Self {
        ce._parser = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndFoundUnparsedEntityDeclarationWithName(handle: (parser: NSXMLParser, name: String, publicID: String?, systemID: String?, notationName: String?) -> Void) -> Self {
        ce._parserAndFoundUnparsedEntityDeclarationWithName = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndFoundAttributeDeclarationWithName(handle: (parser: NSXMLParser, attributeName: String, elementName: String, type: String?, defaultValue: String?) -> Void) -> Self {
        ce._parserAndFoundAttributeDeclarationWithName = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndFoundElementDeclarationWithName(handle: (parser: NSXMLParser, elementName: String, model: String) -> Void) -> Self {
        ce._parserAndFoundElementDeclarationWithName = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndFoundInternalEntityDeclarationWithName(handle: (parser: NSXMLParser, name: String, value: String?) -> Void) -> Self {
        ce._parserAndFoundInternalEntityDeclarationWithName = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndFoundExternalEntityDeclarationWithName(handle: (parser: NSXMLParser, name: String, publicID: String?, systemID: String?) -> Void) -> Self {
        ce._parserAndFoundExternalEntityDeclarationWithName = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndDidStartElement(handle: (parser: NSXMLParser, elementName: String, namespaceURI: String?, qName: String?, attributeDict: [String : String]) -> Void) -> Self {
        ce._parserAndDidStartElement = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndDidEndElement(handle: (parser: NSXMLParser, elementName: String, namespaceURI: String?, qName: String?) -> Void) -> Self {
        ce._parserAndDidEndElement = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndDidStartMappingPrefix(handle: (parser: NSXMLParser, prefix: String, namespaceURI: String) -> Void) -> Self {
        ce._parserAndDidStartMappingPrefix = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndDidEndMappingPrefix(handle: (parser: NSXMLParser, prefix: String) -> Void) -> Self {
        ce._parserAndDidEndMappingPrefix = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndFoundCharacters(handle: (parser: NSXMLParser, string: String) -> Void) -> Self {
        ce._parserAndFoundCharacters = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndFoundIgnorableWhitespace(handle: (parser: NSXMLParser, whitespaceString: String) -> Void) -> Self {
        ce._parserAndFoundIgnorableWhitespace = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndFoundProcessingInstructionWithTarget(handle: (parser: NSXMLParser, target: String, data: String?) -> Void) -> Self {
        ce._parserAndFoundProcessingInstructionWithTarget = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndFoundComment(handle: (parser: NSXMLParser, comment: String) -> Void) -> Self {
        ce._parserAndFoundComment = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndFoundCDATA(handle: (parser: NSXMLParser, CDATABlock: NSData) -> Void) -> Self {
        ce._parserAndFoundCDATA = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndResolveExternalEntityName(handle: (parser: NSXMLParser, name: String, systemID: String?) -> NSData?) -> Self {
        ce._parserAndResolveExternalEntityName = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndParseErrorOccurred(handle: (parser: NSXMLParser, parseError: NSError) -> Void) -> Self {
        ce._parserAndParseErrorOccurred = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserAndValidationErrorOccurred(handle: (parser: NSXMLParser, validationError: NSError) -> Void) -> Self {
        ce._parserAndValidationErrorOccurred = handle
        rebindingDelegate()
        return self
    }
    
}

internal class NSXMLParser_Delegate: NSObject, NSXMLParserDelegate {
    
    var _parserDidStartDocument: ((NSXMLParser) -> Void)?
    var _parserDidEndDocument: ((NSXMLParser) -> Void)?
    var _parser: ((NSXMLParser, String, String?, String?) -> Void)?
    var _parserAndFoundUnparsedEntityDeclarationWithName: ((NSXMLParser, String, String?, String?, String?) -> Void)?
    var _parserAndFoundAttributeDeclarationWithName: ((NSXMLParser, String, String, String?, String?) -> Void)?
    var _parserAndFoundElementDeclarationWithName: ((NSXMLParser, String, String) -> Void)?
    var _parserAndFoundInternalEntityDeclarationWithName: ((NSXMLParser, String, String?) -> Void)?
    var _parserAndFoundExternalEntityDeclarationWithName: ((NSXMLParser, String, String?, String?) -> Void)?
    var _parserAndDidStartElement: ((NSXMLParser, String, String?, String?, [String : String]) -> Void)?
    var _parserAndDidEndElement: ((NSXMLParser, String, String?, String?) -> Void)?
    var _parserAndDidStartMappingPrefix: ((NSXMLParser, String, String) -> Void)?
    var _parserAndDidEndMappingPrefix: ((NSXMLParser, String) -> Void)?
    var _parserAndFoundCharacters: ((NSXMLParser, String) -> Void)?
    var _parserAndFoundIgnorableWhitespace: ((NSXMLParser, String) -> Void)?
    var _parserAndFoundProcessingInstructionWithTarget: ((NSXMLParser, String, String?) -> Void)?
    var _parserAndFoundComment: ((NSXMLParser, String) -> Void)?
    var _parserAndFoundCDATA: ((NSXMLParser, NSData) -> Void)?
    var _parserAndResolveExternalEntityName: ((NSXMLParser, String, String?) -> NSData?)?
    var _parserAndParseErrorOccurred: ((NSXMLParser, NSError) -> Void)?
    var _parserAndValidationErrorOccurred: ((NSXMLParser, NSError) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "parserDidStartDocument:" : _parserDidStartDocument,
            "parserDidEndDocument:" : _parserDidEndDocument,
            "parser:foundNotationDeclarationWithName:publicID:systemID:" : _parser,
            "parser:foundUnparsedEntityDeclarationWithName:publicID:systemID:notationName:" : _parserAndFoundUnparsedEntityDeclarationWithName,
            "parser:foundAttributeDeclarationWithName:forElement:type:defaultValue:" : _parserAndFoundAttributeDeclarationWithName,
            "parser:foundElementDeclarationWithName:model:" : _parserAndFoundElementDeclarationWithName,
            "parser:foundInternalEntityDeclarationWithName:value:" : _parserAndFoundInternalEntityDeclarationWithName,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            "parser:foundExternalEntityDeclarationWithName:publicID:systemID:" : _parserAndFoundExternalEntityDeclarationWithName,
            "parser:didStartElement:namespaceURI:qualifiedName:attributes:" : _parserAndDidStartElement,
            "parser:didEndElement:namespaceURI:qualifiedName:" : _parserAndDidEndElement,
            "parser:didStartMappingPrefix:toURI:" : _parserAndDidStartMappingPrefix,
            "parser:didEndMappingPrefix:" : _parserAndDidEndMappingPrefix,
            "parser:foundCharacters:" : _parserAndFoundCharacters,
            "parser:foundIgnorableWhitespace:" : _parserAndFoundIgnorableWhitespace,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        let funcDic3: [Selector : Any?] = [
            "parser:foundProcessingInstructionWithTarget:data:" : _parserAndFoundProcessingInstructionWithTarget,
            "parser:foundComment:" : _parserAndFoundComment,
            "parser:foundCDATA:" : _parserAndFoundCDATA,
            "parser:resolveExternalEntityName:systemID:" : _parserAndResolveExternalEntityName,
            "parser:parseErrorOccurred:" : _parserAndParseErrorOccurred,
            "parser:validationErrorOccurred:" : _parserAndValidationErrorOccurred,
        ]
        if let f = funcDic3[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func parserDidStartDocument(parser: NSXMLParser) {
        _parserDidStartDocument!(parser)
    }
    @objc func parserDidEndDocument(parser: NSXMLParser) {
        _parserDidEndDocument!(parser)
    }
    @objc func parser(parser: NSXMLParser, foundNotationDeclarationWithName name: String, publicID: String?, systemID: String?) {
        _parser!(parser, name, publicID, systemID)
    }
    @objc func parser(parser: NSXMLParser, foundUnparsedEntityDeclarationWithName name: String, publicID: String?, systemID: String?, notationName: String?) {
        _parserAndFoundUnparsedEntityDeclarationWithName!(parser, name, publicID, systemID, notationName)
    }
    @objc func parser(parser: NSXMLParser, foundAttributeDeclarationWithName attributeName: String, forElement elementName: String, type: String?, defaultValue: String?) {
        _parserAndFoundAttributeDeclarationWithName!(parser, attributeName, elementName, type, defaultValue)
    }
    @objc func parser(parser: NSXMLParser, foundElementDeclarationWithName elementName: String, model: String) {
        _parserAndFoundElementDeclarationWithName!(parser, elementName, model)
    }
    @objc func parser(parser: NSXMLParser, foundInternalEntityDeclarationWithName name: String, value: String?) {
        _parserAndFoundInternalEntityDeclarationWithName!(parser, name, value)
    }
    @objc func parser(parser: NSXMLParser, foundExternalEntityDeclarationWithName name: String, publicID: String?, systemID: String?) {
        _parserAndFoundExternalEntityDeclarationWithName!(parser, name, publicID, systemID)
    }
    @objc func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        _parserAndDidStartElement!(parser, elementName, namespaceURI, qName, attributeDict)
    }
    @objc func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        _parserAndDidEndElement!(parser, elementName, namespaceURI, qName)
    }
    @objc func parser(parser: NSXMLParser, didStartMappingPrefix prefix: String, toURI namespaceURI: String) {
        _parserAndDidStartMappingPrefix!(parser, prefix, namespaceURI)
    }
    @objc func parser(parser: NSXMLParser, didEndMappingPrefix prefix: String) {
        _parserAndDidEndMappingPrefix!(parser, prefix)
    }
    @objc func parser(parser: NSXMLParser, foundCharacters string: String) {
        _parserAndFoundCharacters!(parser, string)
    }
    @objc func parser(parser: NSXMLParser, foundIgnorableWhitespace whitespaceString: String) {
        _parserAndFoundIgnorableWhitespace!(parser, whitespaceString)
    }
    @objc func parser(parser: NSXMLParser, foundProcessingInstructionWithTarget target: String, data: String?) {
        _parserAndFoundProcessingInstructionWithTarget!(parser, target, data)
    }
    @objc func parser(parser: NSXMLParser, foundComment comment: String) {
        _parserAndFoundComment!(parser, comment)
    }
    @objc func parser(parser: NSXMLParser, foundCDATA CDATABlock: NSData) {
        _parserAndFoundCDATA!(parser, CDATABlock)
    }
    @objc func parser(parser: NSXMLParser, resolveExternalEntityName name: String, systemID: String?) -> NSData? {
        return _parserAndResolveExternalEntityName!(parser, name, systemID)
    }
    @objc func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        _parserAndParseErrorOccurred!(parser, parseError)
    }
    @objc func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        _parserAndValidationErrorOccurred!(parser, validationError)
    }
}
