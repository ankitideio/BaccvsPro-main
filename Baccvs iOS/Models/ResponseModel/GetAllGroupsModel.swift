//
//  GetAllGroupsModel.swift
//  Baccvs iOS
//
//  Created by pm on 17/02/2023.


import Foundation
struct GetAllGroupsModel : Codable {
    var status : Bool = Bool()
    var message : String = String()
    var  body: [GroupFriends] = []

}

struct GroupFriends : Codable{
    var  id : String = String()
    var  groupName : String = String()
    var  groupDescription : String = String()
    var  groupOwner: String =  String()
    var  ownerImage: String = String()
    var  likeGroup : Bool = Bool()
    var  user: [UserGroup] = []
    enum CodingKeys: String, CodingKey {
        case id
        case groupName = "group_name"
        case groupDescription = "group_description"
        case groupOwner = "group_owner"
        case ownerImage = "owner_image"
        case likeGroup  = "like_group"
        case user
    }
}

struct UserGroup: Codable {
    var  userID: String = String()
    var userImage: String = String()
    var userName: String = String()

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case userImage, userName
    }
}


