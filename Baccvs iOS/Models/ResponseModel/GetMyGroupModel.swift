//
//  GetMyGroupModel.swift
//  Baccvs iOS
//
//  Created by pm on 08/03/2023.
//

import Foundation
struct GetMyGroupModel : Codable {
    var  status: Bool = Bool()
    var  message: String = String()
    var  body: [GroupOwnerDetail] = []
}

struct GroupOwnerDetail : Codable {
    var   id : String = String()
    var   groupName : String  = String()
    var   groupDescription : String  = String()
    var  groupOwner: String = String()
    var  ownerImage: String = String()
    var groupOwnerId : String = String()
    var  user : [UserDetail] =  []
    var userLikeGroup :  [UserDetail] = []
    var posts : [Post] = []
    enum CodingKeys: String, CodingKey {
        case id
        case groupName = "group_name"
        case groupDescription = "group_description"
        case groupOwner = "group_owner"
        case ownerImage = "owner_image"
        case groupOwnerId  = "group_owner_id"
        case user
        case userLikeGroup = "user_like_group"
        case posts
    }
}
struct UserDetail: Codable {
    var userID : String = String()
    var userImage: String = String()
    var userName: String  = String()

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case userImage, userName
    }
}
struct Post: Codable {
    var videoID :    String     = String()
    var videoURL :   String     = String()
    var userID :     String     = String()
    var userImage :  String     = String()
    var userName :   String     = String()

    enum CodingKeys: String, CodingKey {
        case videoID = "video_id"
        case videoURL = "video_url"
        case userID = "user_id"
        case userImage = "user_image"
        case userName = "user_name"
    }
}
