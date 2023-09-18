//
//  FilesAndFolderResponse.swift
//  FilesTracker
//
//  Created by Akshay Tule on 21/08/23.
//

import Foundation

struct FilesAndFolderResponse: Codable {

  var msResponse : MsResponse? = MsResponse()

  enum CodingKeys: String, CodingKey {

    case msResponse = "ms_response"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    msResponse = try values.decodeIfPresent(MsResponse.self , forKey: .msResponse )
 
  }

  init() {

  }

}
