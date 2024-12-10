//
//  ReportsViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 22/06/2023.
//

import Foundation
import Combine
class ReportsViewModel : ObservableObject {
    @Published var getallReportsModel = GetAllReportsModel()
    private var ReportsData : Cancellable?
    @Published var queryItems : [URLQueryItem] = []
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    
    func allReports(){
        showProgress = true
        let url = URL(string:  getallReportsURL)!
        ReportsData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetAllReportsModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getallReportsModel = returnedProduct
                if self?.getallReportsModel.status ?? false {
                    self?.showProgress = false
                }else{
                    self?.showProgress = false
                }
                print(self?.getallReportsModel)
                self?.ReportsData?.cancel()
            })
    }
  
}
