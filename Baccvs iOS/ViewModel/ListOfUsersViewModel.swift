//
//  ListOfUsersViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 10/03/2023.
//

import Foundation
import Combine
class ListOfUsersViewModel : ObservableObject {
    @Published var hashmiModel : [HashmiModel] = []
    private var  listData : Cancellable?
    
    init(){
        listofUsers()
    }
    func listofUsers(){
        let url = URL(string:  allUserHashmiDev)!
        listData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type:[HashmiModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkLayer.handleCompletion, receiveValue: { [weak self] (returnedProduct) in
                self?.hashmiModel = returnedProduct
                print(self?.hashmiModel)
                self?.listData?.cancel()
            })
    }
    
}
