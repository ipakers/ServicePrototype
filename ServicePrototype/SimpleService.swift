//
//  SimpleService.swift
//  ServicePrototype
//
//  Created by Isaac Perry on 11/17/16.
//  Copyright © 2016 Isaac Perry. All rights reserved.
//

import Foundation
extension Service {
    static func getSimple(handler: @escaping (SimpleStruct) -> Void) {
        let request = Request(path: "some/path", method: "GET")
        // add headers, query params, and a body
        
        makeRequest(request: request, handler: handler)
    }
}
