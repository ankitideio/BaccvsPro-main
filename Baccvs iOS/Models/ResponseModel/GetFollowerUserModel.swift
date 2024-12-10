//
//  GetFollowerUserModel.swift
//  Baccvs iOS
//
//  Created by pm on 17/02/2023.
//

import Foundation
struct GetFollowerUserModel :Codable {
           var status : Bool = Bool()
           var message : String = String()
           var body : [User] = []

}

struct User : Codable {
    var userImage : String = String()
    var userName : String = String()
    var userID : String = String()
    
    enum CodingKeys: String, CodingKey {
        case userImage =  "profile_image_url"
        case userName  =  "name"
        case userID    =  "id"
    }
}




