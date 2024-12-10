//
//  MyEventsViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 03/03/2023.
//

import Foundation
import Combine
import CoreLocation
class MyEventsViewModel : ObservableObject {
    @Published var alertType : MyAlerts? = nil
    @Published var showAlert = false
    @Published var message : String = ""
    @Published var showProgress = false
    @Published var errorMessage = ""
    @Published var selectedIndex = 0
    @Published var myEventModel : GetPostsForUsersHomeModel = GetPostsForUsersHomeModel()
    @Published var eventsList : [GetPostsForUsersHomeBody] = []
    private var myEventData : Cancellable?
    @Published var  isMyevent = false
    init(){
        myEvents()
    }

    func filterData(){
        if selectedIndex == 0 {
            eventsList = myEventModel.body.filter({$0.endTime.toDate() < Date()})
        }else if selectedIndex == 1{
            eventsList = myEventModel.body.filter({$0.endTime.toDate() == Date()})
        }else{
            eventsList = myEventModel.body.filter({$0.endTime.toDate() > Date()})
        }
    }
    func fiterLocation(){
        
        let locationsList = eventsList.map { loc in
            CLLocation(latitude: Double(loc.latitude) ?? 0.0, longitude: Double(loc.latitude) ?? 0.0)
        }
        let centerLocation = CLLocation(latitude: 37.7749, longitude: -122.4194) // center location
        let radius: CLLocationDistance = 1000 // radius in meters
        let locations: [CLLocation] = locationsList // array of locations to filter

        let filteredLocations = locations.filter { location in
            location.distance(from: centerLocation) <= radius
        }
    }
    func myEvents(){
        let url = URL(string: getAllEventsDev)!
        myEventData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
            .decode(type: GetPostsForUsersHomeModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (returnedProduct) in
                self?.myEventModel = returnedProduct
                if self?.myEventModel.status ?? false {
                    self?.isMyevent = true
                    self?.showProgress = false
                    self?.filterData()
                    self?.fiterLocation()
                }else{
                    self?.showProgress = false
                    self?.isMyevent = false
                    self?.message = "Not Found"
                    self?.alertType = .error
                    self?.showAlert = true
                }
                print(self?.myEventModel)
                self?.myEventData?.cancel()
            })
    }
}
