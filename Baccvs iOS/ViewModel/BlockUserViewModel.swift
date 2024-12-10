//
//  BlockUserViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 04/03/2023.
//

import Foundation
import Combine
  class  BlockUserViewModel : ObservableObject {
    @Published var blockUserModel = BlockedUserModel()
    @Published var getBlockUserModel = GetBlockUserAccountModel()
    @Published var queryItems : [URLQueryItem] = []
    private var blockData : AnyCancellable?
      @Published var showProgress = false
      @Published var errorMessage = ""
    
    func blockUser(completion: @escaping(Bool) -> Void){
        let dictData = blockUserModel.dict
        let blockUserURL  = URL(string: blockUserDev)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        blockData = NetworkLayer.download(url: blockUserURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: blockUserURL,dataThing: jsonData, boundary: nil))
            .decode(type:GetBlockUserAccountModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion:  { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getBlockUserModel = returnedProduct
                if self?.getBlockUserModel.status ?? false {
                    self?.showProgress = false
                    completion(true)
                }else{
                    self?.showProgress = false
                }
                print(self?.getBlockUserModel as Any)
                self?.blockData?.cancel()
                })
    }
   
}
