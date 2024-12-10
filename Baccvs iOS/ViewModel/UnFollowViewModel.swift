//
//  UnFollowViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 01/05/2023.
//

import Foundation
import Combine
class UnFollowViewModel : ObservableObject {
    @Published var getUnfollowModel = GetUnfollowModel()
    @Published var unfollowModel = UnFollowModel()
    private var unfollowData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var queryItems : [URLQueryItem] = []
    
    func unFollow(){
        showProgress = true
        let dictData = unfollowModel.dict
        var urlComponents = URLComponents(string: unfollowDev)!
        dictData?.forEach({ dic in
            queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
        })
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        unfollowData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "DELETE", url: url,dataThing: jsonData, boundary: nil))
            .decode(type:GetUnfollowModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getUnfollowModel = returnedProduct
                if self?.getUnfollowModel.status ?? false {
                    self?.showProgress = false
                   
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getUnfollowModel as Any)
                self?.unfollowData?.cancel()

            })
    }
}
