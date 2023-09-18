//
//  FolderDetailsRequest.swift
//  FilesTracker
//
//  Created by Akshay Tule on 21/08/23.
//

import Foundation

// details request 
struct FolderDetailsRequest: DataRequest {
    
    var folderID: Int
    
    var url: String {
        return "https://toke.mangopulse.com/api/folders/\(folderID)/files.json"
    }
    
    var headers: [String : String] {
        ["Cookie": LoginManager.shared.getToken()]
    }
    
    var queryItems: [String : String] {
        ["include_folders": "1"]
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
