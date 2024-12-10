//
//  GetYamatetPeopleModel.swift
//  Baccvs iOS
//
//  Created by pm on 17/02/2023.
//

import Foundation
struct GetYamatetPeopleModel :Codable {
           var status : Bool = Bool()
           var message : String = String()
           var body : [Users] = []

}

struct Users: Codable {
    var id : String = String()
    var name : String = String()
    var image : String = String()
    var longitude : String = String()
    var latitude : String = String()
    

    
}






