//
//  GetAllUsersViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 15/03/2023.
//

import Foundation
import Combine
class GetAllUsersViewModel: ObservableObject{
    @Published var allUsers :  GetAllUsersModels = GetAllUsersModels()
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var searchBar = ""
    private var allUserData : Cancellable?
    
    init(){
        getAllUsers()
    }
    
    var filteredAllUsers: [GetAllUsersBody] {
           if searchBar.isEmpty {
               return []
           } else {
               let lowercasedSearchText = searchBar.lowercased()
               return allUsers.body.filter { $0.name.lowercased().contains(lowercasedSearchText) }
           }
       }

    func getAllUsers(){
        let url = URL(string: getAllUsersUrl)!
        allUserData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetAllUsersModels.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.allUsers = returnedProduct
                
                if self?.allUsers.status ?? false {
                  
                    self?.showProgress = false
                   
                }else{
                    self?.showProgress = false
                    self?.message = "Not Found"
                    self?.alertType = .error
                    self?.showAlert = true
                }
                print(self?.allUsers as Any)
                self?.allUserData?.cancel()
            })
    }
}
