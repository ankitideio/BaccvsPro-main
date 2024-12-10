//
//  CreatePostViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 14/04/2023.
//

import Foundation
import Combine
import SwiftUI
class CreatePostViewModel : ObservableObject {
    @Published var createPostModel = CreatePostgModel()
    @Published var getPostModel = GetPostModel()
    private var createPostData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var isGroupPost = false

    func groupPost(){
        showProgress = true
        isGroupPost = false
        let dictData = createPostModel.dict
        let creatrReferralURL  = URL(string: createPostGroup)!
        let boundary = "------------------------------\(UUID().uuidString)"
        let data = NetworkLayer.createPostFormData(dic: dictData ?? [:], videos: createPostModel.video, boundary: boundary)
        
        createPostData = NetworkLayer.download(url: creatrReferralURL, req: NetworkLayer.requestType(apiTypes: .formData, contentType: "POST", url: creatrReferralURL,dataThing: data, boundary: boundary))
            .decode(type:GetPostModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion:  { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getPostModel = returnedProduct
                if self?.getPostModel.Status ?? false {
                    self?.showProgress = false
                    self?.message = "Successfully Uploaded this post"
                    self?.alertType = .success
                    self?.showAlert = true
                    self?.isGroupPost = true
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                    self?.message = "Something Wrong"
                    self?.alertType = .error
                    self?.isGroupPost = false 
                }
                print(self?.getPostModel as Any)
                self?.createPostData?.cancel()

            })
    }
}
