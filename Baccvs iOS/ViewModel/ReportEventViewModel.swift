//
//  ReportEventViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 04/03/2023.
//

import Foundation
import Combine
class ReportEventViewModel : ObservableObject{
    @Published var reportEventModel = ReportEventModel()
    @Published var getreportEventModel =  GetReportEventModel()
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var queryItems : [URLQueryItem] = []
    @Published var message : String = ""
    private var reportEventData : AnyCancellable?
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    
    func reportEvent(){
        let dictData = reportEventModel.dict
        var urlComponents = URLComponents(string: reportEventsDev)!
        dictData?.forEach({ dic in
            queryItems.append(URLQueryItem(name: dic.key, value: "\(dic.value)"))
        })
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        reportEventData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "POST", url: url,dataThing: nil, boundary: nil))
            .decode(type:GetReportEventModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion:  { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getreportEventModel = returnedProduct
                if self?.getreportEventModel.status ?? false {
                    self?.message = "Successfully Report this post"
                    self?.alertType = .success
                    self?.showAlert = true
                }else{
                    self?.showAlert = true
                    self?.message = "Does Not Report Something Error"
                    self?.alertType = .error
                }
                print(self?.getreportEventModel as Any)
                self?.reportEventData?.cancel()

            })
    }
}

