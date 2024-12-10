//
//  LoginViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 17/02/2023.
//
import Foundation
import SwiftUI
import Combine
import OneSignal
class LoginViewModel : ObservableObject{
    @Published var getUserModel = GetUserModel()
    @Published var loginModel = LoginModel()
    @Published var isClient = false
    @Published var isAdm = false
    @Published var showProgress = false
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var errorMessage = ""
    @AppStorage ("deviceToken") var deviceToken: String = String()
    @AppStorage("isLogedIn") var isLogedIn : Bool = Bool()
    @AppStorage ("email") var  email: String = String()
    private var productSubscription: AnyCancellable?
    @AppStorage ("isAdmin") var isAdmin : Int?
    @AppStorage ("isUser") var isUser : Int?
    @AppStorage ("userId") var  userId: String = String()
    @AppStorage ("userImage") var userImage : String = String()
    func userLogin(completion: @escaping(Bool) -> Void){
        if  loginModel.username != ""  && loginModel.password != ""{
            showProgress = true
           let dataThing = "username=\(loginModel.username)&password=\(loginModel.password)".data(using: .utf8)
            let url = URL(string: loginDev)!
            productSubscription = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .xFormData, contentType: "POST", url: url, dataThing: dataThing!, boundary: nil))
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
                        self?.showProgress = false
                        self?.message = self?.getUserModel.dataUser.message ?? "Login Created successfully"
                        self?.alertType = .success
                        self?.showAlert = true
                        self?.email = self?.getUserModel.dataUser.email ?? ""
                        self?.deviceToken = self?.getUserModel.accessToken ?? ""
                        self?.setUserIdToOnesignal(userID: self?.getUserModel.dataUser.id ?? "")
                        self?.showProgress = false
                        self?.userId = self?.getUserModel.dataUser.id ?? ""
                        self?.userImage = self?.getUserModel.dataUser.profileImageURL ?? ""
               if self?.loginModel.username == "Touri.said@hotmail.com" && self?.loginModel.password == "SaidBacc94!" {
                            self?.isAdmin = 1
                            self?.isAdm = true
                        }else{
                            self?.isUser = 1
                            self?.isClient = true
                        }
                       self?.isLogedIn = true
                        completion(true)
                    }else{
                        self?.showProgress = false
                        self?.alertType = .error
                        self?.showAlert = true
                        self?.isLogedIn = false
                        self?.message = self?.getUserModel.dataUser.message ?? "Not Found"

                    }
                    self?.showProgress = false
                    print(self?.getUserModel as Any)
                    self?.productSubscription?.cancel()
                })
        }
    }
    func setUserIdToOnesignal(userID: String){
        let externalUserId = userID // You will supply the external user id to the OneSignal SDK

        // Setting External User Id with Callback Available in SDK Version 3.0.0+
        OneSignal.setExternalUserId(externalUserId, withSuccess: { results in
            // The results will contain push and email success statuses
            print("External user id update complete with results: ", results!.description)
            // Push can be expected in almost every situation with a success status, but
            // as a pre-caution its good to verify it exists
            if let pushResults = results!["push"] {
                print("Set external user id push status: ", pushResults)
            }
            if let emailResults = results!["email"] {
                print("Set external user id email status: ", emailResults)
            }
            if let smsResults = results!["sms"] {
                print("Set external user id sms status: ", smsResults)
            }
        }, withFailure: {error in
            print("Set external user id done with error: " + error.debugDescription)
        })
    }
}
