//
//  GroupsLikeYouViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 16/03/2023.
//

import Foundation
import Combine
class GroupsLikeYouViewModel : ObservableObject {
    @Published var getGroupslikeYou : GetGroupLlikeYouModel  = GetGroupLlikeYouModel()
    private var groupLikeYouData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    
    init(){
        groupsLikeYou ()
    }
    
    func groupsLikeYou(){
        showProgress = true
        let url = URL(string:  groupsLikesYouDev)!
        groupLikeYouData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetGroupLlikeYouModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getGroupslikeYou = returnedProduct
                if self?.getGroupslikeYou.status ?? false {
                    self?.showProgress = false
                }else{
                    self?.showProgress = false
                }
                print(self?.getGroupslikeYou)
                self?.groupLikeYouData?.cancel()
            })
    }
}
