//
//  UserProfielDetailViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 14/03/2023.
//

import Foundation
import Combine
import UIKit
import SwiftUI
class UserProfielDetailViewModel : ObservableObject {
    @Published var getUserProfileModel  =  GetUserIdModel()
    @Published var userProfileModel =  UserIdModel()
    @Published var  peopleLikeModel  =  PeopleLikeModel()
    @Published var  getPeopleLikeModel  = GetPepleLikeModel()
    private var  userProfileDetailData : Cancellable?
    private var peopleLikeData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var queryItems : [URLQueryItem] = []
    @Published var imagesArray = ["userimg","userimg","userimg","userimg","userimg","userimg"]
    @Published var  isComplete = false
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var liedIds : [String] = []
    func userProfileDetail(){
        showProgress = true
        let dictData = userProfileModel.dict
     var urlComponents = URLComponents(string: userIdDev)!
            dictData?.forEach({ dic in
                queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
            })
            urlComponents.queryItems = queryItems
            let url = urlComponents.url!
        userProfileDetailData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetUserIdModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getUserProfileModel = returnedProduct
                if self?.getUserProfileModel.status ?? false {
                 self?.showProgress = false
                }else{
                    self?.showProgress = false
                }

                print(self?.getUserProfileModel)
                self?.userProfileDetailData?.cancel()
            })
    }

    func  profileLike(){
            isComplete = false
            showProgress = true
            let dictData = peopleLikeModel.dict
            let peopleLikeURL  = URL(string: peopleLikeURL)!
            let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        
        peopleLikeData = NetworkLayer.download(url: peopleLikeURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: peopleLikeURL,dataThing: jsonData, boundary: nil))
                .decode(type:GetPepleLikeModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                        self?.showProgress = false
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] (returnedProduct) in
                    self?.getPeopleLikeModel = returnedProduct
                    if self?.getPeopleLikeModel.status ?? false {
                        self?.isComplete = true
                        self?.showProgress = false
                        self?.message = "Successfully Like"
                        self?.alertType = .success
                        self?.showAlert = true
                    }else {
                        self?.isComplete = false
                        self?.showProgress = false
                        self?.message = "Not Found"
                        self?.alertType = .error
                        self?.showAlert = true
                    }
                    print(self?.getPeopleLikeModel as Any)
                    self?.peopleLikeData?.cancel()
                })
      
    }
    
}
