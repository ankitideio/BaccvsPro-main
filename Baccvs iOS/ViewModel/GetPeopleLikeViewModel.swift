//
//  GetPeopleLikeViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 03/03/2023.
//

import Foundation
import Combine
class GetPeopleLikeViewModel : ObservableObject {
    @Published var getPeopleLikeModel : GetPeopleLikeModel = GetPeopleLikeModel()
    private var getPeopleLikeData : Cancellable?
    
//    init(){
//        meetPeopleOnline()
//    }
    func getPeopleILike(){
        let url = URL(string: peopleLikeDev)!
        getPeopleLikeData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetPeopleLikeModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkLayer.handleCompletion, receiveValue: { [weak self] (returnedProduct) in
                self?.getPeopleLikeModel = returnedProduct
                print(self?.getPeopleLikeModel)
                self?.getPeopleLikeData?.cancel()
            })
    }
}
