//
//  LocationsViewModel.swift
//  Baccvs iOS
//
//  Created by pm on 28/03/2023.
//

import Foundation
import Foundation
import Combine
import MapKit
import SwiftUI
class LocationsViewModel : ObservableObject {
    @Published var locations : [Location]
    @Published var mapLocation : Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
//    currnet region of map
    @Published var  mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1 , longitudeDelta:  0.1)
//    show list of location
    @Published var showLocationList : Bool = false
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
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
        mapLocation = location
        showLocationList = false
    }
    func nextButtonPressed(){
//        get current index
//        let currentIndex = locations.firstIndex{ location in
//            return   location == mapLocation
//        }
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation }) else {
            print("could not find current index in location array! should never happen")
            return
        }
        
        //  check if the nextindex in valid
      let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
//            next index is not valid
//            restart from 0
            guard  let firstLocation = locations.first else {return}
           showNextLocation(location: firstLocation)
            return
        }
        
        
        
//        next index is valid
        let  nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation )
        
        
    }
    
    
}
