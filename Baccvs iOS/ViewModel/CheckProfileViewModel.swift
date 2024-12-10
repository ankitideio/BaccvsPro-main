//
//  CheckProfileViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 02/03/2023.
//

import Foundation
import Combine
import SwiftUI
class  CheckProfileViewModel : ObservableObject {
    @Published var checkprofileModel : GetCheckProfileModel = GetCheckProfileModel()
    @Published var uploadStroryModel : UploadStroryModel = UploadStroryModel()
    @Published var postStoryImagesModel : PostStoryImagesModel = PostStoryImagesModel()
    @Published var isPublicModelRes : GetUnblockUserModel = GetUnblockUserModel()
    @Published var  showLocation = false
    private var checkProfiledata: AnyCancellable?
    private var storyImagesCalcellable: AnyCancellable?
    private var isPublicCalcellable: AnyCancellable?
    private var isPrivateCalcellable: AnyCancellable?
    @Published var selected : [SelectedImages] = []
    @Published var show = false
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @AppStorage ("userName") var userName : String = String()
    @AppStorage ("userImage") var userImage : String = String()
    @Published var imagesArray : [String] = []
    @Published  var zodic = ["Capricorn", "Aquarius","Pisces","Aries","Taurus","Gemini","Cancer","Leo","Virgo","Libra","Scorpio","Sagittarius"]
    @Published  var selectedzodic: String = ""
    
    @Published  var drinking = ["Sometimes","No","Prefer not to say"]
    @Published  var selecteddrink: String = ""
    
    @Published  var smoking = ["SomeTimes","No","Prefer not to say"]
    @Published  var selectedsmoking: String = ""

    init (){
        getCheckProfile()
    }
    
    func getCheckProfile(){
        showProgress = true
        let url = URL(string: checkProfileDev)!
        checkProfiledata = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetCheckProfileModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.checkprofileModel = returnedProduct
                
                if self?.checkprofileModel.status ?? false {
                    self?.showProgress = false
                    self?.selectedzodic = self?.checkprofileModel.body.zodaic ?? ""
                    self?.selecteddrink = self?.checkprofileModel.body.drinking ?? ""
                    self?.selectedsmoking = self?.checkprofileModel.body.smoking ?? ""


                    self?.userImage = self?.checkprofileModel.body.profileImageURL ?? ""
                    self?.userName = self?.checkprofileModel.body.name ?? ""
                }else{
                    self?.showProgress = false
                    self?.message = "Not Found"
                    self?.alertType = .error
                    self?.showAlert = true
                }
                print(self?.checkprofileModel as Any)
                self?.checkProfiledata?.cancel()
            })
    }
    func uploadStoryImages(completion: @escaping(Bool) -> Void){
        showProgress = true
        let url = URL(string: addUserStoryURL)!
        let boundary = "------------------------------\(UUID().uuidString)"
        let data = NetworkLayer.createStoryFormData(img: postStoryImagesModel.storys, boundary: boundary)
        storyImagesCalcellable = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .formData, contentType: "POST", url: url,dataThing: data, boundary: boundary))
            .decode(type: UploadStroryModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.uploadStroryModel = returnedProduct
                
                if self?.uploadStroryModel.status ?? false {
                    self?.showProgress = false
                    self?.uploadStroryModel.body.forEach{img in
                        
                        self?.checkprofileModel.body.storyImage.append(StoryImage(id: UUID().uuidString, image: img))
                    }
                    completion(true)
                }else{
                    self?.showProgress = false
                    self?.message = "Not Found"
                    self?.alertType = .error
                    self?.showAlert = true
                }
                print(self?.uploadStroryModel as Any)
                self?.storyImagesCalcellable?.cancel()
            })
    }
    func turnProfileToPublic(){
        showProgress = true
        let url = URL(string: isPublicURL)!
        checkProfiledata = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetUnblockUserModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.isPublicModelRes = returnedProduct
                
                if self?.isPublicModelRes.status ?? false {
                    self?.showProgress = false
                    self?.getCheckProfile()
                }else{
                    self?.showProgress = false
                    self?.message = "Not Found"
                    self?.alertType = .error
                    self?.showAlert = true
                }
                print(self?.isPublicModelRes as Any)
                self?.isPublicCalcellable?.cancel()
            })
    }
    func turnProfileToPivate(){
        showProgress = true
        let url = URL(string: isPrivateURL)!
        isPrivateCalcellable = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetUnblockUserModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.isPublicModelRes = returnedProduct
                
                if self?.isPublicModelRes.status ?? false {
                    self?.getCheckProfile()
                    self?.showProgress = false
                }else{
                    self?.showProgress = false
                    self?.message = "Not Found"
                    self?.alertType = .error
                    self?.showAlert = true
                }
                print(self?.isPublicModelRes as Any)
                self?.isPrivateCalcellable?.cancel()
            })
    }
}
