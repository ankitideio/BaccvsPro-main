//
//  GetUserIdModel.swift
//  Baccvs iOS
//
//  Created by pm on 14/03/2023.
//

import Foundation
struct GetUserIdModel : Codable {
    var status : Bool = Bool()
    var message : String = String()
    var body : UserProfile = UserProfile()
   

    
}
//
//struct UserProfile : Codable{
//    var id : String = String()
//    var name : String = String()
//    var public_or_private : Bool = Bool()
//    var email : String = String()
//    var story_image : [String] =  []
//    var description : String = String()
//    var profile_image_url : String = String()
//    var referral_code_by_next_user : String = String()
//    var instagram : String = String()
//    var date_of_birth : String = String()
//    var gender : String = String()
//    var otp : String = String()
//    var zodaic : String = String()
//    var longitude : String = String()
//    var latitude : String = String()
//    var job_title : String = String()
//    var school : String = String()
//    var languages : String = String()
//    var drinking : String = String()
//    var smoking : String = String()
//    var drugs : String = String()
//    var created_at : String = String()
//    var is_follow : Bool = Bool()
//    var is_blocked : Bool = Bool()
//    var events    : Int = Int()
//    var followers : Int = Int()
//    var following : Int = Int()
//}


struct UserProfile : Codable {
    var id : String = String()
    var name : String = String()
    var publicOrPrivate: Bool = Bool()
    var email : String = String()
    var storyImage: [StoryImage] = []
    var description: String  = String()
    var profileImageURL : String = String()
    var referralCodeByNextUser : String = String()
    var instagram : String = String()
    var dateOfBirth : String = String()
    var gender : String = String()
    var otp : String = String()
    var zodaic : String = String()
    var longitude : String = String()
    var latitude : String = String()
    var  jobTitle : String = String()
    var  school : String = String()
    var languages : String = String()
    var drinking : String = String()
    var smoking : String = String()
    var   drugs : String = String()
    var createdAt : String = String()
    var isFollow : Bool = Bool()
    var isBlocked: Bool = Bool()
    var  events : Int = Int()
    var  isLike  : Bool = Bool()
    var followers : Int = Int()
    var following : Int = Int()
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case publicOrPrivate = "public_or_private"
        case email
        case storyImage = "story_image"
        case description
        case profileImageURL = "profile_image_url"
        case referralCodeByNextUser = "referral_code_by_next_user"
        case instagram
        case dateOfBirth = "date_of_birth"
        case gender, otp, zodaic, longitude, latitude
        case jobTitle = "job_title"
        case school, languages, drinking, smoking, drugs
        case createdAt = "created_at"
        case  isLike   =  "is_like"
        case isFollow = "is_follow"
        case isBlocked = "is_blocked"
        case events, followers, following
    }
}

