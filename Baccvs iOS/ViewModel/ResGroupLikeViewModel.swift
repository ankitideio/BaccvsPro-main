//
//  ResGroupLikeViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 24/03/2023.
//

import Foundation
import Combine
class ResGroupLikeViewModel : ObservableObject {
//    @Published var groupLikeModel = GroupLikeModel()
//    @Published var resgroupLikeModel = ResGroupLikeModel()
//    private var groupLikeData : Cancellable?
//    @Published var showProgress = false
//    @Published var errorMessage = ""
//    @Published var queryItems : [URLQueryItem] = []
//
//    func groupLike(){
//        let dictData = groupLikeModel.dict
//        let blockUserURL  = URL(string: groupLikeURL)!
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
//        groupLikeData = NetworkLayer.download(url: blockUserURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: blockUserURL,dataThing: jsonData, boundary: nil))
//            .decode(type:ResGroupLikeModel.self, decoder: JSONDecoder())
//            .sink(receiveCompletion:  { [weak self] completion in
//                switch completion {
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                    self?.showProgress = false
//                case .finished:
//                    break
//                }
//            }, receiveValue: { [weak self] (returnedProduct) in
//                self?.resgroupLikeModel = returnedProduct
//                if self?.resgroupLikeModel.status ?? false {
//                    self?.showProgress = false
//                    
//                }else{
//                    self?.showProgress = false
//                }
//                print(self?.resgroupLikeModel as Any)
//                self?.groupLikeData?.cancel()
//                })
//    }
//   
 
}
