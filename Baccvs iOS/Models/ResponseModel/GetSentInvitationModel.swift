//
//  GetSentInvitationModel.swift
//  Baccvs iOS
//
//  Created by pm on 15/03/2023.
//

import Foundation
struct GetSentInvitationModel: Codable {
    var status: Bool = Bool()
    var message: String = String()
    var body: [GetSentInvitation] = []
}

struct GetSentInvitation: Codable {
    var eventID : String = String()
    var eventName: String
    var eventThumnail: String
    var users: [UserSent] = []
    enum CodingKeys: String, CodingKey {
        case eventID = "event_id"
        case eventName = "event_name"
        case eventThumnail = "event_thumnail"
        case users
    }
}

struct UserSent : Codable {
    var  userId: String = String()
    var  userImage : String = String()
    var  userName : String = String()
}

