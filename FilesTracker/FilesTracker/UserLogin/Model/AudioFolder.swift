//
//  AudioFolder.swift
//  FilesTracker
//
//  Created by Akshay Tule on 21/08/23.
//

import Foundation

struct AudioFolder: Codable {

  var folderId : String? = nil

  enum CodingKeys: String, CodingKey {

    case folderId = "folder_id"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    folderId = try values.decodeIfPresent(String.self , forKey: .folderId )
 
  }

  init() {

  }

}
