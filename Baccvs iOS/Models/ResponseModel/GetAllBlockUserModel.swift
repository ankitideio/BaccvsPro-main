//
//  GetAllBlockUserModel.swift
//  Baccvs iOS
//
//  Created by pm on 06/03/2023.
//

import Foundation
struct GetAllBlockUserModel : Codable {
    var  status: Bool =  Bool()
    var  message: String = String()
    var  body: [AllBlockUser] = []
}


struct AllBlockUser : Codable {
    var  id : String = String()
    var name: String = String()
    var profileImageURL: String = String()

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImageURL = "profile_image_url"
    }
}
