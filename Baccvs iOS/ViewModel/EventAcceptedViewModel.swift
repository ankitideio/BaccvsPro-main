//
//  EventAcceptedViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 10/03/2023.
//

import Foundation
import Combine
class  EventAcceptedViewModel : ObservableObject {
    @Published var eventAcceptedModel = EventAcceptedModel()
    @Published var getEventAcceptedModel = GetEventAcceptedModel()
    @Published var queryItems : [URLQueryItem] = []
    private var eventAcceptedData : Cancellable?
    
    func eventAccepted(){
        let dictData = eventAcceptedModel.dict
     var urlComponents = URLComponents(string: eventAcceptDev)!
            dictData?.forEach({ dic in
                queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
            })
            urlComponents.queryItems = queryItems
            let url = urlComponents.url!
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        eventAcceptedData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: url,dataThing: jsonData, boundary: nil))
            .decode(type:GetEventAcceptedModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkLayer.handleCompletion, receiveValue: { [weak self] (returnedProduct) in
                self?.getEventAcceptedModel = returnedProduct
//                if self?.getEventAcceptedModel.status ?? false{
//                    
//                }               
                print(self?.getEventAcceptedModel as Any)
                self?.eventAcceptedData?.cancel()

            })
    }
}
