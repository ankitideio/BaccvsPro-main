//
//  IsPublicOnlineViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 11/03/2023.
//

import Foundation
import Combine
class IsPublicOnlineViewModel : ObservableObject {
    @Published var isPublicOnlieModel = IsPublicOnlieModel()
    private var publicOnlineData : Cancellable?
    
    
    func isPublicOnle(){
        let dictData = isPublicOnlieModel.dict
        let blockUserURL  = URL(string: isPublicDev)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        publicOnlineData = NetworkLayer.download(url: blockUserURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: blockUserURL,dataThing: jsonData, boundary: nil))
            .decode(type:IsPublicOnlieModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkLayer.handleCompletion, receiveValue: { [weak self] (returnedProduct) in
                self?.isPublicOnlieModel = returnedProduct
                print(self?.isPublicOnlieModel as Any)
                self?.publicOnlineData?.cancel()

            })
    }
    
}
