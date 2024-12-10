//
//  UpdateEventModel.swift
//  Baccvs iOS
//
//  Created by pm on 27/04/2023.
//

import Foundation
struct UpdateEventModel : Codable {
    
    var id: ID = ID()
    var updte: Updte = Updte()
    
}

struct ID: Codable {
    var  evnetID: String = String()

    enum CodingKeys: String, CodingKey {
        case evnetID = "evnet_id"
    }
}

struct Updte: Codable {
    var  eventName : String = String()
    var  longitude : String = String()
    var  latitude : String = String()
    var  isBefore : Bool = Bool()
    var  isParty : Bool = Bool()
    var  isAfter : Bool = Bool()
    var  music: String = String()
    var  price: String = "0"
    var  startTime : String = String()
    var  endTime : String = String()
    var  mobileNumber : String = String()
    var  peopleAllowed : String = String()
    var  freePaid : Bool = Bool()
    var  partyDiscripation : String = String()

    enum CodingKeys: String, CodingKey {
        case eventName = "event_name"
        case longitude, latitude
        case isBefore = "is_before"
        case isParty = "is_party"
        case isAfter = "is_after"
        case startTime = "start_time"
        case endTime = "end_time"
        case music, price
        case mobileNumber = "mobile_number"
        case peopleAllowed = "people_allowed"
        case freePaid = "free_paid"
        case partyDiscripation = "party_discripation"
    }
}
