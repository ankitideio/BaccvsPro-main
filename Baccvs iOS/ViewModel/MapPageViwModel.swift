//
//  MapPageViwModel.swift
//  Baccvs iOS
//
//  Created by pm on 27/03/2023.
//

import Foundation
import Foundation
import Combine
import MapKit
import SwiftUI
class MapPageViwModel : NSObject, ObservableObject, MKMapViewDelegate,CLLocationManagerDelegate{
    @Published var locations : [Location] = []
//    currnet region of map
    @Published var  mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1 , longitudeDelta:  0.1)
//    show list of location
    private let locationManager = CLLocationManager()
    @Published var manager: CLLocationManager = .init()
    @Published var showLocationList : Bool = false
    @Published var errorMessage = ""
    @Published var showProgress = false
    @Published var postsForUsersModel : GetPostsForUsersHomeModel = GetPostsForUsersHomeModel()
    @Published var ymPeople : GetYamatetPeopleModel = GetYamatetPeopleModel()
    @Published var message : String = ""
    @Published  var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    private var  postsForUsersData : Cancellable?
    private var meetPeopleOnlineData : Cancellable?
    @AppStorage ("userId") var  userId: String = String()
    var  places : [Place] = []
    @Published var userTrackingMode: MapUserTrackingMode = .follow
    override init(){
        super.init()
        
        manager.delegate = self        
        manager.requestWhenInUseAuthorization()
        postsForUserHome()
        meetPeopleOnline()
        
    }
    func selectedIndex(index: Int){
        places = []
        if index == 0{
            _ = postsForUsersModel.body.map({ gp in
                places.append(Place(name: gp.eventName, latitude: Double(gp.latitude) ?? 0.0, longitude: Double(gp.longitude) ?? 0.0, userOrEventId: gp.id, userOrEventPicture: gp.tumNail))
            })
            region = MKCoordinateRegion(center: places.first?.coordinate ?? CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }else{
            _ = ymPeople.body.map({ gp in
                places.append(Place(name: gp.name, latitude: Double(gp.latitude) ?? 0.0, longitude: Double(gp.longitude) ?? 0.0, userOrEventId: gp.id, userOrEventPicture: gp.image))
            })
            region = MKCoordinateRegion(center: places.first?.coordinate ?? CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }
    func postsForUserHome(){
        let url = URL(string:  postsForUsersDev)!
        postsForUsersData = NetworkLayer.download(url: url, req: NetworkLayer.requestType(apiTypes: .jason, contentType: "GET", url: url, dataThing: nil, boundary: nil))
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
                self?.postsForUsersModel = returnedProduct
                if self?.postsForUsersModel.status ?? false {
                    self?.selectedIndex(index: 0)
                    self?.showProgress = false
                   
                }else{
                    self?.showProgress = false
                    self?.message = "Not Found"
                }

                print(self?.postsForUsersModel as Any)
                self?.postsForUsersData?.cancel()
            })
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
                self?.ymPeople = returnedProduct
                if self?.ymPeople.status ?? false {
                    
                    self?.showProgress = false
                    
                }else{
                    self?.showProgress = false
                    self?.message = "Not Found"
                }
                print(self?.ymPeople as Any)
                self?.meetPeopleOnlineData?.cancel()
            })
    }
    
    private func updateMapRegion(location : Location){
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
     func toggleLocationList(){
        withAnimation(.easeInOut){
            showLocationList = !showLocationList
        }
    }
    func showNextLocation(location : Location){
//        mapLocation = location
        showLocationList = false
    }
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func getCurrentLocation() {
        locationManager.requestLocation()
    }
    func nextButtonPressed(){
//        get current index
//        let currentIndex = locations.firstIndex{ location in
//            return   location == mapLocation
//        }
//        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation }) else {
//            print("could not find current index in location array! should never happen")
//            return
//        }

        //  check if the nextindex in valid
//      let nextIndex = currentIndex + 1
//        guard locations.indices.contains(nextIndex) else {
////            next index is not valid
////            restart from 0
//            guard  let firstLocation = locations.first else {return}
//           showNextLocation(location: firstLocation)
//            return
//        }
//
////        next index is valid
//        let  nextLocation = locations[nextIndex]
//        showNextLocation(location: nextLocation )


    }

}
