//
//  GroupChatViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 19/05/2023.
//

import Foundation
import SwiftUI
class GroupChatViewModel : ObservableObject{
    @Published var messagesList : [GroupChatMessageModel] = []
    @Published var message : GroupChatMessageModel = GroupChatMessageModel()
    @AppStorage ("userId") var  userId: String = String()
    @AppStorage ("userName") var userName : String = String()
    @AppStorage ("userImage") var userImage : String = String()
//    init(){
//        getAllChat()
//    }
    func getAllChat(groupID: String){
        NetworkLayer.getGroupChatData(groupID: groupID) {[weak self] snapshot in
            guard let documents = snapshot?.documents else { return }
            self?.messagesList = documents.compactMap({try? $0.data(as: GroupChatMessageModel.self)})
            self?.messagesList.sort{$0.timeStamp < $1.timeStamp}
            print(self?.messagesList as Any)
        }
    }
    func addMessagesToFireBase(groupID: String, senderToId:  String, reciverImage: String){
        let time = Date.now
        message.senderId = userId
        message.timeStamp = time
        let conPath = "Conversation"
        let dict = message.dictionary ?? [:]
        message.text = ""
        NetworkLayer.addDataToGroupChat(userId: userId, groupID: groupID, value: dict) { comp in
            if comp{
                print("sent")
            }
        }
    }
}
