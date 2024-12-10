//
//  UpdateUserGroupViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 20/05/2023.
//

import Foundation
import Combine
class UpdateUserGroupViewModel : ObservableObject {
    @Published var updateUserGroupModel = UpdateUserGroupModell()
    @Published var getUpdateUserGroupModel  = GetUpdateUserGroupModel()
    private var updateUserGroupData : Cancellable?
    @Published var showProgress = false
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var errorMessage = ""
    
    func UpdateUserGroup(){
        
        showProgress = true
        let dataThing = "group_id=\(updateUserGroupModel.group_id)&friend_list=\(updateUserGroupModel.friend_list)".data(using: .utf8)
        let url = URL(string: updateGropUserURL)!
        updateUserGroupData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .xFormData, contentType: "POST", url: url, dataThing: dataThing!, boundary: nil))
            .decode(type: GetUpdateUserGroupModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getUpdateUserGroupModel = returnedProduct
                if self?.getUpdateUserGroupModel.status == true{
                    self?.showProgress = false
                    self?.message = "Updated Group Successfuly"
                        self?.alertType = .success
                        self?.showAlert = true
                }else{
                    self?.showProgress = false
                    self?.message = "Not found"
                    self?.alertType = .error
                    self?.showAlert = true
                }
                self?.showProgress = false
                print(self?.getUpdateUserGroupModel as Any)
                self?.updateUserGroupData?.cancel()
            })
        
    }
    
}
