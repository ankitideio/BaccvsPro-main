//
//  SignupViewMode.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 11/02/2023.
//

import Foundation
import Combine
//
//class SignupViewMode : ObservableObject{
////    @Published var date = Date.now
//    @Published var fName: String = ""
//    let dateFormatter: DateFormatter = {
//              let formatter = DateFormatter()
//              formatter.dateStyle = .long
//              return formatter
//    }()
//    @Published var genderSelected = "Male"
//    @Published var birthDate = Date.now
//    @Published var email: String = ""
//    @Published var fulName: String = ""
//    @Published var socialName: String = ""
//    @Published var password: String = ""
//    @Published var cpassword: String = ""
//    @Published var isComplete = false
//    @Published var isContinue = false
//}
class TestViewModel : ObservableObject{
    @Published  var  createEvent = CreateEventModel()
    @Published  var  getEvent = GetEventModel()
    @Published var   getAllEvents:[GetAllEventsModel] = []
    @Published var queryItems : [URLQueryItem] = []
    private var getEventData: AnyCancellable?
    
    init(){
        eventGet()
    }
    func eventGet(){
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
