//
//  EventLikeViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 06/05/2023.
//

//import Foundation
//import Combine
//class EventLikeViewModel : ObservableObject {
//    @Published var eventLikeModel = EventLikeModel()
//    @Published var getEventLikeModel = GetEventLikeModel()
//    @Published var liedIds : [String] = []
//    private var  eventLikeData : Cancellable?
//    @Published var showProgress = false
//    @Published var errorMessage = ""
//    
//    func likeUnLike(id: String){
//        if liedIds.contains(where: {$0 == id}){
//            liedIds.removeAll(where: {$0 == id})
//        }else{
//            liedIds.append(id)
//        }
//    }
//    func eventLike(){
//        let dictData = eventLikeModel.dict
//        let blockUserURL  = URL(string: eventLikeURL)!
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
//        eventLikeData = NetworkLayer.download(url: blockUserURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: blockUserURL,dataThing: jsonData, boundary: nil))
//            .decode(type:GetEventLikeModel.self, decoder: JSONDecoder())
//            .sink(receiveCompletion:  { [weak self] completion in
//                switch completion {
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                    self?.showProgress = false
//                case .finished:
//                    break
//                }
//            }, receiveValue: { [weak self] (returnedProduct) in
//                self?.getEventLikeModel = returnedProduct
//                if self?.getEventLikeModel.status ?? false {
//                    self?.showProgress = false
//                    
//                }else{
//                    self?.showProgress = false
//                }
//                print(self?.getEventLikeModel as Any)
//                self?.eventLikeData?.cancel()
//                })
//    }
//}
