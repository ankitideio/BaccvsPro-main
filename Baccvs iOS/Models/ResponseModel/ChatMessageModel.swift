//
//  ChatMessageModel.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 31/03/2023.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestoreSwift
struct ChatMessageModel: Codable{
    @DocumentID var id : String? = String()
    var senderId : String = String()
    var text: String = String()
    var timeStamp: Date = Date()
}
