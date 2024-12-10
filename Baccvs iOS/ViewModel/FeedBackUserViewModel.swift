//
//  FeedBackUserViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 14/03/2023.
//

import Foundation
import Combine
class FeedBackUserViewModel : ObservableObject {
    @Published var feedBack = FeedBackUserModel()
    @Published var getFeedBackModel = GetFeedBackUserModel()
    private var feedBackData : Cancellable?
    @Published var  isComplete = false
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    
    func feedBackUser(){
        if feedBack.mood != "" && feedBack.discription != ""{
            isComplete = false
            showProgress = true
            let dictData = feedBack.dict
            let blockUserURL  = URL(string: feedBackDev)!
            let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
            feedBackData = NetworkLayer.download(url: blockUserURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: blockUserURL,dataThing: jsonData, boundary: nil))
                .decode(type:GetFeedBackUserModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                        self?.showProgress = false
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] (returnedProduct) in
                    self?.getFeedBackModel = returnedProduct
                    if self?.getFeedBackModel.status ?? false {
                        self?.isComplete = true
                        self?.showProgress = false
                        self?.message = "Successfully FeedBack"
                        self?.alertType = .success
                        self?.showAlert = true
                    }else {
                        self?.isComplete = false
                        self?.showProgress = false
                        self?.message = "Not Found"
                        self?.alertType = .error
                        self?.showAlert = true
                    }
                    print(self?.getFeedBackModel as Any)
                    self?.feedBackData?.cancel()
                })
        }
    }
}
