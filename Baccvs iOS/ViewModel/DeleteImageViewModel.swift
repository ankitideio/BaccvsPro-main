//
//  DeleteImageViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 08/05/2023.
//

import Foundation
import Combine
class DeleteImageViewModel : ObservableObject {
    @Published var deleteImageModel = DeleteImageModel()
    @Published var getDeleteImageModel = GetDeleteImageModel()
    private var deleteImageData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var queryItems : [URLQueryItem] = []

    
    func deleteImage(){
        showProgress = true
        
        let dictData = deleteImageModel.dict
     var urlComponents = URLComponents(string: deleteImageURL)!
            dictData?.forEach({ dic in
                queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
            })
            urlComponents.queryItems = queryItems
            let url = urlComponents.url!
        
        deleteImageData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "DELETE", url: url,dataThing: nil, boundary: nil))
            .decode(type:GetDeleteImageModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getDeleteImageModel = returnedProduct
                if self?.getDeleteImageModel.Status ?? false {
                    self?.showProgress = false
                   
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getDeleteImageModel as Any)
                self?.deleteImageData?.cancel()

            })
    }
    
}
