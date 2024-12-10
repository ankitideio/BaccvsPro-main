//
//  GetLoginModel.swift
//  Baccvs iOS
//
//  Created by pm on 17/02/2023.
//

import Foundation
    struct GetUserModel: Codable {
        var accessToken: String = String()
        var tokenType: String = String()
        var dataUser: DataUser = DataUser()
        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case tokenType = "token_type"
            case dataUser = "Data_User"
        }
    }

struct DataUser: Codable {
    var status : Bool = Bool()
    var message : String = String()
    var id : String = String()
    var name : String = String()
    var email : String = String()
    var phoneNumber :String = String()
    var profileImageURL: String? = String()
    var deviceToken = String()

    enum CodingKeys: String, CodingKey {
        case status, message, id, name, email
        case phoneNumber = "phone_number"
        case profileImageURL = "profile_image_url"
        case deviceToken = "device_token"
    }
 }

