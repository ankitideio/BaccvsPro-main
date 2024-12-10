//
//  AllUserHashmiViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 04/03/2023.
//

import Foundation
import Combine
class AllUserHashmiViewModel : ObservableObject {
    @Published var  allUserHashmiModel : [GetAllUserHashmiModel] = []
    @Published var searchBar = ""
    private var allUserHashmiData : Cancellable?
//    init(){
//        myEvents()
//    }
    var filteredAllUsers: [GetAllUserHashmiModel] {
           if searchBar.isEmpty {
               return []
           } else {
               let lowercasedSearchText = searchBar.lowercased()
               return allUserHashmiModel.filter { $0.name.lowercased().contains(lowercasedSearchText) }
           }
       }
    func allUsers(){
        let url = URL(string: allUserHashmiDev)!
        allUserHashmiData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: [GetAllUserHashmiModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkLayer.handleCompletion, receiveValue: { [weak self] (returnedProduct) in
                self?.allUserHashmiModel = returnedProduct
                print(self?.allUserHashmiModel)
                self?.allUserHashmiData?.cancel()
            })
    }
    
}
