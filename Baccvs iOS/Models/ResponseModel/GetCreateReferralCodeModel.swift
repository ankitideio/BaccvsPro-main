//
//  GetCreateReferralCodeModel.swift
//  Baccvs iOS
//
//  Created by pm on 16/02/2023.
//

import Foundation
struct GetCreateReferralCodeModel :Codable{
    var status :  Bool  = Bool()
    var message :  String  = String()
    var referral_code : String = String()
}

struct GetReferralCodeModel :Codable{
    var status :  Bool  = Bool()
    var message :  String  = String()
}
