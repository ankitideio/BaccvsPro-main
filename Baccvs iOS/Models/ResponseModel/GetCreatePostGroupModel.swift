//
//  GetCreatePostGroupModel.swift
//  Baccvs iOS
//
//  Created by pm on 17/02/2023.
//

import Foundation
struct GetCreatePostGroupModel : Codable{
    var Group_Name: String = String()
    var group_Name : String = String()
    var getGroupPostUser : Group_Post_User =  Group_Post_User()
    var vedio_url : String = String()

}
struct Group_Post_User : Codable{
    var name: String = String()
    var profile_image_url : String = String()

}


