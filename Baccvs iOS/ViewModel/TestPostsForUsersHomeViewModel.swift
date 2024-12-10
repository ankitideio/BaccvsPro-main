//
//  TestPostsForUsersHomeViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 26/10/2023.
//

import Foundation

import Foundation
import Combine
import CoreLocation
class TestPostsForUsersHomeViewModel : ObservableObject {
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var filterModel = FilterModel()
    @Published var selectedIsParam = "Party"
    @Published var selectedTag = FiltersCases()
    @Published var postsForUsersModel : GetPostsForUsersHomeModel = GetPostsForUsersHomeModel()
    private var  postsForUsersData : Cancellable?
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    private var  eventLikeData : Cancellable?
    @Published var allLikes: [String] = []
 
    init(){
        testpostsForUserHome()
    }
    func testpostsForUserHome(){
        showProgress = true
        let url = URL(string:  postsForUsersDev)!
        postsForUsersData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetPostsForUsersHomeModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.postsForUsersModel = returnedProduct
                print(self?.postsForUsersModel as Any)
                self?.postsForUsersData?.cancel()
            })
    }
}

