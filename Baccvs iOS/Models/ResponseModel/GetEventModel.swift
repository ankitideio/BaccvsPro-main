//
//  GetEventModel.swift
//  Baccvs iOS
//
//  Created by pm on 17/02/2023.
//

import Foundation
struct GetEventModel : Codable {
   
    var eventPost : EventPost =  EventPost()
    
    enum CodingKeys: String, CodingKey {
        case eventPost = "event_post"
    }

}

struct  EventPost : Codable {
    
    var postOwner : PostOwner = PostOwner()
    var id : String = String()
    var eventName: String = String()
    var createdAt : String = String()
    
    enum CodingKeys: String, CodingKey {
        case postOwner = "post_owner"
        case id
        case eventName = "event_name"
        case createdAt = "created_at"
    }
    
}

struct PostOwner : Codable {
    var id : String = String()
    var name : String = String()
    var profileImageURL : String = String()
   
    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImageURL = "profile_image_url"
    }
}






