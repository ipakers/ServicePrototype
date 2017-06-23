//
//  Simple.swift
//  ServicePrototype
//
//  Created by Isaac Perry on 10/17/16.
//  Copyright © 2016 Isaac Perry. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct SimpleStruct: JSONSerializable {
    var key: String
    var sub: OtherStruct?
    
    struct JSONKeys {
        static let key = "key"
        static let sub = "sub"
    }
    
    init(key: String, sub: OtherStruct) {
        self.key = key
        self.sub = sub
    }
    
    init?(json: JSON) {
        guard let key = json[JSONKeys.key].string,
            let sub = OtherStruct(json: json[JSONKeys.sub])
        else {
            return nil
        }
        self.init(key: key, sub: sub)
    }
    
    var json: [String:Any] {
        return [JSONKeys.key: key, JSONKeys.sub: sub!.json]
    }
}

struct OtherStruct : JSONSerializable {
    var foo: String
    var number: Int
    
    struct JSONKeys {
        static let foo = "foo"
        static let number = "number"
    }
    
    init(foo: String, number: Int) {
        self.foo = foo
        self.number = number
    }
    
    init?(json: JSON) {
        guard let foo = json[JSONKeys.foo].string,
            let number = json[JSONKeys.number].int
        else {
            return nil
        }
        self.init(foo: foo, number: number)
    }
    
    var json: [String:Any] {
        return ["foo": foo, "number": number]
    }
}

extension SimpleStruct {
    static func getMockSimpleStruct() -> SimpleStruct {
        return SimpleStruct(key: "key", sub: OtherStruct(foo: "foo", number: 1))
    }
}





