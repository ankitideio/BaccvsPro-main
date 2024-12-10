//
//  OTPCheckViewModel.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 12/03/2023.

import Foundation
import Combine
class  OTPCheckViewModel : ObservableObject {
    @Published  var sendOtpModel = SendOtpModel()
    @Published var getSendOtpModel = GetSendOtpModel()
    private var otpCancelData : AnyCancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var gotoOtpPage : Bool = false
    @Published var selectedCode = "+33"
    func sendOTP() {
        showProgress = true
        let phoneNumberString = String(selectedCode + sendOtpModel.phone_number)
        var formattedNumber = ""
        
        if let encodedPhoneNumber = phoneNumberString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let finalPhoneNumber = encodedPhoneNumber.replacingOccurrences(of: "+", with: "%2B")
            formattedNumber = finalPhoneNumber
        } else {
            print("Failed to encode the phone number.")
            showProgress = false
            return
        }
        
        let dataThing = "phone_number=\(formattedNumber)".data(using: .utf8)
        let url = URL(string: "https://web-production-232c.up.railway.app/send-otp")!
        
        otpCancelData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .xFormData, contentType: "POST", url: url, dataThing: dataThing, boundary: nil))
            .decode(type: GetSendOtpModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                    self?.showAlert = true
                    self?.message = "Error Occurred" 
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getSendOtpModel = returnedProduct
                if self?.getSendOtpModel.status ?? false {
                    self?.showProgress = false
                    self?.message = "OTP sent successfully"
                    self?.alertType = .success
                    self?.showAlert = true
                    self?.gotoOtpPage = true
                } else {
                    self?.showProgress = false
                    self?.alertType = .error
                    self?.showAlert = true
                    self?.message = self?.getSendOtpModel.message ?? "Not Found"
                  
                }
                self?.otpCancelData?.cancel()
            })
    }
}
