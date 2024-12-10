//
//  updatePasswordViewModel.swift
//  Baccvs iOS
//  Created by pm on 06/03/2023.
//

import Foundation
import Combine
import SwiftUI
class UpdatePasswordViewModel : ObservableObject{
    @Published var updatePasswordModel =  UpdatePasswordModel()
    @Published var getUpdatePasswordModel =  GetUpdatePasswordModel()
    @Published var loginModel = LoginModel()
    @Published var getUserModel = GetUserModel()
    @Published var isUpdate = false
    @Published  var alertMessage = ""
    @Published var currentPassword : String = ""
    @Published var confirmpassword: String = ""
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var queryItems : [URLQueryItem] = []
    private var updatePasswordData: AnyCancellable?
    @AppStorage ("deviceToken") var deviceToken: String = String()
    @AppStorage ("email") var  email: String = String()
    @AppStorage("isLogedIn") var isLogedIn : Bool = Bool()

    func updatePssword(){
        showProgress = true
        let dictData = updatePasswordModel.dict
        let updatePassworURL  = URL(string: updatePasswordDev)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        
      updatePasswordData = NetworkLayer.download(url: updatePassworURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "PUT", url: updatePassworURL,dataThing: jsonData, boundary: nil))
            .decode(type: GetUpdatePasswordModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion:{ [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                    self?.showAlert = true
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getUpdatePasswordModel = returnedProduct
                
                if self?.getUpdatePasswordModel.status == true  {
                    self?.showProgress = false
                    self?.isUpdate = true
                    self?.message =   self?.getUpdatePasswordModel.message ??  "Successfully Change Your Password"
                    self?.alertType = .success
                    self?.showAlert = true
                
                }else {
                    self?.isUpdate = false
                    self?.showProgress = false
                    self?.message = self?.getUpdatePasswordModel.message ?? "Does Not Change Your Password becacase Missing something"
                    self?.alertType = .error
                    self?.showAlert = true
                   
                }
                
                print(self?.getUpdatePasswordModel as Any)
                self?.updatePasswordData?.cancel()

            })

    }
    func signin(completion: @escaping(Bool) -> Void){
        if  loginModel.username != ""  && loginModel.password != ""{
            showProgress = true
           let dataThing = "username=\(loginModel.username)&password=\(loginModel.password)".data(using: .utf8)
            let url = URL(string: loginDev)!
            updatePasswordData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .xFormData, contentType: "POST", url: url, dataThing: dataThing!, boundary: nil))
                .decode(type: GetUserModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                        self?.showProgress = false
                        self?.showAlert = true
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] (returnedProduct) in
                    self?.getUserModel = returnedProduct
                    if self?.getUserModel.dataUser.status == true{
                        self?.deviceToken = self?.getUserModel.accessToken ?? ""
                        self?.email = self?.getUserModel.dataUser.email ?? ""
                        self?.showProgress = false
//                        self?.message = self?.getloginModel.Data_User.message ?? "Login Created successfully"
                        self?.alertType = .success
                        self?.showAlert = false
                        self?.showProgress = false
                        self?.isLogedIn = true
                        completion(true)
                    }else{
                        self?.showProgress = false
                        self?.alertType = .error
                        self?.showAlert = true
                        self?.message = self?.getUserModel.dataUser.message ?? "Not Found"
                        self?.isLogedIn = false
                    }
                    self?.showProgress = false
                    print(self?.getUserModel as Any)
                    self?.updatePasswordData?.cancel()
                })
        }
    }

}
