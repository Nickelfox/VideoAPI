//
//  AuthHeaders.swift
//  Model
//
//  Created by kartic on 11/12/17.
//  Copyright © 2017 KarticKhosla. All rights reserved.
//

import Foundation
import APIClient
import JSONParsing
import SwiftyJSON
import Alamofire

public struct AuthHeaders: AuthHeadersProtocol {
    let accessToken: String
    
    public static func parse(_ json: JSON) throws -> AuthHeaders {
        return try AuthHeaders(
            accessToken: json[accessTokenKey]^
        )
    }
    
    public func toJSON() -> [String: String] {
        let res: [String: String] = [
            accessTokenKey: self.accessToken
        ]
        return res
    }
    
    public var isValid: Bool {
        return !self.accessToken.isEmpty
    }
    
}

extension AuthHeaders {
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.addValue("Bearer 70b8fe4d2b56ec1794ede752104ece48", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}

private let accessTokenKey = "token"

