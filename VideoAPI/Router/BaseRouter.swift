//
//  BaseRouter.swift
//  Model
//
//  Created by kartic on 11/12/17.
//  Copyright © 2017 KarticKhosla. All rights reserved.
//

import Foundation
import APIClient

public protocol BaseRouter: Router {
    
}

extension BaseRouter {
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var path: String {
        return ""
    }
    
    public var params: [String: Any] {
        return [:]
    }
    
    public var baseUrl: URL {
        return URL(string: APIConfig.baseURL)!
    }
    
    public var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    public var encoding: URLEncoding? {
        return nil
    }
    
    public var timeoutInterval: TimeInterval? {
        return nil
    }
    
    public var keypathToMap: String? {
        return nil
    }
    
}
