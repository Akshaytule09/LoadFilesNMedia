//
//  User.swift
//  FilesTracker
//
//  Created by Akshay Tule on 21/08/23.
//

import Foundation

struct User: Codable {

  var id             : Int?         = nil
  var email          : String?      = nil
  var name           : String?      = nil
  var photo          : String?      = nil
  var imageUrl       : String?      = nil
  var isFirstLogin   : String?      = nil
  var canUploadPhoto : String?      = nil
  var token          : String?      = nil
  var Secret         : String?      = nil
  var audioFolder    : AudioFolder? = AudioFolder()
  var imageFolder    : ImageFolder? = ImageFolder()
  var videoFolder    : VideoFolder? = VideoFolder()

  enum CodingKeys: String, CodingKey {

    case id             = "id"
    case email          = "email"
    case name           = "name"
    case photo          = "photo"
    case imageUrl       = "image_url"
    case isFirstLogin   = "is_first_login"
    case canUploadPhoto = "can_upload_photo"
    case token          = "_token"
    case Secret         = "_secret"
    case audioFolder    = "audio_folder"
    case imageFolder    = "image_folder"
    case videoFolder    = "video_folder"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id             = try values.decodeIfPresent(Int.self         , forKey: .id             )
    email          = try values.decodeIfPresent(String.self      , forKey: .email          )
    name           = try values.decodeIfPresent(String.self      , forKey: .name           )
    photo          = try values.decodeIfPresent(String.self      , forKey: .photo          )
    imageUrl       = try values.decodeIfPresent(String.self      , forKey: .imageUrl       )
    isFirstLogin   = try values.decodeIfPresent(String.self      , forKey: .isFirstLogin   )
    canUploadPhoto = try values.decodeIfPresent(String.self      , forKey: .canUploadPhoto )
    token          = try values.decodeIfPresent(String.self      , forKey: .token          )
    Secret         = try values.decodeIfPresent(String.self      , forKey: .Secret         )
    audioFolder    = try values.decodeIfPresent(AudioFolder.self , forKey: .audioFolder    )
    imageFolder    = try values.decodeIfPresent(ImageFolder.self , forKey: .imageFolder    )
    videoFolder    = try values.decodeIfPresent(VideoFolder.self , forKey: .videoFolder    )
 
  }

  init() {

  }

}
