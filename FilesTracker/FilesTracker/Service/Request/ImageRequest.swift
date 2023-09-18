//
//  ImageRequest.swift
//  FilesTracker
//
//  Created by Akshay Tule on 20/08/23.
//

import UIKit

// logo image for files folders and content.
struct ImageRequest: DataRequest {
    var bodyParams: [String : Any]
            
    let url: String
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw NSError(
                domain: ErrorResponse.invalidResponse.rawValue,
                code: 13,
                userInfo: nil
            )
        }
        
        return image
    }
}

