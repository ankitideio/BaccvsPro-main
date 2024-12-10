//
//  GetAllUsersModels.swift
//  Baccvs iOS
//
//  Created by pm on 17/02/2023.
//

import Foundation

struct GetAllUsersModels : Codable{
    var status : Bool = Bool()
    var message: String = String()
    var body: [GetAllUsersBody] = []
}
struct GetAllUsersBody : Codable{
    var id : String = String()
    var name: String = String()
    var email : String = String()
    var profile_image_url : String =  String()
    var referral_code_by_next_user : String = String()
    var instagram: String = String()
    var date_of_birth : String = String()
    var gender: String = String()
    var otp : String = String()
    var zodaic : String = String()
    var longitude : String = String()
    var latitude : String = String()
    var job_title : String = String()
    var school : String = String()
    var languages : String = String()
    var drinking : String = String()
    var smoking : String = String()
    var drugs : String = String()
    var created_at : String = String()

}


