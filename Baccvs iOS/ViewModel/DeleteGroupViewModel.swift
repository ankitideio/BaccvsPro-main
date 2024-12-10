//
//  DeleteGroupViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 05/05/2023.
//

import Foundation
import Combine
class DeleteGroupViewModel : ObservableObject {
    @Published var  deleteGroupModel  =  DeleteGroupModel()
    @Published var  getDeleteGroupModel  = GetDeletGroupModel()
    private var deleteGroupData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    
    func delGroup(){
        showProgress = true
        let dictData = deleteGroupModel.dict
        let creatrReferralURL  = URL(string: deleteGroupURL)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        deleteGroupData = NetworkLayer.download(url: creatrReferralURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "DELETE", url: creatrReferralURL,dataThing: jsonData, boundary: nil))
            .decode(type:GetDeletGroupModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getDeleteGroupModel = returnedProduct
                if self?.getDeleteGroupModel.status ?? false {
                    self?.showProgress = false

                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getDeleteGroupModel as Any)
                self?.deleteGroupData?.cancel()

            })
    }
    
}
