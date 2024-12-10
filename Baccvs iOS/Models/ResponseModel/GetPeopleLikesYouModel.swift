//
//  GetPeopleLikesYouModel.swift
//  Baccvs iOS
//
//  Created by pm on 02/03/2023.
//

import Foundation
struct GetPeopleLikesYouModel : Codable {
    var body : [User] = []
}

struct  like_people : Codable {
    var id : String = String()
    var name: String = String()
    var profileImageURL: String = String()

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImageURL = "profile_image_url"
    }
}


