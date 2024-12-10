//
//  SignupViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 16/02/2023.
//

import Foundation
import Combine
import SwiftUI
import OneSignal
class SignupViewModel : ObservableObject{
    @Published  var signup = SignupModel()
    @Published  var loginModel  :  NewDetail =  NewDetail()
    @Published var confirmpassword: String = ""
    @Published var isComplete = false
    @Published var queryItems : [URLQueryItem] = []
    private var signupData: AnyCancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @AppStorage ("deviceToken") var deviceToken: String = String()
    @AppStorage("isLogedIn") var isLogedIn : Bool = Bool()
    @AppStorage ("email") var  email: String = String()
    @AppStorage ("userId") var  userId: String = String()
    @AppStorage ("userImage") var userImage : String = String()
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published  var alertMessage = ""
    
    func Signup(){
        if signup.name != "" && signup.email != "" && signup.dateOfBirth != "" && signup.instagram != "" && signup.gender != "" && signup.password != "" && signup.description != "" && signup.deviceToken != ""  {
            isComplete = false
            showProgress = true
            let dictData = signup.dict
            print(String(describing: dictData))
            let url = URL(string: signupDev)!
            let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
            signupData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: url,dataThing: jsonData, boundary: nil))
                .decode(type: NewDetail.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                        self?.showProgress = false
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] (returnedProduct) in
                    self?.loginModel = returnedProduct
                    if self?.loginModel.status ?? false {
                        self?.isComplete = true
                        self?.showProgress = false
                        self?.isLogedIn = true
                        self?.deviceToken = (self?.loginModel.body.accessToken)!
                        self?.userId = self?.loginModel.body.id ?? ""
                        self?.userImage = self?.loginModel.body.profileImage ?? ""
                        self?.setUserIdToOnesignal(userID: self?.loginModel.body.id ?? "")
                        self?.email = self?.loginModel.body.email ?? ""
                        self?.message = "Account Created successfully"
                        self?.alertType = .success
                        self?.showAlert = true
                    }else{
                        self?.isComplete = false
                        self?.showProgress = false
                        self?.message = "Invalid credentials"
                        self?.alertType = .error
                        self?.showAlert = true
                    }
                    print(self?.loginModel as Any)
                    self?.signupData?.cancel()
                    
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
