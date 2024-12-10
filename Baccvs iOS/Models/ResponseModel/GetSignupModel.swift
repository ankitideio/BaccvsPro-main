//
//  GetSignupModel.swift
//  Baccvs iOS
//
//  Created by pm on 16/02/2023.
//

import Foundation
//struct  GetSignupModel : Codable{
//    var id : String = String()
//    var name : String = String()
//    var email : String = String()
//    var password : String = String()
//    var instagram : String = String()
//    var phone_number : String = String()
//    var referral_code_by_next_user : String = String()
//    var device_token : String = String()
//    var date_of_birth : String = String()
//    var gender : String = String()
//    var created_at : String = String()
//}


struct NewDetail : Codable{
    var status : Bool = Bool()
    var message : String = String()
    var body : SignupDetail = SignupDetail()
}

struct SignupDetail  : Codable {
    var accessToken : String = String()
    var id : String = String()
    var name : String = String()
    var email : String = String()
    var  profileImage : String = String()
    var description : String = String()
    var referralCodeByNextUser : String = String()
    var instagram : String = String()
    var dateOfBirth : String = String()
    var gender : String = String()
   
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case id, name, email, description
        case profileImage = "profile_image"
        case referralCodeByNextUser = "referral_code_by_next_user"
        case instagram
        case dateOfBirth = "date_of_birth"
        case gender
    }
}

