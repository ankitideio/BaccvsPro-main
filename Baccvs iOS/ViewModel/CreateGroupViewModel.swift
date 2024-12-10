//
//  CreateGroupViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 27/02/2023.
//

import Foundation
import Combine
class  CreateGroupViewModel : ObservableObject {
    @Published  var createGroupModel = CreateGroupModel()
    @Published var getCreateModel = GetCreateGruopModel()
    private var createGroupData : AnyCancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    func createGroup(){
        showProgress = true

        let dataThing = "group_description=\(createGroupModel.group_description)&group_name=\(createGroupModel.group_name)&add_friend=\(createGroupModel.add_friend)".data(using: .utf8)
     let url = URL(string: createGroupDev)!
        createGroupData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .xFormData, contentType: "POST", url: url, dataThing: dataThing, boundary: nil))
                .decode(type: GetCreateGruopModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion:  { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                        self?.showProgress = false
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] (returnedProduct) in
                    self?.getCreateModel = returnedProduct
                    if self?.getCreateModel.status ?? false {
                        self?.showProgress = false
                        self?.message = "Group Created successfully"
                        self?.alertType = .success
                        self?.showAlert = true
                    }else{
                        self?.showProgress = false
                        self?.message = self?.getCreateModel.message ?? "Not Found"
                        self?.alertType = .error
                        self?.showAlert = true
                    }
                    print(self?.getCreateModel as Any)
                    self?.createGroupData?.cancel()
                })
    }
   
}
