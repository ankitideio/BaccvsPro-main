//
//  GetPeopleLikeModel.swift
//  Baccvs iOS
//
//  Created by pm on 03/03/2023.
//

import Foundation

struct GetPeopleLikeModel : Codable {
    var status: Bool = Bool()
    var message: String = String()
    var body : [YoulikePeopleDetail] = []
//    var likePeople : like_people = like_people()

//    enum CodingKeys: String, CodingKey {
//            case likePeople = "like_people"
//         }
}

struct YoulikePeopleDetail : Codable {
    var id : String = String()
    var name : String = String()
    var profile_image_url : String = String()

    
}

