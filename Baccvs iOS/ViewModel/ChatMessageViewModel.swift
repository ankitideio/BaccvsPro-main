//
//  ChatMessageViewModel.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 31/03/2023.
//

import Foundation
import SwiftUI
class ChatMessageViewModel: ObservableObject{
    @Published var messagesList : [ChatMessageModel] = []
    @Published var message : ChatMessageModel = ChatMessageModel()
    @AppStorage ("userId") var  userId: String = String()
    @AppStorage ("userName") var userName : String = String()
    @AppStorage ("userImage") var userImage : String = String()
    let path = "Chat"
//    init(){
//        getAllChat()
//    }
    func getAllChat(senderToId: String){
        NetworkLayer.getChatData(userId: userId, reciverId : senderToId, path: path) {[weak self] snapshot in
            guard let documents = snapshot?.documents else { return }
            self?.messagesList = documents.compactMap({try? $0.data(as: ChatMessageModel.self)})
            self?.messagesList.sort{$0.timeStamp < $1.timeStamp}
            print(self?.messagesList as Any)
        }
    }
    func addMessagesToFireBase(senderToId:  String, reciverImage: String, senderUserName: String){
        let time = Date.now
        message.senderId = userId
        message.timeStamp = time
        let conPath = "Conversation"
        let dict = message.dictionary ?? [:]
        let conversationS = ConversationModel(imageUrl: reciverImage, lastText: message.text, userId: senderToId, userName: senderUserName, timeStamp: time).dictionary ?? [:]
        let conversationR = ConversationModel(imageUrl: userImage, lastText: message.text, userId: userId, userName: userName, timeStamp: time).dictionary ?? [:]
        self.message.text = ""
        print(dict)
        NetworkLayer.addDataToFirebase(userId: userId, reciverId: senderToId, path: self.path, value: dict) { comp in
            if comp{
                print(dict)
                NetworkLayer.addDataToFirebase(userId: senderToId, reciverId: self.userId, path: self.path, value: dict) { comp in
                    if comp{
                        
                    }
                }
                NetworkLayer.addDataToConversation(userId: self.userId, senderId: senderToId, path: conPath, value: conversationS) { comp in
                    if comp{
                        
                    }
                }
                NetworkLayer.addDataToConversation(userId: senderToId, senderId: self.userId, path: conPath, value: conversationR) { comp in
                    if comp{
                        
                    }
                }
            }
        }
    }
}
