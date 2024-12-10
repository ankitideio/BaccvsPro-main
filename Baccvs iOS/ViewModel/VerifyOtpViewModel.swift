//
//  VerifyOtpViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 11/07/2023.
//
//
import Foundation
import Combine
class  VerifyOtpViewModel : ObservableObject {
    @Published  var verifyOtpModel = VerifyOtpModel()
    @Published var getVerifyOtpModel = GetVerifyOtpModel()
    private var verifyOtpData : AnyCancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var gotoOtpPage : Bool = false

    
    func verifyOTP(){
        showProgress = true
        let phoneNumberString = String(verifyOtpModel.phone_number)
        var formatedNumber = ""
        if let encodedPhoneNumber = phoneNumberString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            print(encodedPhoneNumber)
            let finalPhoneNumber = encodedPhoneNumber.replacingOccurrences(of: "+", with: "%2B")
            print(finalPhoneNumber)
            formatedNumber = finalPhoneNumber
        } else {
            print("Failed to encode the phone number.")
        }
        let dataThing = "phone_number=\(formatedNumber)&code=\(verifyOtpModel.code)".data(using: .utf8)
     let url = URL(string: verifyOtpURL)!
        verifyOtpData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .xFormData, contentType: "POST", url: url, dataThing: dataThing, boundary: nil))
                .decode(type: GetVerifyOtpModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion:  { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                        self?.showProgress = false
                        self?.message = "Not Found"
                        self?.alertType = .error
                        self?.showAlert = true
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] (returnedProduct) in
                    self?.getVerifyOtpModel = returnedProduct
                    if self?.getVerifyOtpModel.status ?? false {
                        self?.showProgress = false
                        self?.message = "OTP verified successfully"
                        self?.alertType = .success
                        self?.gotoOtpPage = true
                        self?.showAlert = true
                    }else{
                        self?.showProgress = false
                        self?.message = self?.getVerifyOtpModel.message ?? "Not Found"
                        self?.alertType = .error
                        self?.showAlert = true
                        self?.gotoOtpPage = false
                    }
                    print(self?.getVerifyOtpModel as Any)
                    self?.verifyOtpData?.cancel()
                })
    }
   
}
