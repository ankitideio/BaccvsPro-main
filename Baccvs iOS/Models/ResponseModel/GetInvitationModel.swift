//
//  GetInvitationModel.swift
//  Baccvs iOS
//
//  Created by pm on 10/03/2023.
//

import Foundation
struct GetInvitationModel: Codable {
    var status: Bool = Bool()
    var  message: String = String()
    var  body: [Invite] = []
}
struct Invite : Codable {
    var  eventOwnerID : String = String()
    var  eventOwnerName: String = String()
    var  eventOwnerProfileImage: String
    var  eventID : String = String()
    var  eventName: String = String()
    var eventThumbNail : String = String()

    enum CodingKeys: String, CodingKey {
        case eventOwnerID = "event_owner_id"
        case eventOwnerName = "event_owner_name"
        case eventOwnerProfileImage = "event_owner_profile_image"
        case eventID = "event_id"
        case eventName = "event_name"
        case eventThumbNail  =  "event_thumbnail"
    }
}




