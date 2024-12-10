//
//  LeaveUserViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 19/05/2023.
//

import Foundation
import Combine
class LeaveUserViewModel : ObservableObject {
    @Published var leaveUserModel = LeaveGroupUserModel()
    @Published var getLeaveUserModel = GetLeaveUserModel()
    private var leaveUserData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var queryItems : [URLQueryItem] = []
    
    func leaveGroup(){
        showProgress = true
        
        let dictData = leaveUserModel.dict
     var urlComponents = URLComponents(string: deleteGropURL)!
            dictData?.forEach({ dic in
                queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
            })
            urlComponents.queryItems = queryItems
            let url = urlComponents.url!
        
        leaveUserData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "DELETE", url: url,dataThing: nil, boundary: nil))
            .decode(type:GetLeaveUserModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getLeaveUserModel = returnedProduct
                if self?.getLeaveUserModel.status ?? false {
                    self?.showProgress = false
                   
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getLeaveUserModel as Any)
                self?.leaveUserData?.cancel()

            })
    }
}
