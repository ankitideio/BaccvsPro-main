//
//  GetCreateEventModel.swift
//  Baccvs iOS
//
//  Created by pm on 18/02/2023.
//

import Foundation
//struct GetCreateEventModel: Codable {
//    var status : Bool = Bool()
//    var message : String =  String()
//    var id: String =  String()
//    var eventName : String =  String()
//    var longitude : String = String()
//    var latitude : String = String()
//    var isAfter : Bool = Bool()
//    var isBefore : Bool = Bool()
//    var isParty : Bool = Bool()
//    var startTime : String =  String()
//    var endTime : String =  String()
//    var eventTumNail : String = String()
//    var mobileNumber : String =  String()
//    var music : String =  String()
//    var peopleAllowed : String =  String()
//    var freePaid : String =  String()
//    var eventOwnerId : String =  String()
//    var eventOwnerName : String = String()
//    var eventOwnerImage : String =  String()
//    var price : String = String()
//    var video : [Video] = []
//    var user : [UserFriends] = []
//    enum CodingKeys: String, CodingKey {
//        case status, message, id
//        case eventName = "event_name"
//        case longitude, latitude
//        case isAfter = "is_after"
//        case isBefore = "is_before"
//        case isParty = "is_party"
//        case startTime = "start_time"
//        case endTime = "end_time"
//        case eventTumnail = "event_tumnail"
//        case mobileNumber = "mobile_number"
//        case music
//        case peopleAllowed = "people_allowed"
//        case freePaid = "free_paid"
//        case price
//        case eventOwnerID = "event_owner_id"
//        case eventOwnerName = "event_owner_name"
//        case eventOwnerImage = "event_owner_image"
//        case video, user
//
//    }
//}
//


struct GetCreateEventModel: Codable {
    var status: Bool = Bool()
    var message : String = String()
    var id : String = String()
    var eventName : String = String()
    var longitude : String = String()
    var latitude: String = String()
    var isAfter : Bool = Bool()
    var isBefore : Bool = Bool()
    var isParty: Bool = Bool()
    var startTime: String = String()
    var endTime: String = String()
    var eventTumnail: String = String()
    var mobileNumber: String = String()
    var music : String = String()
    var peopleAllowed: String = String()
    var freePaid: Bool = Bool()
    var price: String = String()
    var eventOwnerID: String = String()
    var eventOwnerName: String = String()
    var eventOwnerImage: String = String()
    var video: [Video] = []
    var user: [UserFriends] = []

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case id
        case eventName = "event_name"
        case longitude
        case latitude
        case isAfter = "is_after"
        case isBefore = "is_before"
        case isParty = "is_party"
        case startTime = "start_time"
        case endTime = "end_time"
        case eventTumnail = "event_tumnail"
        case mobileNumber = "mobile_number"
        case music
        case peopleAllowed = "people_allowed"
        case freePaid = "free_paid"
        case price
        case eventOwnerID = "event_owner_id"
        case eventOwnerName = "event_owner_name"
        case eventOwnerImage = "event_owner_image"
        case video
        case user
    }
}


// MARK: - Video
struct Video: Codable {
    var videoID: String = String()
    var videoLink: String = String()

    enum CodingKeys: String, CodingKey {
        case videoID = "video_id"
        case videoLink = "video_link"
    }
}
struct UserFriends : Codable {
    var userId : String = String()
    var userImage : String = String()
    var userName : String =    String()

}
