//
//  GetAllEventsModel.swift
//  Baccvs iOS
//
//  Created by pm on 28/02/2023.
//

import Foundation
struct GetAllEventsModel : Codable {
    var id : String = String()
    var event_name : String = String()
    var longitude : String = String()
    var latitude : String = String()
    var is_after: Bool = Bool()
    var is_before : Bool = Bool()
    var is_party : Bool = Bool()
    var start_time: String = String()
    var tum_nail : String? = String()
    var end_time : String = String()
    var mobile_number : String = String()
    var music : String = String()
    var people_allowed : String = String()
    var free_paid : String = String()
    var is_sensitive : Bool = Bool()
    var event_owner: String = String()
    var event_owner_name : String = String()
    var event_owner_id : String = String()
    var event_owner_image : String = String()
    var party_discripation: String = String()
    var video : [String] = []
    var images  : [String] = []
    var user : [JSONAny] = []
   
}




