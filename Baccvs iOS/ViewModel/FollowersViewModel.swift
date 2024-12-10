//
//  FollowersViewModel.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 22/07/2023.
//

import Foundation
import Combine
class FollowersViewModel : ObservableObject{
    @Published var followerUserModel :  GetFollowerUserModel = GetFollowerUserModel()
    @Published var getFollowerArr : [User] = []
    @Published var removeFollwerModel = RemoveFollowerModel()
    @Published var getRemoveFollwerModel =  GetRemoveFollowerModel()
    @Published var unfollowModel   = UnFollowModel()
    @Published var getUnfollowModel = GetUnfollowModel()
    @Published var followingModel = FollowingModel()
    @Published var getFollowingModel = GetFollowingModel()
    @Published var allUsers :  GetAllUsersModels = GetAllUsersModels()
    @Published var queryItems : [URLQueryItem] = []
    @Published var showProgress = false
    @Published var errorMessage = ""
    private var removeFollowerData : Cancellable?
    private var FollowerUserData : Cancellable?
    private var unfollowData : Cancellable?
    private var followingData : Cancellable?
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var searchBar = ""
    @Published var selection = 0
    var searchAbleUsersList : [User] {
        if !searchBar.isEmpty{
            let lowerCaseSearch = searchBar.lowercased()
                return followerUserModel.body.filter({$0.userName.lowercased().contains(lowerCaseSearch)})
        }else {
            return followerUserModel.body
        }
        
    }
    init(){
        follower()
    }
    func follower(){
        showProgress = true
        let url = URL(string: followerUserDev)!
        FollowerUserData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type:GetFollowerUserModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion:{ [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.followerUserModel = returnedProduct
                
                if self?.followerUserModel.status ?? false {
                    self?.showProgress = false
                    
                }else{
                    self?.showProgress = false
                    self?.message = "Not Found"
                    self?.alertType = .error
                    self?.showAlert = true
                }
                print(self?.followerUserModel)
                self?.FollowerUserData?.cancel()
            })
    }
    func followingUser(){
        showProgress = true
        let dictData = followingModel.dict
        let creatrReferralURL  = URL(string: followingDev)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        followingData = NetworkLayer.download(url: creatrReferralURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: creatrReferralURL,dataThing: jsonData, boundary: nil))
            .decode(type:GetFollowingModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getFollowingModel = returnedProduct
                if self?.getFollowingModel.status ?? false {
                    self?.showProgress = false
                   
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getFollowingModel as Any)
                self?.followingData?.cancel()

            })
    }
    func removeFollwer(){
        let dictData = removeFollwerModel.dict
        var urlComponents = URLComponents(string: removeFollowerDev)!
        dictData?.forEach({ dic in
            queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
        })
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        removeFollowerData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: url,dataThing: jsonData, boundary: nil))
            .decode(type:GetRemoveFollowerModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getRemoveFollwerModel = returnedProduct
                print(self?.getRemoveFollwerModel as Any)
                self?.removeFollowerData?.cancel()
                
            })
    }
}
