//
//  GetUpdateEventModel.swift
//  Baccvs iOS
//
//  Created by pm on 27/04/2023.
//

import Foundation
struct GetUpdateEventModel : Codable {
    var status : Bool = Bool()
    var message : String = String()
}
struct DeleteEventVideoModel : Codable {
    var id : String = String()
    var event_id : String = String()
}
struct DeleteEventUserModel : Codable {
    var friend_id : String = String()
    var event_id : String = String()
}
struct UpdateEventThumbNilModel : Codable {
    var thum_nail : Media = Media()
    var event_id : String = String()
}
struct AddEventVideoModel : Codable {
    var video : [Media] = []
    var event_id : String = String()
}
struct AddEventUserModel : Codable {
    var friend_list : String = String()
    var event_id : String = String()
}
