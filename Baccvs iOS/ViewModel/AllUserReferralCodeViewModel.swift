//
//  AllUserReferralCodeViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 23/03/2023.
//

import Foundation
import Combine
class AllUserReferralCodeViewModel : ObservableObject {
    @Published var allUserReferralCode : GetAllReferralCodeModel =  GetAllReferralCodeModel()
    private var referralCodeData : Cancellable?
    @Published var showProgress = false
    @Published var errorMessage = ""
    
    init(){
        allUserReferrlCode()
    }
    
    func allUserReferrlCode(){
        showProgress = true
        let url = URL(string:  allReferralCodeDev)!
        referralCodeData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetAllReferralCodeModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.allUserReferralCode = returnedProduct
                if self?.allUserReferralCode.status ?? false {
                    self?.showProgress = false
                }else{
                    self?.showProgress = false
                }
                print(self?.allUserReferralCode)
                self?.referralCodeData?.cancel()
            })
    }
}
