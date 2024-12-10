//
//  CreateReferralCodeModel.swift
//  Baccvs iOS
//
//  Created by pm on 07/03/2023.
//

import Foundation
struct CreateReferralCodeModel: Codable {
    var id : String = String()
    var userID : String = String()
    var referralCode : String = String()
    var createdAt : String = String()
    var referral: Referral = Referral()

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case referralCode = "referral_code"
        case createdAt = "created_at"
        case referral
    }
}
struct Referral: Codable {
    var id :  String = String()
    var name :  String = String()
    var email :  String = String()
    var referralCodeByNextUser :  String = String()
    var gender : String = String()
    var createdAt : String = String()

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case referralCodeByNextUser = "referral_code_by_next_user"
        case gender
        case createdAt = "created_at"
    }
}
