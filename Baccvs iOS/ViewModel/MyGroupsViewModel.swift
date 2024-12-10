//
//  MyGroupsViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 27/02/2023.
//

import Foundation
import Combine
class MyGroupsViewModel : ObservableObject {
    @Published  var createGroupModel = CreateGroupModel()
    @Published var getCreateModel = GetCreateGruopModel()
    @Published var allGroupList : GetAllGroupsModel = GetAllGroupsModel()
//    @Published var liedIds : [String] = []
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var groupLikeModel = GroupLikeModel()
    @Published var resgroupLikeModel = ResGroupLikeModel()
    private var groupLikeData : Cancellable?
    private var createGroupdata: AnyCancellable?
    private var allGroupData: AnyCancellable?
    @Published var allLikes: [String] = []

    
  init(){
      getAllGroup()
  }
  
    func getAllGroup(){
      showProgress = true
      let url = URL(string: allGroupDev)!
      allGroupData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
          .decode(type: GetAllGroupsModel.self, decoder: JSONDecoder())
          .sink(receiveCompletion: { [weak self] completion in
              switch completion {
              case .failure(let error):
                  self?.errorMessage = error.localizedDescription
                  self?.showProgress = false
              case .finished:
                  break
              }
          }, receiveValue: { [weak self] (returnedProduct) in
              self?.allGroupList = returnedProduct
              self?.allLikes = []
              if self?.allGroupList.status ?? false {
                  _ = self?.allGroupList.body.filter({$0.likeGroup == true}).map({ ptID in
                      self?.allLikes.append(ptID.id)
                  })
                  self?.showProgress = false
                  
              }else{
                  self?.showProgress = false
                  self?.message = "Not Found"
                  self?.alertType = .error
                  self?.showAlert = true
              }
              print(self?.allGroupList)
              self?.allGroupData?.cancel()
          })
  }
  
    func groupLike(){
        let dictData = groupLikeModel.dict
        let blockUserURL  = URL(string: groupLikeURL)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        groupLikeData = NetworkLayer.download(url: blockUserURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: blockUserURL,dataThing: jsonData, boundary: nil))
            .decode(type:ResGroupLikeModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion:  { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.resgroupLikeModel = returnedProduct
                if self?.resgroupLikeModel.status ?? false {
                  
                    self?.showProgress = false
                    
                }else{
                    self?.showProgress = false
                }
                print(self?.resgroupLikeModel as Any)
                self?.groupLikeData?.cancel()
                })
    }
    
}
