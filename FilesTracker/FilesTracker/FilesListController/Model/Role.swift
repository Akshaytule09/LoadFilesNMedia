//
//  Role.swift
//  FilesTracker
//
//  Created by Akshay Tule on 21/08/23.
//

import Foundation

struct Role: Codable {

  var canEdit    : String? = nil
  var canShare   : String? = nil
  var canRestore : String? = nil

  enum CodingKeys: String, CodingKey {

    case canEdit    = "can_edit"
    case canShare   = "can_share"
    case canRestore = "can_restore"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    canEdit    = try values.decodeIfPresent(String.self , forKey: .canEdit    )
    canShare   = try values.decodeIfPresent(String.self , forKey: .canShare   )
    canRestore = try values.decodeIfPresent(String.self , forKey: .canRestore )
 
  }

  init() {

  }

}
