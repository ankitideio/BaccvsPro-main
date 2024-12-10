//
//  SignupModel.swift
//  Baccvs iOS
//
//  Created by pm on 16/02/2023.
//

import Foundation
struct SignupModel: Codable {
    var referralCodeByNextUser : String = String()
    var  name : String = String()
    var  email : String = String()
    var  description : String = String()
    var  password: String = String()
    var  phoneNumber : String = String()
    var  instagram : String = String()
    var  deviceToken : String = "string"
    var  dateOfBirth : String = String()
    var  gender : String = String()
    enum CodingKeys: String, CodingKey {
        case referralCodeByNextUser = "referral_code_by_next_user"
        case name, email, password, description
        case phoneNumber = "phone_number"
        case instagram
        case deviceToken = "device_token"
        case dateOfBirth = "date_of_birth"
        case gender
    }
}


