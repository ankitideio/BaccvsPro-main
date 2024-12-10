//
//  CheckReferralCodeViewMode.swift
//  Baccvs iOS
//
//  Created by pm on 16/02/2023.
//
import Foundation
import SwiftUI
import Combine

class CheckReferralCodeViewMode : ObservableObject {
    @Published var   refferalCode = ReferralCodeModel()
    @Published var   refferCode =  GetReferralCodeModel()
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var queryItems : [URLQueryItem] = []
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    private var refData: AnyCancellable?
    @Published var  isrefCode : Bool  = false

    
         func referral(){
             if refferalCode.referral_code != ""{
                showProgress = true
                let dictData = refferalCode.dict
                var urlComponents = URLComponents(string: checkReferralCode)!
                queryItems = []
                dictData?.forEach({ dic in
                    queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
                })
                urlComponents.queryItems = queryItems
                let url = urlComponents.url!
                print(url)
                refData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url,dataThing: nil, boundary: nil))
                    .decode(type: GetReferralCodeModel.self, decoder: JSONDecoder())
                    .sink(receiveCompletion: { [weak self] completion in
                        switch completion {
                        case .failure(let error):
                            self?.errorMessage = error.localizedDescription
                            self?.showProgress = false
                            self?.showAlert = true
                            self?.message =  "Not Found"
                        case .finished:
                            break
                        }
                    }, receiveValue: { [weak self] (returnedProduct) in
                        self?.refferCode = returnedProduct
                        if self?.refferCode.status ?? false {
                            self?.showProgress = false
                            self?.message = "Referral Code  Successfully Done "
                            self?.alertType = .success
                            self?.showAlert = true
                            self?.isrefCode = true
                           
                        }else{
                            self?.showProgress = false
                            self?.alertType = .error
                            self?.showAlert = true
                            self?.message = self?.refferCode.message ?? "Not Found"
                        }
                        self?.refData?.cancel()
                    })
            }
        }
}

