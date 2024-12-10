//
//  CreateEventViewModel.swift
//  Baccvs iOS
//  Created by pm on 18/02/2023.
import Foundation
import SwiftUI
import Combine
import Photos
import PhotosUI
import AVKit
class CreateEventViewModel : ObservableObject {
    @Published var createEventModel = CreateEventModel()
    @Published var getCreateEventModel = GetCreateEventModel()
    @Published var isAddLocation = false
    @Published var show = false
    @Published var selected : [PhotosPickerItem] = []
    @Published var isCreateEvent = false
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var selections : [String] = []
    private var createEventData: AnyCancellable?
      func createEvent(){
          if createEventModel.is_before == true ||  createEventModel.is_party == true || createEventModel.is_after == true{
              
              if createEventModel.event_name != "" && createEventModel.mobile_number != "" &&  createEventModel.people_allowed != ""  &&  createEventModel.party_discripation != "" && !createEventModel.add_friend.isEmpty{
                  isCreateEvent = false
                  showProgress = true
                  let dictData = createEventModel.dict
                  let url = URL(string: createEventDev)!
                  let boundary = "------------------------------\(UUID().uuidString)"
                  let data = NetworkLayer.createFormData(dic: dictData ?? [:], videos: createEventModel.part_vedio_url, thumbNial: createEventModel.thum_nail , boundary: boundary)
                  print(String (data: data, encoding: .utf8) ?? "")
                createEventData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .formData, contentType: "POST", url: url,dataThing: data, boundary: boundary))
                      .decode(type: GetCreateEventModel.self, decoder: JSONDecoder())
                      .sink(receiveCompletion: { [weak self] completion in
                          switch completion {
                          case .failure(let error):
                              self?.errorMessage = error.localizedDescription
                              self?.showProgress = false
                          case .finished:
                              break
                          }
                      }, receiveValue: { [weak self] (returnedProduct) in
                          self?.getCreateEventModel = returnedProduct
                          if self?.getCreateEventModel.status ?? false {
                              self?.isCreateEvent = true
                              self?.showProgress = false
                              self?.message = self?.getCreateEventModel.message ?? "Group Created successfully"
                              self?.alertType = .success
                              self?.showAlert = true
                          }else{
                              self?.isCreateEvent = false
                              self?.showProgress = false
                              self?.message = self?.getCreateEventModel.message ?? "Not Found"
                              self?.alertType = .error
                              self?.showAlert = true
                          }
                          print(self?.getCreateEventModel as Any)
                          self?.createEventData?.cancel()
                      })
              }
              
          }
    }
    
}
