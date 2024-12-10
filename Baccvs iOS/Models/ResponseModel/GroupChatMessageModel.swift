//
//  GroupChatMessageModel.swift
//  Baccvs iOS
//
//  Created by pm on 19/05/2023.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestoreSwift
struct GroupChatMessageModel: Codable{
    @DocumentID var id : String? = String()
    var senderId : String = String()
    var text: String = String()
    var image: String = String()
    var timeStamp: Date = Date()
}
