//
//  UdateGroupVeiwModel.swift
//  Baccvs iOS
//
//  Created by pm on 03/05/2023.
//

import Foundation
import  Combine
class UdpateGroupVeiwModel : ObservableObject {
    @Published var updateGroupModel = UpdateGroupModel()
    @Published var getUpdateGroupModel = GetGroupUpdateModel()
    private var updateGroupData : Cancellable?
    @Published var  isUpdate = false
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var queryItems : [URLQueryItem] = []

    
    func updateGroup(){
        showProgress = true
        isUpdate = false
        let dictData = updateGroupModel.dict
        let updataProfileInform  = URL(string: updateGroupDev)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        updateGroupData = NetworkLayer.download(url: updataProfileInform, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "PUT", url: updataProfileInform,dataThing: jsonData, boundary: nil))
            .decode(type:GetGroupUpdateModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getUpdateGroupModel = returnedProduct
                if self?.getUpdateGroupModel.status ?? false {
                    self?.isUpdate = true
                    self?.showProgress = false
                    self?.message = "Successfully Updated"
                    self?.alertType = .success
                    self?.showAlert = true

                }else{
                    self?.isUpdate = false
                    self?.showProgress = false
                    self?.message = "Not Found"
                    self?.alertType = .error

                }
                print(self?.getUpdateGroupModel as Any)
                self?.updateGroupData?.cancel()

            })
    }
}
