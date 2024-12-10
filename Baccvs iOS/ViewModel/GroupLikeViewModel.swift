//
//  GroupLikeViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 02/03/2023.
//

import Foundation
import Combine
class  GroupLikeViewModel : ObservableObject {
      @Published var groupLikeModel : [GetGroupLikeModel] = []
       private var youLikeGroupData : Cancellable?
    func createReferral(){
        let dictData = groupLikeModel.dict
        let blockUserURL  = URL(string: groupsLikesDev)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        youLikeGroupData = NetworkLayer.download(url: blockUserURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: blockUserURL,dataThing: jsonData, boundary: nil))
            .decode(type:[GetGroupLikeModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkLayer.handleCompletion, receiveValue: { [weak self] (returnedProduct) in
                self?.groupLikeModel = returnedProduct
                print(self?.groupLikeModel as Any)
                self?.youLikeGroupData?.cancel()

            })
    }
}

struct GroupsLikes: Codable{
    var group_id: String = String()
    var dir : Bool = Bool()
}

