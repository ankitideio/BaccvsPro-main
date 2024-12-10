//
//  SentInvitationViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 16/03/2023.
//
import Combine
import SwiftUI
import Combine

class SentInvitationViewModel : ObservableObject{
    @Published var  sentInviteModel : GetSentInvitationModel = GetSentInvitationModel()
    private var sentInviteData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    
    init(){
        inviteSent()
    }
    
    func inviteSent(){
        showProgress = true
        let url = URL(string:  getSendInvitationDev)!
        sentInviteData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetSentInvitationModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.sentInviteModel = returnedProduct
                if self?.sentInviteModel.status ?? false {
                    self?.showProgress = false
                }else{
                    self?.showProgress = false
                }
                print(self?.sentInviteModel)
                self?.sentInviteData?.cancel()
            })
    }
}
