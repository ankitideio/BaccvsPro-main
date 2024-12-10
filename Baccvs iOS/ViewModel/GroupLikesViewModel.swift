//
//  GroupLikesViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 02/03/2023.
//

import Foundation
import SwiftUI
import Combine
class GroupLikesViewModel : ObservableObject {
    @Published var getgroupLikeModel : GetGroupLikeModel =  GetGroupLikeModel()
    @Published var groupLikesList  : [GetAllGroupsModel] = []
    private var groupLikeData :   Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var queryItems : [URLQueryItem] = []
    
    init(){
        userlistWhoLike()
    }
    
    func userlistWhoLike(){
        showProgress = true
        let dictData = getgroupLikeModel.dict
     var urlComponents = URLComponents(string: userlistOfLikesDev)!
            dictData?.forEach({ dic in
                queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
            })
            urlComponents.queryItems = queryItems
            let url = urlComponents.url!
        groupLikeData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetGroupLikeModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getgroupLikeModel = returnedProduct
                if self?.getgroupLikeModel.status ?? false {
                    self?.showProgress = false
                }else{
                    self?.showProgress = false
                }

                print(self?.getgroupLikeModel)
                self?.groupLikeData?.cancel()
            })
    }


    
    
}
