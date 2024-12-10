//
//  GetFollowingUserModel.swift
//  Baccvs iOS
//
//  Created by pm on 17/02/2023.
//

import Foundation
import Combine
import SwiftUI
struct  GetFollowingUserModel : Codable {
    var status : Bool = Bool()
    var message : String  =  String()

    var body : [User] = []
}

