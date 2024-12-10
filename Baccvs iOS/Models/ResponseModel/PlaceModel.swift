//
//  PlaceModel.swift
//  Baccvs iOS
//
//  Created by pm on 27/03/2023.
//

import Foundation
import MapKit
struct Place: Identifiable {
    var id = UUID()
    var name: String = String()
    var latitude: Double = Double()
    var longitude: Double = Double()
    var userOrEventId : String = String()
    var userOrEventPicture : String = String()
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
