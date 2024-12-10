//
//  AllBlockUserViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 06/03/2023.
//

import Foundation
import Combine
class  AllBlockUserViewModel : ObservableObject {
    @Published var getAllBlockUserModel : GetAllBlockUserModel = GetAllBlockUserModel()
    private var allblockUserData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var searchBar = ""

    init(){
        allBlockUsers()
    }
    
    var filteredBlockUsers: [AllBlockUser] {
           if searchBar.isEmpty {
               return getAllBlockUserModel.body
           } else {
               let lowercasedSearchText = searchBar.lowercased()
               return getAllBlockUserModel.body.filter { $0.name.lowercased().contains(lowercasedSearchText) }
           }
       }
    
    func allBlockUsers(){
        let url = URL(string: allBlockUserDev)!
        allblockUserData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetAllBlockUserModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getAllBlockUserModel = returnedProduct
                if self?.getAllBlockUserModel.status ?? false {
                    self?.showProgress = false
                }else {
                    self?.showProgress = false
                    self?.message = "Not Found"
                    self?.alertType = .error
                    self?.showAlert = true
                }

                print(self?.getAllBlockUserModel)
                self?.allblockUserData?.cancel()
            })
    }
}
