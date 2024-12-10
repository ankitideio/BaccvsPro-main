//
//  EventGetViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 18/02/2023.
//

import Foundation
import SwiftUI
import Combine
class EventGetViewModel : ObservableObject {
    @Published  var  createEvent = CreateEventModel()
    @Published  var  getEvent = GetEventModel()
    @Published var  getAllEvents : [GetAllEventsModel] = []
    @Published var queryItems : [URLQueryItem] = []
    private var getEventData: AnyCancellable?
    
    init(){
        allEvents()
    }
    func allEvents(){
      let url = URL(string: getAllEventsDev)!
        getEventData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: [GetAllEventsModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkLayer.handleCompletion, receiveValue: { [weak self] (returnedProduct) in
                self?.getAllEvents = returnedProduct
                print(self?.getAllEvents)
                self?.getEventData?.cancel()
            })
    }
}
