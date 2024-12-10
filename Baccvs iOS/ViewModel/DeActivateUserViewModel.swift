//
//  DeActivateUserViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 06/03/2023.
//

import Foundation
import Combine
class  DeActivateUserViewModel : ObservableObject {
    @Published var deactivateModel = DeactivateModel()
    @Published var deActivateUserModel = DeActivateUserModel()
    @Published var queryItems : [URLQueryItem] = []
    private var deActivateUserData : Cancellable?
    private var deleteAccontData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    
    func deActivateUser(){
        
        if  deactivateModel.is_delete == true {
            showProgress = true
            let dictData = deactivateModel.dict
            let updatePassworURL  = URL(string: deActivateDev)!
            let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
            deActivateUserData = NetworkLayer.download(url: updatePassworURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "PUT", url: updatePassworURL,dataThing: jsonData, boundary: nil))
                .decode(type: DeActivateUserModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                        self?.showProgress = false
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] (returnedProduct) in
                    self?.deActivateUserModel = returnedProduct
                    if self?.deActivateUserModel.status ?? false {
                        self?.showProgress = false
                        self?.message = "Account Deactivate successfully"
                        self?.alertType = .success
                        self?.showAlert = true
                    }else{
                        self?.showProgress = false
                        self?.message = "Not Found"
                        self?.alertType = .error
                        self?.showAlert = true
                    }
                    
                    print(self?.deActivateUserModel as Any)
                    self?.deActivateUserData?.cancel()
                })
        }
        
    }
    func deleteAccount(){
            showProgress = true
            let updatePassworURL  = URL(string: deleteAccountURL)!
        deleteAccontData = NetworkLayer.download(url: updatePassworURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "DELETE", url: updatePassworURL,dataThing: nil, boundary: nil))
                .decode(type: DeActivateUserModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                        self?.showProgress = false
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] (returnedProduct) in
                    self?.deActivateUserModel = returnedProduct
                    if self?.deActivateUserModel.status ?? false {
                        self?.showProgress = false
                        self?.message = "Account Deleted successfully"
                        self?.alertType = .success
                        self?.showAlert = true
                    }else{
                        self?.showProgress = false
                        self?.message = "Not Found"
                        self?.alertType = .error
                        self?.showAlert = true
                    }
                    
                    print(self?.deActivateUserModel as Any)
                    self?.deleteAccontData?.cancel()
                })
        
 
}
}
