//
//  GetGroupLikeModel.swift
//  Baccvs iOS
//
//  Created by pm on 02/03/2023.
//

import Foundation
struct GetGroupLikeModel: Codable {
    var  status: Bool =  Bool()
    var  message: String =  String()
    var  body: [OwnerInform] = []
}

struct OwnerInform : Codable {
    var  id : String = String()
    var  groupName : String = String()
    var  groupDescription : String = String()
    var groupOwner: String = String()
    var ownerImage: String  = String()
    var user: [UserDetail] = []
    enum CodingKeys: String, CodingKey {
        case id
        case groupName = "group_name"
        case groupDescription = "group_description"
        case groupOwner = "group_owner"
        case ownerImage = "owner_image"
        case user
    }
}






















//struct  GetGroupLikeModel : Codable  {
//    var groupName : GroupName = GroupName()
//    var likeOwner : LikeOwner = LikeOwner()
//
//    enum CodingKeys: String, CodingKey {
//        case groupName = "Group_Name"
//        case likeOwner = "like_owner"
//    }
//}
//struct GroupName : Codable{
//    var groupsOwner: GroupsOwner = GroupsOwner()
//    var groupName :String = String()
//    var groupDescription :String = String()
//
//    enum CodingKeys: String, CodingKey{
//        case groupsOwner = "groups_owner"
//        case groupName   = "group_name"
//        case groupDescription = "group_description"
//    }
//}
//struct  GroupsOwner : Codable  {
//    var id : String = String()
//    var name : String = String()
//    var profileImageUrl : String = String()
//
//
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case profileImageUrl = "profile_image_url"
//    }
//}
//struct  LikeOwner : Codable  {
//    var id : String = String()
//    var name : String = String()
//    var profileImageUrl : String = String()
//
//
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case profileImageUrl = "profile_image_url"
//    }
//}




//struct WelcomeElement: Codable {
//    let groupName: GroupName
//    let likeOwner: Owner
//
//    enum CodingKeys: String, CodingKey {
//        case groupName = "Group_Name"
//        case likeOwner = "like_owner"
//    }
//}
//
//// MARK: - GroupName
//struct GroupName: Codable {
//    let groupsOwner: Owner
//    let groupName, groupDescription: String
//
//    enum CodingKeys: String, CodingKey {
//        case groupsOwner = "groups_owner"
//        case groupName = "group_name"
//        case groupDescription = "group_description"
//    }
//}
//
//// MARK: - Owner
//struct Owner: Codable {
//    let id, name, profileImageURL: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case profileImageURL = "profile_image_url"
//    }
//}


