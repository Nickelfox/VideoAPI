//
//  VimeoClient.swift
//  Model
//
//  Created by kartic on 11/12/17.
//  Copyright © 2017 KarticKhosla. All rights reserved.
//

import Foundation
import APIClient

class VimeoClient: APIClient<AuthHeaders, ErrorResponse> {
    
    static let shared = VimeoClient()
    
    override init() {
        super.init()
        enableLogs = true
    }

}

