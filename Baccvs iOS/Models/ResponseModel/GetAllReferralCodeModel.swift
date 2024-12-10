//
//  GetAllReferralCodeModel.swift
//  Baccvs iOS
//
//  Created by pm on 23/03/2023.
//

import Foundation
struct GetAllReferralCodeModel : Codable {
    var  status: Bool = Bool()
    var  message: String = String()
    var  body: [GetAllUserReferral] = []
}


struct GetAllUserReferral : Codable {
    var  referralCode: String = String()
    enum CodingKeys: String, CodingKey {
        case referralCode = "referral_code"
    }
}
