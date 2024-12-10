//
//  DeleteEventViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 16/04/2023.
//

import Foundation
import Combine
class DeleteEventViewModel : ObservableObject {
    @Published var deleEventModel = DeleteEventModel()
    @Published var getDeleEventModel = GetDeletEventModel()
    private var deleteEventData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    
    func delEvent(){
        showProgress = true
        let dictData = deleEventModel.dict
        let creatrReferralURL  = URL(string: deleteEventDev)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        deleteEventData = NetworkLayer.download(url: creatrReferralURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "DELETE", url: creatrReferralURL,dataThing: jsonData, boundary: nil))
            .decode(type:GetDeletEventModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getDeleEventModel = returnedProduct
                if self?.getDeleEventModel.status ?? false {
                    self?.showProgress = false
                   
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getDeleEventModel as Any)
                self?.deleteEventData?.cancel()

            })
    }
}
