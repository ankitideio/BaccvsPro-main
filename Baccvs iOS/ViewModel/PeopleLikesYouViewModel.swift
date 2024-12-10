//
//  PeopleLikesYouViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 02/03/2023.
//

import Foundation
import SwiftUI
import Combine
class  PeopleLikesYouViewModel : ObservableObject {
    @Published var peopleLikesYouModel : GetPeopleLikesYouModel = GetPeopleLikesYouModel()
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var showProgress = false
    @Published var errorMessage = ""
    private var peopleLikeData :   Cancellable?
    
    
    
//    init(){
//        peopleLikes()
//    }
    func peopleLikes(){
        showProgress = true
        let url = URL(string: peopleLikeYouDev)!
        peopleLikeData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetPeopleLikesYouModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.peopleLikesYouModel = returnedProduct
                print(self?.peopleLikesYouModel)
                self?.peopleLikeData?.cancel()
            })
    }

}
