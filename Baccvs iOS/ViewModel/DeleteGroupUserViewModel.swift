//
//  DeleteGroupUserViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 03/05/2023.
//

import Foundation
import Combine
class DeleteGroupUserViewModel : ObservableObject {
    @Published var  deleteGroupUserModel  = DeleteGroupUserModel()
    @Published var  getDeleteGroupUserModel  = GetDeleteGroupUserModel()
    private var deleteGroupData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var queryItems : [URLQueryItem] = []

    func delGroupUser(){
        showProgress = true
        
        let dictData = deleteGroupUserModel.dict
     var urlComponents = URLComponents(string: deleteGroupUserDev)!
            dictData?.forEach({ dic in
                queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
            })
            urlComponents.queryItems = queryItems
            let url = urlComponents.url!
        
        deleteGroupData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "DELETE", url: url,dataThing: nil, boundary: nil))
            .decode(type:GetDeleteGroupUserModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getDeleteGroupUserModel = returnedProduct
                if self?.getDeleteGroupUserModel.status ?? false {
                    self?.showProgress = false
                   
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getDeleteGroupUserModel as Any)
                self?.deleteGroupData?.cancel()

            })
    }

}
