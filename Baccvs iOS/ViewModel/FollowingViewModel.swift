//
//  FollowingViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 05/04/2023.
//

import Foundation
import Combine
import SwiftUI
class FollowingViewModel : ObservableObject {
    @Published var followingModel = FollowingModel()
    @Published var getFollowingModel = GetFollowingModel()
    private var followingData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var changeName = ""
//    @Published var buttonText : String  = "Follow"
    @AppStorage("buttonText")  var buttonText = "Follow"
    
   
    
    func followingUser(){
        showProgress = true
        let dictData = followingModel.dict
        let creatrReferralURL  = URL(string: followingDev)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        followingData = NetworkLayer.download(url: creatrReferralURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: creatrReferralURL,dataThing: jsonData, boundary: nil))
            .decode(type:GetFollowingModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getFollowingModel = returnedProduct
                if self?.getFollowingModel.status ?? false {
                    self?.showProgress = false
                   
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getFollowingModel as Any)
                self?.followingData?.cancel()

            })
    }
}
