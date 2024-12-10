//
//  GetFollowingModel.swift
//  Baccvs iOS
//
//  Created by pm on 05/04/2023.
//

import Foundation
struct GetFollowingModel : Codable {
    var status: Bool = Bool()
    var message: String = String()
    var youAreFollowing: YouAreFollowing =  YouAreFollowing()

    enum CodingKeys: String, CodingKey {
        case status, message
        case youAreFollowing = "You_are_following"
    }
}


struct YouAreFollowing: Codable {
    var  id : String  = String()
    var  name: String  = String()
    var profileImageURL: String =  String()

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImageURL = "profile_image_url"
    }
}
