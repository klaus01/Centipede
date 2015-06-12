//
//  CE_NSURLSession.swift
//  Centipede
//
//  Created by kelei on 2015/6/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

import Foundation

public extension NSURLSession {
    
    private struct Static { static var AssociationKey: UInt8 = 0 }
    private var _delegate: NSURLSession_Delegate? {
        get { return objc_getAssociatedObject(self, &Static.AssociationKey) as? NSURLSession_Delegate }
        set { objc_setAssociatedObject(self, &Static.AssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN)) }
    }
    
    private var ce: NSURLSession_Delegate {
        if let obj = _delegate {
            return obj
        }
        else {
            assert(false, "Use the init(configuration:delegateQueue:) method to instantiate the NSURLSession to use Centipede")
        }
    }
    
    public convenience init(configuration: NSURLSessionConfiguration?, delegateQueue queue: NSOperationQueue?) {
        let obj = NSURLSession_Delegate()
        self.init(configuration: configuration, delegate: obj, delegateQueue: queue)
        _delegate = obj
    }
    
    public func ce_didBecomeInvalidWithError(handle: (session: NSURLSession, error: NSError?) -> Void) -> Self {
        ce._didBecomeInvalidWithError = handle
        return self
    }
    public func ce_didReceiveChallenge(handle: (session: NSURLSession, challenge: NSURLAuthenticationChallenge) -> Void) -> Self {
        ce._didReceiveChallenge = handle
        return self
    }
    public func ce_didFinishEventsForBackgroundURLSession(handle: (session: NSURLSession) -> Void) -> Self {
        ce._didFinishEventsForBackgroundURLSession = handle
        return self
    }
    
}

internal class NSURLSession_Delegate: NSObject, NSURLSessionDelegate {
    
    var _didBecomeInvalidWithError: ((NSURLSession, NSError?) -> Void)?
    var _didReceiveChallenge: ((NSURLSession, NSURLAuthenticationChallenge) -> Void)?
    var _didFinishEventsForBackgroundURLSession: ((NSURLSession) -> Void)?
    
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let funcDic1: [Selector : Any?] = [
            "URLSession:didBecomeInvalidWithError:" : _didBecomeInvalidWithError,
            "URLSession:didReceiveChallenge:" : _didReceiveChallenge,
            "URLSessionDidFinishEventsForBackgroundURLSession:" : _didFinishEventsForBackgroundURLSession,
        ]
        if let f = funcDic1[aSelector] {
            return f != nil
        }
        
        return super.respondsToSelector(aSelector)
    }
    
    
    @objc func URLSession(session: NSURLSession, didBecomeInvalidWithError error: NSError?) {
        _didBecomeInvalidWithError!(session, error)
    }
    @objc func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge) -> Void {
        return _didReceiveChallenge!(session, challenge)
    }
    @objc func URLSessionDidFinishEventsForBackgroundURLSession(session: NSURLSession) {
        _didFinishEventsForBackgroundURLSession!(session)
    }
}
