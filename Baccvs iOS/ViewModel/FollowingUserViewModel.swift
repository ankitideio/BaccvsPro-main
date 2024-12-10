//
//  FollowingUserViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 03/03/2023.
//

import Foundation
import Combine
class FollowingUserViewModel : ObservableObject {
    @Published var followingUserModel : GetFollowingUserModel = GetFollowingUserModel()
    private var FollowingUserData : Cancellable?
    private var unfollowData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var searchBar = ""
    @Published var queryItems : [URLQueryItem] = []
    @Published var unfollowModel   = UnFollowModel()
    @Published var getUnfollowModel = GetUnfollowModel()
    var searchAbleUsersList : [User] {
        if !searchBar.isEmpty{
            let lowerCaseSearch = searchBar.lowercased()
                return followingUserModel .body.filter({$0.userName.lowercased().contains(lowerCaseSearch)})
        }else {
            return followingUserModel.body
        }
        
    }
    init(){
        following()
    }
    func unFollow(){
        showProgress = true
        let dictData = unfollowModel.dict
        var urlComponents = URLComponents(string: unfollowDev)!
        dictData?.forEach({ dic in
            queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
        })
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        unfollowData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "DELETE", url: url,dataThing: jsonData, boundary: nil))
            .decode(type:GetUnfollowModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getUnfollowModel = returnedProduct
                if self?.getUnfollowModel.status ?? false {
                    self?.showProgress = false
                    
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getUnfollowModel as Any)
                self?.unfollowData?.cancel()
                
            })
    }
    func following(){
        showProgress = true
        let url = URL(string: followingUserDev)!
        FollowingUserData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetFollowingUserModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion:{ [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.followingUserModel = returnedProduct
                
                if !(self?.followingUserModel.body.isEmpty ?? false){
                    self?.showProgress = false
                    
                }else{
                    self?.showProgress = false
                    self?.message = "Not Found"
                    self?.alertType = .error
                    self?.showAlert = true
                }
                print(self?.followingUserModel as Any)
                self?.FollowingUserData?.cancel()
            })
        
    }

}
