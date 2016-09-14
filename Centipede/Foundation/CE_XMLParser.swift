//
//  CE_XMLParser.swift
//  Centipede
//
//  Created by kelei on 2016/9/14.
//  Copyright (c) 2016年 kelei. All rights reserved.
//

import Foundation

public extension XMLParser {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: XMLParser_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? XMLParser_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var ce: XMLParser_Delegate {
        if let obj = _delegate {
            return obj
        }
        if let obj: AnyObject = self.delegate {
            if obj is XMLParser_Delegate {
                return obj as! XMLParser_Delegate
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
    
    internal func getDelegateInstance() -> XMLParser_Delegate {
        return XMLParser_Delegate()
    }
    
    public func ce_parserDidStartDocument(handle: @escaping (XMLParser) -> Void) -> Self {
        ce._parserDidStartDocument = handle
        rebindingDelegate()
        return self
    }
    public func ce_parserDidEndDocument(handle: @escaping (XMLParser) -> Void) -> Self {
        ce._parserDidEndDocument = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_foundNotationDeclarationWithName(handle: @escaping (XMLParser, String, String?, String?) -> Void) -> Self {
        ce._parser_foundNotationDeclarationWithName = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_foundUnparsedEntityDeclarationWithName(handle: @escaping (XMLParser, String, String?, String?, String?) -> Void) -> Self {
        ce._parser_foundUnparsedEntityDeclarationWithName = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_foundAttributeDeclarationWithName(handle: @escaping (XMLParser, String, String, String?, String?) -> Void) -> Self {
        ce._parser_foundAttributeDeclarationWithName = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_foundElementDeclarationWithName(handle: @escaping (XMLParser, String, String) -> Void) -> Self {
        ce._parser_foundElementDeclarationWithName = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_foundInternalEntityDeclarationWithName(handle: @escaping (XMLParser, String, String?) -> Void) -> Self {
        ce._parser_foundInternalEntityDeclarationWithName = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_foundExternalEntityDeclarationWithName(handle: @escaping (XMLParser, String, String?, String?) -> Void) -> Self {
        ce._parser_foundExternalEntityDeclarationWithName = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_didStartElement(handle: @escaping (XMLParser, String, String?, String?, [String : String]) -> Void) -> Self {
        ce._parser_didStartElement = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_didEndElement(handle: @escaping (XMLParser, String, String?, String?) -> Void) -> Self {
        ce._parser_didEndElement = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_didStartMappingPrefix(handle: @escaping (XMLParser, String, String) -> Void) -> Self {
        ce._parser_didStartMappingPrefix = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_didEndMappingPrefix(handle: @escaping (XMLParser, String) -> Void) -> Self {
        ce._parser_didEndMappingPrefix = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_foundCharacters(handle: @escaping (XMLParser, String) -> Void) -> Self {
        ce._parser_foundCharacters = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_foundIgnorableWhitespace(handle: @escaping (XMLParser, String) -> Void) -> Self {
        ce._parser_foundIgnorableWhitespace = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_foundProcessingInstructionWithTarget(handle: @escaping (XMLParser, String, String?) -> Void) -> Self {
        ce._parser_foundProcessingInstructionWithTarget = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_foundComment(handle: @escaping (XMLParser, String) -> Void) -> Self {
        ce._parser_foundComment = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_foundCDATA(handle: @escaping (XMLParser, Data) -> Void) -> Self {
        ce._parser_foundCDATA = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_resolveExternalEntityName(handle: @escaping (XMLParser, String, String?) -> Data?) -> Self {
        ce._parser_resolveExternalEntityName = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_parseErrorOccurred(handle: @escaping (XMLParser, Error) -> Void) -> Self {
        ce._parser_parseErrorOccurred = handle
        rebindingDelegate()
        return self
    }
    public func ce_parser_validationErrorOccurred(handle: @escaping (XMLParser, Error) -> Void) -> Self {
        ce._parser_validationErrorOccurred = handle
        rebindingDelegate()
        return self
    }
    
}

internal class XMLParser_Delegate: NSObject, XMLParserDelegate {
    
    var _parserDidStartDocument: ((XMLParser) -> Void)?
    var _parserDidEndDocument: ((XMLParser) -> Void)?
    var _parser_foundNotationDeclarationWithName: ((XMLParser, String, String?, String?) -> Void)?
    var _parser_foundUnparsedEntityDeclarationWithName: ((XMLParser, String, String?, String?, String?) -> Void)?
    var _parser_foundAttributeDeclarationWithName: ((XMLParser, String, String, String?, String?) -> Void)?
    var _parser_foundElementDeclarationWithName: ((XMLParser, String, String) -> Void)?
    var _parser_foundInternalEntityDeclarationWithName: ((XMLParser, String, String?) -> Void)?
    var _parser_foundExternalEntityDeclarationWithName: ((XMLParser, String, String?, String?) -> Void)?
    var _parser_didStartElement: ((XMLParser, String, String?, String?, [String : String]) -> Void)?
    var _parser_didEndElement: ((XMLParser, String, String?, String?) -> Void)?
    var _parser_didStartMappingPrefix: ((XMLParser, String, String) -> Void)?
    var _parser_didEndMappingPrefix: ((XMLParser, String) -> Void)?
    var _parser_foundCharacters: ((XMLParser, String) -> Void)?
    var _parser_foundIgnorableWhitespace: ((XMLParser, String) -> Void)?
    var _parser_foundProcessingInstructionWithTarget: ((XMLParser, String, String?) -> Void)?
    var _parser_foundComment: ((XMLParser, String) -> Void)?
    var _parser_foundCDATA: ((XMLParser, Data) -> Void)?
    var _parser_resolveExternalEntityName: ((XMLParser, String, String?) -> Data?)?
    var _parser_parseErrorOccurred: ((XMLParser, Error) -> Void)?
    var _parser_validationErrorOccurred: ((XMLParser, Error) -> Void)?
    
    
    override func responds(to aSelector: Selector!) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            #selector(parserDidStartDocument(_:)) : _parserDidStartDocument,
            #selector(parserDidEndDocument(_:)) : _parserDidEndDocument,
            #selector(parser(_:foundNotationDeclarationWithName:publicID:systemID:)) : _parser_foundNotationDeclarationWithName,
            #selector(parser(_:foundUnparsedEntityDeclarationWithName:publicID:systemID:notationName:)) : _parser_foundUnparsedEntityDeclarationWithName,
            #selector(parser(_:foundAttributeDeclarationWithName:forElement:type:defaultValue:)) : _parser_foundAttributeDeclarationWithName,
            #selector(parser(_:foundElementDeclarationWithName:model:)) : _parser_foundElementDeclarationWithName,
            #selector(parser(_:foundInternalEntityDeclarationWithName:value:)) : _parser_foundInternalEntityDeclarationWithName,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        let funcDic2: [Selector : Any?] = [
            #selector(parser(_:foundExternalEntityDeclarationWithName:publicID:systemID:)) : _parser_foundExternalEntityDeclarationWithName,
            #selector(parser(_:didStartElement:namespaceURI:qualifiedName:attributes:)) : _parser_didStartElement,
            #selector(parser(_:didEndElement:namespaceURI:qualifiedName:)) : _parser_didEndElement,
            #selector(parser(_:didStartMappingPrefix:toURI:)) : _parser_didStartMappingPrefix,
            #selector(parser(_:didEndMappingPrefix:)) : _parser_didEndMappingPrefix,
            #selector(parser(_:foundCharacters:)) : _parser_foundCharacters,
            #selector(parser(_:foundIgnorableWhitespace:)) : _parser_foundIgnorableWhitespace,
        ]
        if let f = funcDic2[aSelector] {
            return f != nil
        }
        
        let funcDic3: [Selector : Any?] = [
            #selector(parser(_:foundProcessingInstructionWithTarget:data:)) : _parser_foundProcessingInstructionWithTarget,
            #selector(parser(_:foundComment:)) : _parser_foundComment,
            #selector(parser(_:foundCDATA:)) : _parser_foundCDATA,
            #selector(parser(_:resolveExternalEntityName:systemID:)) : _parser_resolveExternalEntityName,
            #selector(parser(_:parseErrorOccurred:)) : _parser_parseErrorOccurred,
            #selector(parser(_:validationErrorOccurred:)) : _parser_validationErrorOccurred,
        ]
        if let f = funcDic3[aSelector] {
            return f != nil
        }
        
        return super.responds(to: aSelector)
    }
    
    
    @objc func parserDidStartDocument(_ parser: XMLParser) {
        _parserDidStartDocument!(parser)
    }
    @objc func parserDidEndDocument(_ parser: XMLParser) {
        _parserDidEndDocument!(parser)
    }
    @objc func parser(_ parser: XMLParser, foundNotationDeclarationWithName name: String, publicID: String?, systemID: String?) {
        _parser_foundNotationDeclarationWithName!(parser, name, publicID, systemID)
    }
    @objc func parser(_ parser: XMLParser, foundUnparsedEntityDeclarationWithName name: String, publicID: String?, systemID: String?, notationName: String?) {
        _parser_foundUnparsedEntityDeclarationWithName!(parser, name, publicID, systemID, notationName)
    }
    @objc func parser(_ parser: XMLParser, foundAttributeDeclarationWithName attributeName: String, forElement elementName: String, type: String?, defaultValue: String?) {
        _parser_foundAttributeDeclarationWithName!(parser, attributeName, elementName, type, defaultValue)
    }
    @objc func parser(_ parser: XMLParser, foundElementDeclarationWithName elementName: String, model: String) {
        _parser_foundElementDeclarationWithName!(parser, elementName, model)
    }
    @objc func parser(_ parser: XMLParser, foundInternalEntityDeclarationWithName name: String, value: String?) {
        _parser_foundInternalEntityDeclarationWithName!(parser, name, value)
    }
    @objc func parser(_ parser: XMLParser, foundExternalEntityDeclarationWithName name: String, publicID: String?, systemID: String?) {
        _parser_foundExternalEntityDeclarationWithName!(parser, name, publicID, systemID)
    }
    @objc func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        _parser_didStartElement!(parser, elementName, namespaceURI, qName, attributeDict)
    }
    @objc func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        _parser_didEndElement!(parser, elementName, namespaceURI, qName)
    }
    @objc func parser(_ parser: XMLParser, didStartMappingPrefix prefix: String, toURI namespaceURI: String) {
        _parser_didStartMappingPrefix!(parser, prefix, namespaceURI)
    }
    @objc func parser(_ parser: XMLParser, didEndMappingPrefix prefix: String) {
        _parser_didEndMappingPrefix!(parser, prefix)
    }
    @objc func parser(_ parser: XMLParser, foundCharacters string: String) {
        _parser_foundCharacters!(parser, string)
    }
    @objc func parser(_ parser: XMLParser, foundIgnorableWhitespace whitespaceString: String) {
        _parser_foundIgnorableWhitespace!(parser, whitespaceString)
    }
    @objc func parser(_ parser: XMLParser, foundProcessingInstructionWithTarget target: String, data: String?) {
        _parser_foundProcessingInstructionWithTarget!(parser, target, data)
    }
    @objc func parser(_ parser: XMLParser, foundComment comment: String) {
        _parser_foundComment!(parser, comment)
    }
    @objc func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        _parser_foundCDATA!(parser, CDATABlock)
    }
    @objc func parser(_ parser: XMLParser, resolveExternalEntityName name: String, systemID: String?) -> Data? {
        return _parser_resolveExternalEntityName!(parser, name, systemID)
    }
    @objc func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        _parser_parseErrorOccurred!(parser, parseError)
    }
    @objc func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        _parser_validationErrorOccurred!(parser, validationError)
    }
}
