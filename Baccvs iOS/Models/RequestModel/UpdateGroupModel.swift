//
//  UpdateGroupModel.swift
//  Baccvs iOS
//
//  Created by pm on 03/05/2023.
//

import Foundation
struct UpdateGroupModel : Codable {
    var groupID: GroupID = GroupID()
    var groupData: GroupData   = GroupData()

    enum CodingKeys: String, CodingKey {
        case groupID = "group_id"
        case groupData = "group_data"
    }
    
}

struct GroupData: Codable {
    var groupName : String  = String()
    var groupDescription : String  = String()

    enum CodingKeys: String, CodingKey {
        case groupName = "group_name"
        case groupDescription = "group_description"
    }
}

// MARK: - GroupID
struct GroupID: Codable {
    var  id: String = String()
}
