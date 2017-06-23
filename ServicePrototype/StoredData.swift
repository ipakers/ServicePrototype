//
//  StoredData.swift
//  ServicePrototype
//
//  Created by Isaac Perry on 10/17/16.
//  Copyright © 2016 Isaac Perry. All rights reserved.
//

import Foundation

struct StoredData {
    static func saveString(path: String, value: String?) {
        if let newString = value {
            if path.characters.count > 0 && newString.characters.count > 0 {
                let package = EncodingWrapper(value: newString)
                let directory = documentDirectory + "/\(path).archive"
                NSKeyedArchiver.archiveRootObject(package, toFile: directory)
            }
        }
    }
    
    static func loadString(path: String) -> String? {
        if path.characters.count > 0 {
            if let dataToRetrieve = NSKeyedUnarchiver.unarchiveObject(withFile: documentDirectory + "/\(path).archive") {
                let package = dataToRetrieve as! EncodingWrapper
                return package.value
            }
        }
        return(nil)
    }
    
    private static var documentDirectory: String {
        get {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let directory = paths[0] as String
            return directory
        }
    }
    
    static func deleteIfNull(objectName: String) {
        do {
            let path = documentDirectory + "/\(objectName)"
            if FileManager.default.fileExists(atPath: path) {
                try FileManager.default.removeItem(atPath: path)
            }
        }
        catch {
            print("ERROR:  Unable to delete \(objectName) from persistent storage")
        }
    }
}


// structs can't be stored with NSKeyedEncoder
// this class is used to store string representations of structs
class EncodingWrapper: NSObject, NSCoding {
    var value: String
    
    init(value: String) {
        self.value = value
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.value, forKey: "value")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        if let newValue = aDecoder.decodeObject(forKey: "value") as? String {
            self.init(value: newValue)
        } else {
            return nil
        }
    }
    
}
