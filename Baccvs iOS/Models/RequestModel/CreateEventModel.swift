//
//  CreateEventModel.swift
//  Baccvs iOS
//
//  Created by pm on 17/02/2023.
import Foundation
struct CreateEventModel : Codable {
    var event_name : String = String()
    var part_vedio_url : [Media] = []
    var thum_nail : Media = Media()
    var longitude : String = String()
    var latitude : String = String()
    var is_before : Bool = Bool()
    var is_party : Bool = Bool()
    var is_after : Bool = Bool()
    var start_time : String = String()
    var end_time : String = String()
    var mobile_number : String = String()
    var music : String = String()
    var people_allowed : String = String()
    var free_paid : Bool = Bool()
    var price : String = "0"
    var party_discripation : String = String()
    var add_friend : String = String()
}

struct Media :Codable {
    var part_vedio_url  : Data = Data()
    var mimeType : String = String()
    var fileName : String = String()
    var paramName : String  =  String()
}
struct FriendsArray : Codable{
    
}
