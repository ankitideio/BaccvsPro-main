//
//  GetEventByIdModel.swift
//  Baccvs iOS
//  Created by pm on 29/03/2023.

import Foundation
struct GetEventByIdModel : Codable {
    var  status: Bool = Bool()
    var  message: String = String()
    var  body: EventDetailById = EventDetailById()
}
struct EventDetailById: Codable {
    var  id : String = String()
    var  eventName : String = String()
    var  longitude : String = String()
    var  latitude  : String = String()
    var  isAfter   : Bool = Bool()
    var  isBefore  : Bool = Bool()
    var  isParty   : Bool = Bool()
    var  startTime : String = String()
    var  endTime   : String = String()
    var  mobileNumber : String = String()
    var  music: String = String()
    var  peopleAllowed : String = String()
    var  freePaid : Bool = Bool()
    var  price   : String = String()
    var  isSensitive: Bool = Bool()
    var  partyDiscripation : String = String()
    var  eventOwnerID : String = String()
    var  eventOwnerName : String = String()
    var  eventOwnerImage : String = String()
    var  video: [VideoDetail]  = []
    var  user: [UserEventDetail] = []

    enum CodingKeys: String, CodingKey {
        case id
        case eventName = "event_name"
        case longitude, latitude
        case isAfter = "is_after"
        case isBefore = "is_before"
        case isParty = "is_party"
        case startTime = "start_time"
        case endTime = "end_time"
        case mobileNumber = "mobile_number"
        case music
        case peopleAllowed = "people_allowed"
        case freePaid = "free_paid"
        case price
        case isSensitive = "is_sensitive"
        case partyDiscripation = "party_discripation"
        case eventOwnerID = "event_owner_id"
        case eventOwnerName = "event_owner_name"
        case eventOwnerImage = "event_owner_image"
//        case videoID = "video_id"
//        case videoLink = "video_link"
        case video, user
    }
}



struct UserEventDetail: Codable {
    var  userID: String = String()
    var  userImage: String = String()
    var  userName : String = String()
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case userImage
        case userName
    }
}
