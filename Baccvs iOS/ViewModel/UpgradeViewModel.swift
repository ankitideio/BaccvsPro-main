//
//  UpgradeViewModel.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 04/04/2023.
//

import Foundation
import RevenueCat
import SwiftUI
import Combine
class UpgrageViewModel : ObservableObject{
    @Published var isProModel : IsproprofileModel =   IsproprofileModel()
    @Published var getisProModel : GetisproprofileModel = GetisproprofileModel()
    @Published var checkprofileModel : GetCheckProfileModel = GetCheckProfileModel()
    private var checkProfiledata: AnyCancellable?
    private var isProProfiledata: AnyCancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var isPro = false
    @Published var gotohome = false

    
    
    init(){
        getCheckProfile()
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            print(error)
            self.isPro = customerInfo?.entitlements.all["pro"]?.isActive == true
        }
    }
    
    
    
    func getCheckProfile(){
        showProgress = true
        let url = URL(string: checkProfileDev)!
        checkProfiledata = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetCheckProfileModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.checkprofileModel = returnedProduct
                
                if self?.checkprofileModel.status ?? false {
                    self?.showProgress = false
                }else{
                    self?.showProgress = false
                    self?.message = "Not Found"
                    self?.alertType = .error
                    self?.showAlert = true
                }
                print(self?.checkprofileModel as Any)
                self?.checkProfiledata?.cancel()
            })
    }
    
    func isProprofile(){
        showProgress = true

        let dataThing = "pro=\(isProModel.pro)".data(using: .utf8)
     let url = URL(string: upgradeProfileURL)!
        isProProfiledata = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .xFormData, contentType: "POST", url: url, dataThing: dataThing, boundary: nil))
                .decode(type: GetisproprofileModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion:  { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                        self?.showProgress = false
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] (returnedProduct) in
                    self?.getisProModel = returnedProduct
                    if self?.getisProModel.status ?? false {
                        self?.showProgress = false
                        self?.message = "Pro update user successfully"
                        self?.alertType = .success
                        self?.showAlert = true
                        self?.gotohome = true
                        self?.getCheckProfile()
                    }else{
                        self?.showProgress = false
                        self?.message = self?.getisProModel.message ?? "Not Found"
                        self?.alertType = .error
                        self?.showAlert = true
                    }
                    print(self?.getisProModel as Any)
                    self?.isProProfiledata?.cancel()
                })
    }
    
}
