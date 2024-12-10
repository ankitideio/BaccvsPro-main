//
//  RemoveFollowerViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 03/04/2023.
//
//
//import Foundation
//import Combine
//class RemoveFollowerViewModel : ObservableObject {
//    @Published var  removeFollwerModel = RemoveFollowerModel()
//    @Published var getRemoveFollwerModel =  GetRemoveFollowerModel()
//    @Published var queryItems : [URLQueryItem] = []
//    @Published var showProgress = false
//    @Published var errorMessage = ""
//    private var removeFollowerData : Cancellable?
//
//
//    func removeFollwer(){
//        let dictData = removeFollwerModel.dict
//     var urlComponents = URLComponents(string: removeFollowerDev)!
//            dictData?.forEach({ dic in
//                queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
//            })
//            urlComponents.queryItems = queryItems
//            let url = urlComponents.url!
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
//        removeFollowerData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: url,dataThing: jsonData, boundary: nil))
//            .decode(type:GetRemoveFollowerModel.self, decoder: JSONDecoder())
//            .sink(receiveCompletion: { [weak self] completion in
//                switch completion {
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                    self?.showProgress = false
//                case .finished:
//                    break
//                }
//            }, receiveValue: { [weak self] (returnedProduct) in
//                self?.getRemoveFollwerModel = returnedProduct
//                print(self?.getRemoveFollwerModel as Any)
//                self?.removeFollowerData?.cancel()
//
//            })
//    }
//
//}
