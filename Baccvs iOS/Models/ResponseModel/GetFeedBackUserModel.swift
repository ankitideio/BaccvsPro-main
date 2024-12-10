//
//  GetFeedBackUserModel.swift
//  Baccvs iOS
//
//  Created by pm on 14/03/2023.
//

import Foundation
struct GetFeedBackUserModel: Codable {
    var  status : Bool = Bool()
    var  message : String = String()
    var  body: FeedbackDetail = FeedbackDetail()
}


struct FeedbackDetail : Codable {
    var  id : String = String()
    var mood : String = String()
    var discription : String = String()
    var userID : String = String()
    var  referralCodeByNextUser : String = String()
    var  instagram : String = String()

    enum CodingKeys: String, CodingKey {
        case id, mood, discription
        case userID = "user_id"
        case referralCodeByNextUser = "referral_code_by_next_user"
        case instagram
    }
}


