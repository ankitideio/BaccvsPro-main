//
//  GetCreatePostgModel.swift
//  Baccvs iOS
//
//  Created by pm on 14/04/2023.
//
//
//import Foundation
//struct GetCreatePostgModel : Codable {
//    var groupName: GroupName = GroupName()
//    var groupPostUser: GroupPostUser = GroupPostUser()
//    var vedioURL: String = String()
//    enum CodingKeys: String, CodingKey {
//        case groupName = "Group_Name"
//        case groupPostUser = "Group_Post_User"
//        case vedioURL = "vedio_url"
//    }
//}
//
//
//struct GroupName: Codable {
//    var  groupName: String = String()
//    enum CodingKeys: String, CodingKey {
//        case groupName = "group_name"
//    }
//}
//struct GroupPostUser: Codable {
//    var  name: String = String()
//    var  profileImageURL: String = String()
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case profileImageURL = "profile_image_url"
//    }
//}

//import Foundation
//
//struct GetCreatePostgModel: Codable, Hashable {
//    var groupName: GroupName = GroupName()
//    var groupPostUser: GroupPostUser = GroupPostUser()
//    var videoURL: String = String()
//
//    enum CodingKeys: String, CodingKey {
//        case groupName = "Group_Name"
//        case groupPostUser = "Group_Post_User"
//        case videoURL = "vedio_url"
//    }
//}
//
//struct GroupName: Codable, Hashable {
//    var groupName: String = String()
//
//    enum CodingKeys: String, CodingKey {
//        case groupName = "group_name"
//    }
//}
//
//struct GroupPostUser: Codable, Hashable {
//    var name: String = String()
//    var profileImageURL: String = String()
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case profileImageURL = "profile_image_url"
//    }
//}


import Foundation
struct GetCreatePostgModel : Codable {
    var status: Bool = Bool()
    var message : String = String()
    var groupID :  String = String()
    var groupName: String = String()
    var body: [PostDetail] = []

    enum CodingKeys: String, CodingKey {
        case status, message
        case groupID = "group_id"
        case groupName = "group_name"
        case body
    }
}


struct PostDetail : Codable {
    var  postID : String = String()
    var  postOwnerID : String = String()
    var  postOwnerName : String = String()
    var  postOwnerImage : String = String()
    var  video : String = String()
    var  postCreated : String = String()

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case postOwnerID = "post_owner_id"
        case postOwnerName = "post_owner_name"
        case postOwnerImage = "post_owner_image"
        case video
        case postCreated = "post_created"
    }
}
