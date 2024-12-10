//
//  GetPostsForUsersHomeModel.swift
//  Baccvs iOS
//
//  Created by pm on 14/03/2023.
//

import Foundation
struct GetPostsForUsersHomeModel : Codable {
    var status : Bool = Bool()
    var message : String = String()
    var body: [GetPostsForUsersHomeBody] = []
}

struct GetPostsForUsersHomeBody: Codable {
    var id : String = String()
    var eventName : String = String()
    var eventOwnerImage : String = String()
    var eventOwnerID : String = String()
    var eventOwnerName : String = String()
    var longitude : String = String()
    var latitude : String = String()
    var isAfter : Bool = Bool()
    var isBefore : Bool = Bool()
    var isParty : Bool = Bool()
    var startTime : String = String()
    var tumNail : String = String()
    var endTime: String = String()
    var mobileNumber: String = String()
    var music: String = String()
    var peopleAllowed: String = String()
    var price : String = String()
    var isLike : Bool = Bool()
    var freePaid : Bool = Bool()
    var isSensitive : Bool = Bool()
    var partyDiscripation : String = String()
    var video: [VideoDetail] = []
    var user: [eventFriends] = []
enum CodingKeys: String, CodingKey {
    case id
    case eventName = "event_name"
    case longitude, latitude
    case isAfter = "is_after"
    case isBefore = "is_before"
    case isParty = "is_party"
    case startTime = "start_time"
    case tumNail = "tum_nail"
    case endTime = "end_time"
    case mobileNumber = "mobile_number"
    case music
    case price
    case isLike       = "is_like"
    case peopleAllowed = "people_allowed"
    case freePaid = "free_paid"
    case isSensitive = "is_sensitive"
    case partyDiscripation = "party_discripation"
    case eventOwnerID = "event_owner_id"
    case eventOwnerName = "event_owner_name"
    case eventOwnerImage = "event_owner_image"
    case video, user
}
}
struct eventFriends : Codable {
    var userId : String = String()
    var userImage : String = String()
    var userName : String = String()

}
struct VideoDetail : Codable{
    var  video_id : String = String()
    var  video_link : String = String()
}

//"video_id": "ca742419-622e-4e54-ba33-c4b362141eb9"
 
