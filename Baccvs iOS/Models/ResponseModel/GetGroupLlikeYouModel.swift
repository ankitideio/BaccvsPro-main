//
//  GetGroupLlikeYouModel.swift
//  Baccvs iOS
//
//  Created by pm on 16/03/2023.
//

import Foundation
struct GetGroupLlikeYouModel: Codable {
    var status: Bool = Bool()
    var message: String = String()
    var body: [GroupLikeYou] = []
}

struct GroupLikeYou: Codable {
    var id : String = String()
    var groupName : String = String()
    var groupDescription : String = String()
    var groupOwner: String = String()
    var ownerImage: String  = String()
    var user: [Userdetail] = []

    enum CodingKeys: String, CodingKey {
        case id
        case groupName = "group_name"
        case groupDescription = "group_description"
        case groupOwner = "group_owner"
        case ownerImage = "owner_image"
        case user
    }
}

struct Userdetail: Codable {
    var userID: String = String()
    var userImage: String = String()
    var userName: String   = String()

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case userImage, userName
    }
}
