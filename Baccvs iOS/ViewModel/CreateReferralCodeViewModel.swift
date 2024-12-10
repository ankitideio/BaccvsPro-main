//
//  CreateReferralCodeViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 07/03/2023.
//

import Foundation
import Combine
import SwiftUI
class CreateReferralCodeViewModel : ObservableObject {
    @Published var getReferralCodelModel = GetCreateReferralCodeModel()
    private var referralCodeData : Cancellable?
    @Published var  isComplete = false
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var urlShare = ""
    func createReferral(){
        isComplete = false
        showProgress = true
        let dictData = getReferralCodelModel.dict
        let creatrReferralURL  = URL(string: createReferralDev)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        referralCodeData = NetworkLayer.download(url: creatrReferralURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: creatrReferralURL,dataThing: jsonData, boundary: nil))
            .decode(type:GetCreateReferralCodeModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.alertType = .error
                    self?.showAlert = true
                    self?.showProgress = false
                    self?.message = self?.errorMessage ?? "something wrong"
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getReferralCodelModel = returnedProduct
                if self?.getReferralCodelModel.status ?? false {
                    self?.isComplete = true
                    self?.showProgress = false
                    self?.message = "Referral Code generated Successfully"
                    self?.alertType = .success
                    self?.showAlert = true
                    self?.urlShare  = self?.getReferralCodelModel.referral_code ?? ""
                    self?.share()
                }else{
                    self?.isComplete = false
                    self?.showProgress = false
                    self?.alertType = .error
                    self?.showAlert = true
                    self?.message = self?.getReferralCodelModel.message ?? "You cannot create more because your code limit is completed."
                    
                   
                }
                print(self?.getReferralCodelModel as Any)
                self?.referralCodeData?.cancel()

            })
    }
    func share(){
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC,animated: true,completion: nil)
    }
}
