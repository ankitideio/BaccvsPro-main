//
//  InvitationRefuseViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 11/03/2023.
//

import Foundation
import Combine
class InvitationRefuseViewModel : ObservableObject {
    @Published var  getInvitationRefuseModel = GetInvitationRefuseModel()
    @Published var  invitationRefuse = InvitationRefuseModel()
    @Published var queryItems : [URLQueryItem] = []
   private var inviteRefuseData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    
    func eventRefuse(){
        let dictData = invitationRefuse.dict
     var urlComponents = URLComponents(string: eventRefuseDev)!
            dictData?.forEach({ dic in
                queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
            })
            urlComponents.queryItems = queryItems
            let url = urlComponents.url!
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        inviteRefuseData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: url,dataThing: jsonData, boundary: nil))
            .decode(type:GetInvitationRefuseModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getInvitationRefuseModel = returnedProduct
                print(self?.getInvitationRefuseModel as Any)
                self?.inviteRefuseData?.cancel()

            })
    }

}
