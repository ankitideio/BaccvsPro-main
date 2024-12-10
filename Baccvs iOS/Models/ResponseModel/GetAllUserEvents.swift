//
//  GetAllUserEvents.swift
//  Baccvs iOS
//
//  Created by pm on 28/04/2023.
//

import Foundation
import Foundation
struct GetAllUserEvents : Codable {
    var  status: Bool = Bool()
    var  message: String = String()
    var  body: [GetPostsForUsersHomeBody] = []
}
