//
//  GetMyGroupViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 08/03/2023.
//

import Foundation
import Combine
class  GetMyGroupViewModel : ObservableObject {
    @Published var  getMyGroupModel : GetMyGroupModel = GetMyGroupModel()
    private var myGroupData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    
    init(){
        myGroups()
    }
    func myGroups(){
        showProgress = true
        let url = URL(string: myGroupDev)!
        myGroupData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type:GetMyGroupModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getMyGroupModel = returnedProduct
                if self?.getMyGroupModel.status ?? false {
                    self?.showProgress = false
                }else {
                    self?.showProgress = false
                }
                print(self?.getMyGroupModel as Any)
                self?.myGroupData?.cancel()
            })
    }
}
