//
//  ConversationViewModel.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 31/03/2023.
//

import Foundation
import SwiftUI
class ConversationViewModel: ObservableObject{
    @Published var conversationAray : [ConversationModel] = []
    @Published var searchBar = ""
    @AppStorage ("userId") var  userId: String = String()
    var searchAbleUsersList : [ConversationModel] {
        if searchBar.isEmpty{
            return conversationAray
        }else{
            let lowerCaseSearch = searchBar.lowercased()
            return conversationAray.filter({$0.userName.lowercased().contains(lowerCaseSearch)})
        }
    }
    

    init(){
        getAllChat()
    }
    func getAllChat(){
        let path = "Conversation"
        NetworkLayer.getData(userId: userId, path: path) {[weak self] snapshot in
            guard let documents = snapshot?.documents else { return }
            self?.conversationAray = documents.compactMap({try? $0.data(as: ConversationModel.self)})
            print(self?.conversationAray as Any)
        }
    }
}
