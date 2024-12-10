//
//  PersonEventViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 13/04/2023.

import Foundation
import Combine
class PersonEventViewModel : ObservableObject {
    @Published var personEventModel = UserEventModel()
    @Published var getPersonEventModel = GetAllUserEvents()
    private var personEventData : Cancellable?
    @Published var queryItems : [URLQueryItem] = []
    @Published var showProgress = false
    @Published var errorMessage = ""
    
    func userEventDetail(){
        showProgress = true
        let dictData = personEventModel.dict
     var urlComponents = URLComponents(string: personEventURL)!
            dictData?.forEach({ dic in
                queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
            })
            urlComponents.queryItems = queryItems
            let url = urlComponents.url!
        personEventData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetAllUserEvents.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getPersonEventModel = returnedProduct
                if self?.getPersonEventModel.status ?? false {
                    self?.showProgress = false
                }else{
                    self?.showProgress = false
                }
                print(self?.getPersonEventModel)
                self?.personEventData?.cancel()
            })
      }
 }
