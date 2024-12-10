//
//  UnBlockUserViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 06/03/2023.
//

import Foundation
import Combine

class UnBlockUserViewModel : ObservableObject {
    @Published var unBlockUserModel = UnBlockUserModel()
    @Published var getUnBlockUserModel = GetUnblockUserModel()
    private var  unBlockData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    
    
    func unBlockUser(){
        showProgress = true
        let dictData = unBlockUserModel.dict
        let blockUserURL  = URL(string: unBlockUserDev)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        unBlockData = NetworkLayer.download(url: blockUserURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: blockUserURL,dataThing: jsonData, boundary: nil))
            .decode(type:GetUnblockUserModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getUnBlockUserModel = returnedProduct
                if self?.getUnBlockUserModel.status ?? false {
                    self?.showProgress = false
                }else {
                    self?.showProgress = false
                }
                print(self?.getUnBlockUserModel as Any)
                self?.unBlockData?.cancel()

            })
    }
}

