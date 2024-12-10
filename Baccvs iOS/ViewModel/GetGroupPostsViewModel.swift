//
//  GetGroupPostsViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 03/05/2023.
//

import Foundation
import Combine
import AVFoundation
class GetGroupPostsViewModel : ObservableObject {
//    @Published var getGroupPostsModel = GetGroupPostsModel()
    @Published var groupPostsModel = GroupPostsModel()
    @Published var getGroupPostsgModel :  GetCreatePostgModel =  GetCreatePostgModel()
    @Published var allVideos : [DynamicPlayer] = []
    private var groupPostsData : Cancellable?
    @Published var queryItems : [URLQueryItem] = []
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var showAlert = false

    func groupPostDetails(){
        showProgress = true
        let dictData = groupPostsModel.dict
     var urlComponents = URLComponents(string: getGroupPostsDev)!
            dictData?.forEach({ dic in
                queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
            })
            urlComponents.queryItems = queryItems
            let url = urlComponents.url!
        groupPostsData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetCreatePostgModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getGroupPostsgModel = returnedProduct
                if self?.getGroupPostsgModel.status ?? false {
                    self?.allVideos = self?.getGroupPostsgModel.body.map({ post in
                        DynamicPlayer(id: post.postID, player: AVPlayer(url: URL(string: post.video) ?? URL(string: "")!))
                    }) ?? []
                    self?.showProgress = false
                   
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getGroupPostsgModel as Any)
                self?.groupPostsData?.cancel()

            })
//            .sink(receiveCompletion: { [weak self] completion in
//                switch completion {
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                    self?.showProgress = false
//                case .finished:
//                    break
//                }
//            },receiveValue: { [weak self] (returnedProduct) in
//                self?.getGroupPostsgModel = returnedProduct
//                self?.groupPostsData?.cancel()
//            })
      }
    
}
