//
//  FolderRequest.swift
//  FilesTracker
//
//  Created by Akshay Tule on 21/08/23.
//

import Foundation

// Root folder request
struct RootFolderRequest: DataRequest {
    
    var url: String {
        return "https://toke.mangopulse.com/api/folders.json"
    }
    
    var headers: [String : String] {
        ["Cookie": LoginManager.shared.getToken()]
    }
    
    var queryItems: [String : String] {
        [:]
    }
    
    var bodyParams: [String : Any]
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> FilesAndFolderResponse {
        let decoder = JSONDecoder()
        
        let response = try decoder.decode(FilesAndFolderResponse.self, from: data)
        return response
    }
}
