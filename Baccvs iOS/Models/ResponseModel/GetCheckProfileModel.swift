//
//  GetCheckProfileModel.swift
//  Baccvs iOS
//  Created by pm on 17/02/2023.

import Foundation
struct GetCheckProfileModel : Codable {
    var  status : Bool   =  Bool()
    var  message: String = String()
    var  body : ProfileD = ProfileD()
}

     struct ProfileD : Codable {
        var id : String = String()
        var name : String = String()
        var email : String = String()
         var public_or_private : Bool = Bool()
        var  description: String = String()
        var profileImageURL: String = String()
        var referralCodeByNextUser : String = String()
        var  instagram : String = String()
        var  dateOfBirth : String = String()
        var   gender : String = String()
        var  otp : String  = String()
        var   zodaic : String  = String()
        var  longitude : String  = String()
        var latitude: String  = String()
        var jobTitle : String = String()
        var  school : String = String()
        var  languages : String = String()
        var  drinking: String = String()
        var smoking : String = String()
        var drugs : String = String()
        var  createdAt: String = String()
        var events : Int = Int()
        var followers : Int = Int()
        var following: Int = Int()
        var  storyImage: [StoryImage] = []

    enum CodingKeys: String, CodingKey {
        case id, name, email, description
        case profileImageURL = "profile_image_url"
        case public_or_private = "public_or_private"
        case referralCodeByNextUser = "referral_code_by_next_user"
        case instagram
        case dateOfBirth = "date_of_birth"
        case gender, otp, longitude, latitude
        case zodaic
        case jobTitle = "job_title"
        case school, languages, drinking, smoking, drugs
        case createdAt = "created_at"
        case events, followers, following
        case storyImage = "story_image"
    }
}


struct StoryImage: Codable {
    var id: String = String()
    var image: String = String()
}
