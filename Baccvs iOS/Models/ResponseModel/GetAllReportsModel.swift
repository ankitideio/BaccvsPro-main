//
//  GetAllReportsModel.swift
//  Baccvs iOS
//
//  Created by pm on 22/06/2023.
//

import Foundation
struct GetAllReportsModel : Codable {
    var status: Bool = Bool()
    var message: String = String()
    var body: [ReportDetail] = []
}


struct ReportDetail : Codable {
    var eventID: String = String()
    var eventName : String = String()
    var eventThumbnail: String = String()
    var eventTotalReport: Int = Int()

    enum CodingKeys: String, CodingKey {
        case eventID = "event_id"
        case eventName = "event_name"
        case eventThumbnail = "event_thumbnail"
        case eventTotalReport = "event_total_report"
    }
}
