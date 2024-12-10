//
//  EventDetailsViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 29/03/2023.
//

import Foundation
import Combine
class EventDetailsViewModel : ObservableObject {
    @Published var eventIdModel = EventIdModel()
    @Published var getEventIdModel = GetEventByIdModel()
    private var eventDetailData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var queryItems : [URLQueryItem] = []
    @Published  var labelText = "Initial Text"
    @Published  var counter = 0

    func eventDetails(){
        
        apiCall()
    }
    func apiCall(){
        
        showProgress = true
        let dictData = eventIdModel.dict
        labelText = "\(eventIdModel.event_id)"
     var urlComponents = URLComponents(string: getEventById)!
            dictData?.forEach({ dic in
                queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
            })
            urlComponents.queryItems = queryItems
            let url = urlComponents.url!
//        labelText = "\(url)"
        eventDetailData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetEventByIdModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getEventIdModel = returnedProduct
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    self?.counter += 1
                    self?.labelText = "Counter: \(self?.counter)"
                }
                self?.eventIdModel.event_id = "done"
                if self?.getEventIdModel.status ?? false {
                    self?.showProgress = false
                }else{
                    self?.showProgress = false
                }
                print(self?.getEventIdModel)
                self?.eventDetailData?.cancel()
            })
    }
}
