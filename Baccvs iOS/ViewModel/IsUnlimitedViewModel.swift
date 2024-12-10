//
//  IsUnlimitedViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 25/03/2023.
//

import Foundation
import Combine
class IsUnlimitedViewModel : ObservableObject {
    @Published var isUnlimitedModel = IsUnlimitedModel()
    @Published var getIsUnlimitedModel = GetIsUnlimitedModel()
    private var isUnlimtedData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    
    func isUnlimited(){
        showProgress = true
        let dictData = getIsUnlimitedModel.dict
        let creatrReferralURL  = URL(string: isUnlimitedURL)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        isUnlimtedData = NetworkLayer.download(url: creatrReferralURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: creatrReferralURL,dataThing: jsonData, boundary: nil))
            .decode(type:GetIsUnlimitedModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getIsUnlimitedModel = returnedProduct
                if self?.getIsUnlimitedModel.status ?? false {
                    self?.showProgress = false
                   
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getIsUnlimitedModel as Any)
                self?.isUnlimtedData?.cancel()

            })
    }
}
