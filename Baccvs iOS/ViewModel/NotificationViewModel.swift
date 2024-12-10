//
//  NotificationViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 29/04/2023.
//

import Foundation
import Combine
class NotificationViewModel : ObservableObject {
    @Published var getNotificationModel : GetNotificationModel = GetNotificationModel()
    private var notificationData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    init(){
        notification()
    }
    func notification(){
        showProgress = true
        let url = URL(string:  notificationDev)!
       notificationData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetNotificationModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getNotificationModel = returnedProduct
                if self?.getNotificationModel.status ?? false {
                    self?.showProgress = false
                }else{
                    self?.showProgress = false
                }
                print(self?.getNotificationModel)
                self?.notificationData?.cancel()
            })
    }
    

}
