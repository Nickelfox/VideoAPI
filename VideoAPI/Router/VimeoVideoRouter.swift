//
//  VideoRouter.swift
//  Model
//
//  Created by kartic on 11/12/17.
//  Copyright © 2017 KarticKhosla. All rights reserved.
//

import Foundation
import APIClient

public enum VimeoRouter: BaseRouter {
    
    case getVideo
    
    public var method: HTTPMethod {
        switch self {
        case .getVideo:
            return .get
        }
    }
    
    public var headers: [String : String] {
        switch self {
        case .getVideo:
            return ["Authorization": "Bearer 70b8fe4d2b56ec1794ede752104ece48"]
        }
    }
    
    public var keypathToMap: String? {
        switch self {
        case .getVideo:
            return "data"
        }
    }
}
