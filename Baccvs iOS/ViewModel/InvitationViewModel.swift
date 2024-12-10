//
//  InvitationViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 10/03/2023.
//

import Foundation
import Combine
class InvitationViewModel : ObservableObject {
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var invitationModel : GetInvitationModel =  GetInvitationModel()
    private var invitationData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    
    init(){
        listofUsers()
    }
   
    func listofUsers(){
        showProgress = true
        let url = URL(string:  getInvitationDev)!
        invitationData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetInvitationModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.invitationModel = returnedProduct
                if self?.invitationModel.status ?? false {
                    self?.showProgress = false
                }else{
                    self?.showProgress = false
                    self?.message = "Not Found"
                    self?.alertType = .error
                    self?.showAlert = true
                }
                print(self?.invitationModel)
                self?.invitationData?.cancel()
            })
    }
}
