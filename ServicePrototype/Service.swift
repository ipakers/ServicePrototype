//
//  Service.swift
//  ServicePrototype
//
//  Created by Isaac Perry on 10/17/16.
//  Copyright © 2016 Isaac Perry. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Service {
    
    static let baseURL = "https://prototypeapi.azurewebsites.net/"
    
    static func makeRequest<U: JSONSerializable>(request: Request, handler: @escaping (U) -> Void) {
        let urlRequest = getUrlRequest(request: request)
        
        Alamofire.request(urlRequest).responseString { response in
            print(response.request ?? "Error in getting request")  // original URL request
            print(response.response ?? "Error in getting response") // HTTP URL response
            print(response.data ?? "Error in gettng data")     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            if let jsonString = response.result.value, let dataFromString = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false), let result = U(json: JSON(data: dataFromString)) {
                handler(result)
            }
        }
        
    }
    
    private static func getUrlRequest(request: Request) -> URLRequest {
        let url = URL(string: baseURL + request.path + request.getQueryString())!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method
        
        if let body = request.body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                
            }
        }
        
        if let headers = request.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        return urlRequest
    }
}

struct Request {
    var path: String
    var method: String
    var queryParams: [String:String]?
    var headers: [String:String]?
    var body: JSON?
    
    init(path:String, method: String) {
        self.path = path
        self.method = method
    }
    
    func getQueryString() -> String {
        var result = ""
        if let params = queryParams {
            var pairs = [String]()
            for (key, value) in params {
                pairs.append("\(key)=\(value)")
            }
            if pairs.count > 0 {
                result = "?" + pairs.joined(separator: "&")
            }
        }
        return result
    }
}

protocol JSONSerializable {
    init?(json: JSON)
    var json: [String:Any] { get }
}


