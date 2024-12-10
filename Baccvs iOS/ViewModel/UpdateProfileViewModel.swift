//
//  UpdateProfileViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 25/02/2023.
//

import Foundation
import SwiftUI
import Photos
import PhotosUI
import Combine
import SDWebImage
class  UpdateProfileViewModel: ObservableObject{
    @Published var updateProfileModel = ProfileUpdateModel()
    @Published var getupdateProfileModel = GetProfileImageModel()
    @Published var showPicker = false
    @Published var croppedImage: UIImage?
    @Published var isComp = false
    @Published var showProgress = false
    @Published var errorMessage = ""
    private var updateProfleData: AnyCancellable?
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
      func updateProfile(){
         
              let url = URL(string: profileIimageDev)!
              let boundary = "------------------------------\(UUID().uuidString)"
          let data = NetworkLayer.putProfileImage(dic: updateProfileModel.file, boundary: boundary)
              updateProfleData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .formData, contentType: "POST", url: url,dataThing: data, boundary: boundary))
                  .decode(type: GetProfileImageModel.self, decoder: JSONDecoder())
                  .sink(receiveCompletion:  { [weak self] completion in
                      switch completion {
                      case .failure(let error):
                          self?.errorMessage = error.localizedDescription
                          self?.showProgress = false
                      case .finished:
                          break
                      }
                  }, receiveValue: { [weak self] (returnedProduct) in
                      self?.getupdateProfileModel = returnedProduct
                      if self?.getupdateProfileModel.status ?? false {
                          self?.isComp = true
                            SDImageCache.shared.clearMemory()
                            SDImageCache.shared.clearDisk()
                          self?.showProgress = false
                          self?.message = "Profile Image Upload successfully"
                          self?.alertType = .success
                          self?.showAlert = true
                      }else{
                          self?.isComp = false
                          self?.showProgress = false
                          self?.message = "Not Found"
                          self?.alertType = .error
                          self?.showAlert = true
                      }
                      print(self?.getupdateProfileModel as Any)
//                      self?.isComp.toggle()
                      self?.updateProfleData?.cancel()
                  })
              
          
          }
    }
    



