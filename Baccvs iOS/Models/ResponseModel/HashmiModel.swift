//
//  HashmiModel.swift
//  Baccvs iOS
//
//  Created by pm on 10/03/2023.
//

import Foundation
struct HashmiModel : Codable {
    var id : String = String()
    var name : String = String()
    var profileImageURL : String = String()

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImageURL = "profile_image_url"
    }
}
