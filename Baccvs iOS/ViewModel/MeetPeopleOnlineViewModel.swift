//
//  MeetPeopleOnlineViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 03/03/2023.
//

import Foundation
import SwiftUI
import Combine
class MeetPeopleOnlineViewModel : ObservableObject {
    @Published var meetPeopleOnlineModel : GetYamatetPeopleModel = GetYamatetPeopleModel()
    private var meetPeopleOnlineData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    
    init(){
        meetPeopleOnline()
    }
    func meetPeopleOnline(){
        showProgress  = true
        let url = URL(string: yamatetaDev)!
        meetPeopleOnlineData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetYamatetPeopleModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.meetPeopleOnlineModel = returnedProduct
                if self?.meetPeopleOnlineModel.status ?? false {
                    self?.showProgress = false
                    
                }else{
                    self?.showProgress = false
                    self?.message = "Not Found"
                    self?.alertType = .error
                    self?.showAlert = true
                }
                print(self?.meetPeopleOnlineModel)
                self?.meetPeopleOnlineData?.cancel()
            })
    }
    
}
