//
//  DeleteReportsViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 22/06/2023.
//

import Foundation
import Combine
class DeleteReportsViewModel : ObservableObject{
    @Published var delreportModel = DeleteReportModel()
    @Published var getreportModel = GetDeleteReportModel()
    private var deleteReportData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    
    
    func delReport(){
        showProgress = true
        let dictData = delreportModel.dict
        let creatrReferralURL  = URL(string: deleteReportsURL)!
        let jsonData = try? JSONSerialization.data(withJSONObject: dictData ?? [:])
        deleteReportData = NetworkLayer.download(url: creatrReferralURL, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "DELETE", url: creatrReferralURL,dataThing: jsonData, boundary: nil))
            .decode(type:GetDeleteReportModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.getreportModel = returnedProduct
                if self?.getreportModel.status ?? false {
                    self?.showProgress = false
                   
                }else{
                    self?.showProgress = false
                    self?.showAlert = true
                }
                print(self?.getreportModel as Any)
                self?.deleteReportData?.cancel()

            })
    }
}

