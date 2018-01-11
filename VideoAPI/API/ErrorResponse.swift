//
//  ErrorResponse.swift
//  Model
//
//  Created by kartic on 11/12/17.
//  Copyright © 2017 KarticKhosla. All rights reserved.
//

import Foundation
import APIClient
import JSONParsing

private let errorKey = "error"

public struct ErrorResponse: ErrorResponseProtocol {
    public static func parse(_ json: JSON, code: Int) throws -> ErrorResponse {
        return try ErrorResponse(code: json["error_code"]^, messages: [json["error"]^])
    }
    
    public var code: Int
    
    public let messages: [String]
    
    public var title: String {
        return "Error"
    }
    
    public var message: String {
        return compiledErrorMessage
    }
    
    public var compiledErrorMessage: String {
        return messages.joined(separator: ",")
    }
}

