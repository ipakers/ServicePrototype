//
//  SimpleStoredData.swift
//  ServicePrototype
//
//  Created by Isaac Perry on 11/17/16.
//  Copyright © 2016 Isaac Perry. All rights reserved.
//

import Foundation
import SwiftyJSON

extension SimpleStruct {
    static let key = "simple"
}

extension StoredData {
    static var simple: SimpleStruct? {
        get {
            guard let jsonString = StoredData.loadString(path: SimpleStruct.key),
                let dataFromString = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false)
                else {
                    return nil
            }
            return SimpleStruct(json: JSON(data: dataFromString))
        }
        
        set {
            guard newValue != nil else {
                StoredData.deleteIfNull(objectName: SimpleStruct.key)
                return
            }
            StoredData.saveString(path: SimpleStruct.key, value: JSON(newValue?.json).rawString())
        }
    }
}
