//
//  Files.swift
//  FilesTracker
//
//  Created by Akshay Tule on 21/08/23.
//

import Foundation

struct Files: Codable {

  var id                 : Int?      = nil
  var filename           : String?   = nil
  var isVirusInfected    : String?   = nil
  var parentId           : Int?      = nil
  var isLiked            : Bool?     = nil
  var likeCount          : Int?      = nil
  var hasActivity        : Bool?     = nil
  var visibility         : String?   = nil
  var customFields       : [String]? = []
  var relativePath       : String?   = nil
  var size               : Int?      = nil
  var isPinned           : Bool?     = nil
  var updatedAt          : Int?      = nil
  var userId             : Int?      = nil
  var uploaderName       : String?   = nil
  var previewUrl         : String?   = nil
  var mobileStreamingUrl : String?   = nil
  var storageUrl         : String?   = nil
  var previewUrl2        : String?   = nil
  var etag               : String?   = nil
  var checkedOutAt       : Int?      = nil
  var conversationId     : String?   = nil
  var description        : String?   = nil
  var privacyType        : String?   = nil
  var mLink              : String?   = nil
  var videoUrl           : String?   = nil
  var videoUrlMobile     : String?   = nil
  var internalLink       : String?   = nil
  var publicLink         : String?   = nil
  var role               : Role?     = Role()
  var shortUrl           : String?   = nil
  var versionNo          : Int?      = nil
  var uiVersionNo        : Int?      = nil
  var docType            : Int?      = nil
  var isFolder           : Bool?     = nil
  var followersCount     : Int?      = nil
  var governanceEnabled  : Bool?     = nil

  enum CodingKeys: String, CodingKey {

    case id                 = "id"
    case filename           = "filename"
    case isVirusInfected    = "is_virus_infected"
    case parentId           = "parent_id"
    case isLiked            = "is_liked"
    case likeCount          = "like_count"
    case hasActivity        = "has_activity"
    case visibility         = "visibility"
    case customFields       = "custom_fields"
    case relativePath       = "relativePath"
    case size               = "size"
    case isPinned           = "is_pinned"
    case updatedAt          = "updated_at"
    case userId             = "user_id"
    case uploaderName       = "uploader_name"
    case previewUrl         = "preview_url"
    case mobileStreamingUrl = "mobile_streaming_url"
    case storageUrl         = "storage_url"
    case previewUrl2        = "preview_url2"
    case etag               = "etag"
    case checkedOutAt       = "checked_out_at"
    case conversationId     = "conversation_id"
    case description        = "description"
    case privacyType        = "privacy_type"
    case mLink              = "mLink"
    case videoUrl           = "video_url"
    case videoUrlMobile     = "video_url_mobile"
    case internalLink       = "internal_link"
    case publicLink         = "public_link"
    case role               = "role"
    case shortUrl           = "short_url"
    case versionNo          = "version_no"
    case uiVersionNo        = "ui_version_no"
    case docType            = "doc_type"
    case isFolder           = "is_folder"
    case followersCount     = "followers_count"
    case governanceEnabled  = "governance_enabled"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id                 = try values.decodeIfPresent(Int.self      , forKey: .id                 )
    filename           = try values.decodeIfPresent(String.self   , forKey: .filename           )
    isVirusInfected    = try values.decodeIfPresent(String.self   , forKey: .isVirusInfected    )
    parentId           = try values.decodeIfPresent(Int.self      , forKey: .parentId           )
    isLiked            = try values.decodeIfPresent(Bool.self     , forKey: .isLiked            )
    likeCount          = try values.decodeIfPresent(Int.self      , forKey: .likeCount          )
    hasActivity        = try values.decodeIfPresent(Bool.self     , forKey: .hasActivity        )
    visibility         = try values.decodeIfPresent(String.self   , forKey: .visibility         )
    customFields       = try values.decodeIfPresent([String].self , forKey: .customFields       )
    relativePath       = try values.decodeIfPresent(String.self   , forKey: .relativePath       )
    size               = try values.decodeIfPresent(Int.self      , forKey: .size               )
    isPinned           = try values.decodeIfPresent(Bool.self     , forKey: .isPinned           )
    updatedAt          = try values.decodeIfPresent(Int.self      , forKey: .updatedAt          )
    userId             = try values.decodeIfPresent(Int.self      , forKey: .userId             )
    uploaderName       = try values.decodeIfPresent(String.self   , forKey: .uploaderName       )
    previewUrl         = try values.decodeIfPresent(String.self   , forKey: .previewUrl         )
    mobileStreamingUrl = try values.decodeIfPresent(String.self   , forKey: .mobileStreamingUrl )
    storageUrl         = try values.decodeIfPresent(String.self   , forKey: .storageUrl         )
    previewUrl2        = try values.decodeIfPresent(String.self   , forKey: .previewUrl2        )
    etag               = try values.decodeIfPresent(String.self   , forKey: .etag               )
    checkedOutAt       = try values.decodeIfPresent(Int.self      , forKey: .checkedOutAt       )
    conversationId     = try values.decodeIfPresent(String.self   , forKey: .conversationId     )
    description        = try values.decodeIfPresent(String.self   , forKey: .description        )
    privacyType        = try values.decodeIfPresent(String.self   , forKey: .privacyType        )
    mLink              = try values.decodeIfPresent(String.self   , forKey: .mLink              )
    videoUrl           = try values.decodeIfPresent(String.self   , forKey: .videoUrl           )
    videoUrlMobile     = try values.decodeIfPresent(String.self   , forKey: .videoUrlMobile     )
    internalLink       = try values.decodeIfPresent(String.self   , forKey: .internalLink       )
    publicLink         = try values.decodeIfPresent(String.self   , forKey: .publicLink         )
    role               = try values.decodeIfPresent(Role.self     , forKey: .role               )
    shortUrl           = try values.decodeIfPresent(String.self   , forKey: .shortUrl           )
    versionNo          = try values.decodeIfPresent(Int.self      , forKey: .versionNo          )
    uiVersionNo        = try values.decodeIfPresent(Int.self      , forKey: .uiVersionNo        )
    docType            = try values.decodeIfPresent(Int.self      , forKey: .docType            )
    isFolder           = try values.decodeIfPresent(Bool.self     , forKey: .isFolder           )
    followersCount     = try values.decodeIfPresent(Int.self      , forKey: .followersCount     )
    governanceEnabled  = try values.decodeIfPresent(Bool.self     , forKey: .governanceEnabled  )
 
  }

  init() {

  }

}
