//
//  LoginRequest.swift
//  FilesTracker
//
//  Created by Akshay Tule on 20/08/23.
//

import Foundation

// Login API request
struct LoginRequest: DataRequest {
    
    var url: String {
        return "https://toke.mangopulse.com/api/login.json"
    }
    
    var headers: [String : String] {
        ["Content-Type": "application/json"]
    }
    
    var queryItems: [String : String] {
        [:]
    }
    
    var bodyParams: [String : Any]
    
    var method: HTTPMethod {
        .post
    }
    
    func decode(_ data: Data) throws -> LoginResponse? {
        let decoder = JSONDecoder()
        
        let response = try decoder.decode(LoginResponse.self, from: data)
        return response
    }
}
