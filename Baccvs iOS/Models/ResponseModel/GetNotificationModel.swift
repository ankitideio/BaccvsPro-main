//
//  GetNotificationModel.swift
//  Baccvs iOS
//
//  Created by pm on 29/04/2023.
//

import Foundation
struct GetNotificationModel : Codable {
    var status: Bool = Bool()
    var message: String = String()
    var body: [NotificationDetail] = []
}
struct NotificationDetail : Codable {
    var notificationID : String = String()
    var notificationPurposeId : String = String()
    var notificationType : String = String()
    var notificationImage : String = String()
    var notificationSender : String = String()
    var notificationMessage : String = String()
    var notificationSendTime : String = String()

    enum CodingKeys: String, CodingKey {
            case notificationID = "notification_id"
            case notificationPurposeId = "notification_purpose_id"
            case notificationType = "notification_type"
            case notificationImage = "notification_image"
            case notificationSender = "notification_sender"
            case notificationMessage = "notification_message"
            case notificationSendTime = "notification_send_time"
        }
}
