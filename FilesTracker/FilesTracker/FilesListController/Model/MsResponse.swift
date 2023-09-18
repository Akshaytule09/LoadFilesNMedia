//
//  MsResponse.swift
//  FilesTracker
//
//  Created by Akshay Tule on 21/08/23.
//

import Foundation

struct MsResponse: Codable {

  var isDomainSuspended : String?  = nil
  var transactionId     : String?  = nil
  var totalCount        : Int?     = nil
  var showInUpload      : String?  = nil
  var name              : String?  = nil
  var roleName          : String?  = nil
  var files             : [Files]? = []
  var folders           : [Folders]? = []
  var user              : User? = nil

  enum CodingKeys: String, CodingKey {

    case isDomainSuspended = "is_domain_suspended"
    case transactionId     = "transaction_id"
    case totalCount        = "total_count"
    case showInUpload      = "show_in_upload"
    case name              = "name"
    case roleName          = "role_name"
    case files             = "files"
    case folders           = "folders"
    case user              = "user"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    isDomainSuspended = try values.decodeIfPresent(String.self  , forKey: .isDomainSuspended )
    transactionId     = try values.decodeIfPresent(String.self  , forKey: .transactionId     )
    totalCount        = try values.decodeIfPresent(Int.self     , forKey: .totalCount        )
    showInUpload      = try values.decodeIfPresent(String.self  , forKey: .showInUpload      )
    name              = try values.decodeIfPresent(String.self  , forKey: .name              )
    roleName          = try values.decodeIfPresent(String.self  , forKey: .roleName          )
    files             = try values.decodeIfPresent([Files].self , forKey: .files             )
    folders           = try values.decodeIfPresent([Folders].self , forKey: .folders         )
    user              = try values.decodeIfPresent(User.self , forKey: .user                 )
  }

  init() {

  }

}
