//
//  Folders.swift
//  FilesTracker
//
//  Created by Akshay Tule on 21/08/23.
//

import Foundation

struct Folders: Codable {

  var conversationId        : String? = nil
  var userId                : String? = nil
  var name                  : String? = nil
  var relativePath          : String? = nil
  var folderRel             : String? = nil
  var id                    : String? = nil
  var isVirtualFolder       : Bool?   = nil
  var updatedAt             : Int?    = nil
  var childCount            : Int?    = nil
  var showPermissionOptions : Bool?   = nil
  var showApplyParentOption : Bool?   = nil
  var canSave               : Bool?   = nil
  var isPinned              : Bool?   = nil
  var folderTypeFromDb      : String? = nil
  var showInUpload          : String? = nil
  var showInMove            : String? = nil
  var filter                : String? = nil

  enum CodingKeys: String, CodingKey {

    case conversationId        = "conversation_id"
    case userId                = "user_id"
    case name                  = "name"
    case relativePath          = "relativePath"
    case folderRel             = "folder_rel"
    case id                    = "id"
    case isVirtualFolder       = "is_virtual_folder"
    case updatedAt             = "updated_at"
    case childCount            = "child_count"
    case showPermissionOptions = "show_permission_options"
    case showApplyParentOption = "show_apply_parent_option"
    case canSave               = "can_save"
    case isPinned              = "is_pinned"
    case folderTypeFromDb      = "folder_type_from_db"
    case showInUpload          = "show_in_upload"
    case showInMove            = "show_in_move"
    case filter                = "filter"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    conversationId        = try values.decodeIfPresent(String.self , forKey: .conversationId        )
    userId                = try values.decodeIfPresent(String.self , forKey: .userId                )
    name                  = try values.decodeIfPresent(String.self , forKey: .name                  )
    relativePath          = try values.decodeIfPresent(String.self , forKey: .relativePath          )
    folderRel             = try values.decodeIfPresent(String.self , forKey: .folderRel             )
    id                    = try values.decodeIfPresent(String.self , forKey: .id                    )
    isVirtualFolder       = try values.decodeIfPresent(Bool.self   , forKey: .isVirtualFolder       )
    updatedAt             = try values.decodeIfPresent(Int.self    , forKey: .updatedAt             )
    childCount            = try values.decodeIfPresent(Int.self    , forKey: .childCount            )
    showPermissionOptions = try values.decodeIfPresent(Bool.self   , forKey: .showPermissionOptions )
    showApplyParentOption = try values.decodeIfPresent(Bool.self   , forKey: .showApplyParentOption )
    canSave               = try values.decodeIfPresent(Bool.self   , forKey: .canSave               )
    isPinned              = try values.decodeIfPresent(Bool.self   , forKey: .isPinned              )
    folderTypeFromDb      = try values.decodeIfPresent(String.self , forKey: .folderTypeFromDb      )
    showInUpload          = try values.decodeIfPresent(String.self , forKey: .showInUpload          )
    showInMove            = try values.decodeIfPresent(String.self , forKey: .showInMove            )
    filter                = try values.decodeIfPresent(String.self , forKey: .filter                )
 
  }

  init() {}
}
