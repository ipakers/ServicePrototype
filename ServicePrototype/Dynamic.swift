//
//  Dynamic.swift
//
//  Created by Dan Pope on 7/30/15.
//  Copyright © 2015 Slalom Consulting. All rights reserved.
//
//  Desc:
//      A simple binding mechanism - for now
//      Taken from: http://rasic.info/bindings-generics-swift-and-mvvm/

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    //Note:  The binder spits out a warning if it is used in multiple places.  This was an intentional design decision.  Support for multiple binding generally adds code complexity that isn't needed.  You can avoid this complexity by having a variable for each binding you need that is then directly tied to the UI it represents.
    
    func bind(listener: Listener?) {
        if self.listener != nil {
            print("WARNING: Listener overridden")
        }
        self.listener = listener
    }
    
    func bindAndFire(listener: Listener?) {
        if self.listener != nil {
            print("WARNING: Listener overridden")
        }
        self.listener = listener
        listener?(value)
    }
    
    func fire() {
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }

    
    init(_ v: T) {
        value = v
    }
}
