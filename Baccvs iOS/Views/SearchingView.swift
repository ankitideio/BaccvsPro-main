//
//  SearchingView.swift
//  Baccvs iOS
//
//  Created by pm on 21/02/2023.
//

import SwiftUI
import MapKit
import UIKit
struct SearchingView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var locationManager : LocationManager = .init()
    @Binding var selectedLocation : String
    @Binding var long : String
    @Binding var lat : String
    @State var NavigationTag : String?
    var body: some View {
        ZStack{
            VStack{
                HStack(spacing: 10){
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("", text: $locationManager.searchText)
                        .foregroundColor(.white)
                }
                .padding(.vertical,12)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 10,style: .continuous)
                        .strokeBorder(.gray)).padding(.vertical,10)
                Button{
                    if let coordinate = locationManager.userLocation?.coordinate{
                        locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters:1000)
                        locationManager.addDraggblePin(coordinate: coordinate)
                        locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))

//                        NavigationTag = "MAPVIEW"
                    }
                   
                }label: {
                    Label {
                        Text("Use Current Location")
                            .font(.callout)
                    } icon:{
                        Image(systemName: "location.north.circle.fill")
                    }.foregroundColor(.green)
                    
                }.frame(maxWidth: .infinity,alignment: .leading)
                ZStack{
                    MapViewSelection(locationMangaer: locationManager, selectedLocation: $selectedLocation,  long: $long, lat: $lat)
                    if let places = locationManager.fetchedPlaces,!places.isEmpty{
                        List{
                            ForEach(places,id: \.self){ place in
                                Button{
                                    if let coordinate = place.location?.coordinate{
                                        locationManager.pickedLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                        
                                        locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters:1000)
                                        locationManager.addDraggblePin(coordinate: coordinate)
                                        locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                                    }
                                    locationManager.searchText = ""
                                    NavigationTag = "MAPVIEW"
                                }label: {
                                    HStack(spacing: 15){
                                        Image(systemName: "mappin.circle.fill")
                                            .font(.title2)
                                            .foregroundColor(.gray)
                                        VStack(alignment: .leading,spacing: 6){
                                            
                                            Text(place.name ??  "")
                                                .font(.title3.bold())
                                                .foregroundColor(.primary)
                                            
                                            Text(place.locality ??  "")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                            
                                        }

                                    }

                                }
                               
                                
                            }
                            
                        }.listStyle(.plain)
                        
                    }
                }
                
                
            }.padding()
            
            
        }.frame(maxHeight: .infinity,alignment: .top)
        .navigationBarBackButtonHidden(true)
        .background(bgView())
        .background{
//            NavigationLink(tag : "MAPVIEW",selection: $NavigationTag){
//                MapViewSelection(locationMangaer: <#LocationManager#>)
//                    .environmentObject(locationManager)
//                    .navigationBarBackButtonHidden(true)
//
//            }label: {}
//                .labelsHidden()
        }
        .onAppear{
            if let coordinate = locationManager.userLocation?.coordinate{
                locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters:1000)
                locationManager.addDraggblePin(coordinate: coordinate)
                locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                
//                        NavigationTag = "MAPVIEW"
            }
        }
        
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                    Image("leftarrow")
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
               
}
            ToolbarItem(placement: .principal){
                VStack{
                    Text("Find Location")
                        .foregroundColor(.white)
                        .font(.Medium18)
               }
                
            }

        }
    }
}

//struct SearchingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchingView(selectedLocation: .constant(""))
//    }
//}


struct MapViewSelection: View{
    @StateObject var locationMangaer : LocationManager
    @Binding var selectedLocation : String
    @Binding var long : String
    @Binding var lat : String
    @Environment(\.dismiss) var dismiss
    var body: some View{
        ZStack{
            MapViewHelper()
            .environmentObject(locationMangaer)
            .ignoresSafeArea()
            
//            Button{
//
//            }label: {
//                Image(systemName: "chevron.left")
//                    .font(.title2.bold())
//                    .foregroundColor(.primary)
//            }.padding()
//            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
            
//            display data
            if let place = locationMangaer.pickedplaceMark{
                VStack(spacing:15){
                    Text("Confirm Location")
                        .font(.title2.bold())
                    HStack(spacing: 15){
                        Image(systemName: "mappin.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                        VStack(alignment: .leading,spacing: 6){
                            
                            Text(place.name ??  "")
                                .font(.title3.bold())
                            
                            Text(place.locality ??  "")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                        }

                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.vertical,10)
                    
                    Button{
                        long = "\(place.location?.coordinate.longitude ?? 0.0)"
                        lat  = "\(place.location?.coordinate.latitude ?? 0.0)"
                        selectedLocation = place.name ??  ""
                        
                        dismiss()
                    }label: {
                        Text("Confirm Location")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical,12)
                            .background{
                                RoundedRectangle(cornerRadius: 10,style: .continuous)
                                    .fill(.green)
                            }.overlay(alignment: .trailing){
                                Image(systemName: "arrow.right")
                                    .font(.title3.bold())
                                    .padding(.trailing)
                            }.foregroundColor(.white)
                        
                    }

                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10,style: .continuous)
                        .fill(.white)
                        .ignoresSafeArea()
                }.frame(maxHeight: .infinity,alignment: .bottom)
            }
        }
        .onDisappear{
            locationMangaer.pickedLocation  = nil
            locationMangaer.pickedplaceMark = nil
            locationMangaer.mapView.removeAnnotations(locationMangaer.mapView.annotations)
        }
    }
}


struct MapViewHelper: UIViewRepresentable{
    @EnvironmentObject var locationMangaer : LocationManager
    func makeUIView(context:Context) -> MKMapView {
        return locationMangaer.mapView
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
}
