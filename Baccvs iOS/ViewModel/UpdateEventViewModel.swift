//
//  UpdateEventViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 27/04/2023.
//

import Foundation
import Combine
import SDWebImage
class UpdateEventViewModel : ObservableObject {
    @Published var updateEventModel = UpdateEventModel()
    @Published var getUpdateEventModel = GetUpdateEventModel()
    @Published var deleteVideoEventModel = DeleteEventVideoModel()
    @Published var deleteEventUserModel = DeleteEventUserModel()
    @Published var updateEventThumbNilModel = UpdateEventThumbNilModel()
    @Published var addEventVideoModel = AddEventVideoModel()
    @Published var addEventUserModel = AddEventUserModel()
    @Published var selectedPricing = ""
    @Published var isUpdateText = false
    @Published var isUpdateThumbnil = false
    @Published var isUpdateVideo = false
    @Published var isUpdateUser = false
    @Published var queryItems : [URLQueryItem] = []
    private var updateEventData : Cancellable?
    private var getUpdateEventModelCan : Cancellable?
    private var deleteVideoEventModelCan : Cancellable?
    private var deleteEventUserModelCan : Cancellable?
    private var updateEventThumbNilModelCan : Cancellable?
    private var addEventVideoModelCan : Cancellable?
    private var addEventUserModelCan : Cancellable?
//    @Published var showProgress = false
//    @Published var errorMessage = ""
//    @Published var alertType : MyAlerts? = nil
//    @Published var showAlert = false
//    @Published var message : String = ""
    
    @Published var  isUpdate = false
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""

    
    func updateEvent(){
        isUpdate = false
        showProgress = true
        let dictData = updateEventModel.dict
        let updataEventUrl  = URL(string: updateEventDev)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        updateEventData = NetworkLayer.download(url: updataEventUrl, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "PUT", url: updataEventUrl,dataThing: jsonData, boundary: nil))
            .decode(type:GetUpdateEventModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
               case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getUpdateEventModel = returnedProduct
                if self?.getUpdateEventModel.status ?? false {
                    self?.isUpdateText = true
                    
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
                    self?.showAlert = true
                }
                print(self?.getUpdateEventModel as Any)
                self?.updateEventData?.cancel()

            })
    }
    func updateThumbnil(){
        let url = URL(string: "\(updateThumnailEventUrl)?event_id=\(updateEventThumbNilModel.event_id)")!
        let boundary = "------------------------------\(UUID().uuidString)"
        let data = NetworkLayer.putThumbNilImage(dic: updateEventThumbNilModel.thum_nail, boundary: boundary)
        updateEventThumbNilModelCan = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .formData, contentType: "PUT", url: url,dataThing: data, boundary: boundary))
            .decode(type:GetUpdateEventModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getUpdateEventModel = returnedProduct
                if self?.getUpdateEventModel.status ?? false {
                    SDImageCache.shared.clearMemory()
                    SDImageCache.shared.clearDisk()
                    self?.isUpdateThumbnil = true
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getUpdateEventModel as Any)
                self?.updateEventThumbNilModelCan?.cancel()

            })
    }
    func addNewUserEvent(){
        let url = URL(string: updateUserEvent)!
        let dataThing = "event_id=\(addEventUserModel.event_id)&friend_list=\(addEventUserModel.friend_list)".data(using: .utf8)
        updateEventData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .xFormData, contentType: "POST", url: url, dataThing: dataThing!, boundary: nil))
            .decode(type:GetUpdateEventModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getUpdateEventModel = returnedProduct
                if self?.getUpdateEventModel.status ?? false {
                    self?.isUpdateThumbnil = true
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getUpdateEventModel as Any)
                self?.updateEventData?.cancel()

            })
    }
    func updateVideo(){
        let url = URL(string: "\(addNewVideoEventUrl)?event_id=\(addEventVideoModel.event_id)")!
        let boundary = "------------------------------\(UUID().uuidString)"
        let data = NetworkLayer.addVideoEventFormData(img: addEventVideoModel.video, boundary: boundary)
        addEventVideoModelCan = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .formData, contentType: "POST", url: url,dataThing: data, boundary: boundary))
            .decode(type:GetUpdateEventModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getUpdateEventModel = returnedProduct
                if self?.getUpdateEventModel.status ?? false {
                    self?.isUpdateVideo = true
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getUpdateEventModel as Any)
                self?.addEventVideoModelCan?.cancel()

            })
    }
    func updateUser(){
        showProgress = true
        let dictData = updateEventModel.dict
        let updataEventUrl  = URL(string: updateEventDev)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        addEventUserModelCan = NetworkLayer.download(url: updataEventUrl, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "PUT", url: updataEventUrl,dataThing: jsonData, boundary: nil))
            .decode(type:GetUpdateEventModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getUpdateEventModel = returnedProduct
                if self?.getUpdateEventModel.status ?? false {
                    self?.isUpdateText = true
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getUpdateEventModel as Any)
                self?.addEventUserModelCan?.cancel()

            })
    }
    func deleteEventVideo(completion: @escaping(Bool) -> Void){
        let dictData = deleteVideoEventModel.dict
        var urlComponents = URLComponents(string: deleteEventVideoURL)!
        queryItems = []
        dictData?.forEach({ dic in
            queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
        })
        urlComponents.queryItems = queryItems
        let updataEventUrl = urlComponents.url!
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        deleteVideoEventModelCan = NetworkLayer.download(url: updataEventUrl, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "DELETE", url: updataEventUrl,dataThing: jsonData, boundary: nil))
            .decode(type:GetUpdateEventModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getUpdateEventModel = returnedProduct
                if self?.getUpdateEventModel.status ?? false {
                    self?.showProgress = false
                   completion(true)
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getUpdateEventModel as Any)
                self?.deleteVideoEventModelCan?.cancel()

            })
    }
    func deleteEventUser(){
        let dictData = deleteEventUserModel.dict
        var urlComponents = URLComponents(string: deleteEventUserUrl)!
        queryItems = []
        dictData?.forEach({ dic in
            queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
        })
        urlComponents.queryItems = queryItems
        let updataEventUrl = urlComponents.url!
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        deleteEventUserModelCan = NetworkLayer.download(url: updataEventUrl, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "DELETE", url: updataEventUrl,dataThing: jsonData, boundary: nil))
            .decode(type:GetUpdateEventModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getUpdateEventModel = returnedProduct
                if self?.getUpdateEventModel.status ?? false {
                    self?.showProgress = false
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getUpdateEventModel as Any)
                self?.deleteEventUserModelCan?.cancel()

            })
    }
}
