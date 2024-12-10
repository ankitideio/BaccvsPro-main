//
//  FilterModel.swift
//  Baccvs iOS
//
//  Created by pm on 15/03/2023.
//

import Foundation
struct FilterModel : Codable{
    var first : String = "Before"
    var secound : String = "AfterParty"
    var third : String  = "Party"
    var four : String = "Missed"
    var five : String = "Today"
    var six : String  = "Upcoming"
}
struct FiltersCases {
    var isAfter : Bool = false
    var isBefore : Bool = false
    var isParty : Bool  = false
    var isMissed : Bool = false
    var isToday : Bool = false
    var isUpcoming : Bool = false
    var isFree : Bool  = false
    var isPrice : Bool = false
    var isMood : Bool = false
//    var isLocation : Bool  = false
}
