//
//  UpdateProfileInformViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 29/04/2023.
//

import Foundation
import Combine
class UpdateProfileInformViewModel : ObservableObject {
    @Published var updateProfiledetailModel = updateProfileDetailModle()
    @Published var getupdateProfiledetailModel = GetUpdateProfileModel()
    private var updateProfileData : Cancellable?
    @Published var  isUpdate = false
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
   
    func updateProfileInform(){
        showProgress = true
        isUpdate = false
        let dictData = updateProfiledetailModel.dict
        let updataProfileInform  = URL(string: updateProfileDev)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        updateProfileData = NetworkLayer.download(url: updataProfileInform, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "PUT", url: updataProfileInform,dataThing: jsonData, boundary: nil))
            .decode(type:GetUpdateProfileModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getupdateProfiledetailModel = returnedProduct
                if self?.getupdateProfiledetailModel.status ?? false {
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
                print(self?.getupdateProfiledetailModel as Any)
                self?.updateProfileData?.cancel()

            })
    }

}
