//
//  ConversationModel.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 31/03/2023.
//

import Foundation
import FirebaseFirestoreSwift
struct ConversationModel: Codable{
    @DocumentID var id : String? = String()
    var imageUrl :  String = String()
    var lastText :  String = String()
    var userId :  String = String()
    var userName :  String = String()
    var timeStamp :  Date = Date.now
}
