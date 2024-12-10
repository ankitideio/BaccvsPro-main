//
//  LocationsView.swift
//  Baccvs iOS
//
//  Created by pm on 28/03/2023.
import Foundation
import SwiftUI
import Combine
import MapKit
struct LocationsView: View {
    @StateObject var mpVM = MapPageViwModel()
    var body: some View {
        ZStack{
            Map(coordinateRegion: $mpVM.region, showsUserLocation: false,  annotationItems: mpVM.places){ place in
                            MapAnnotation(coordinate: place.coordinate) {
                                VStack {
                                    NavigationLink {
                                        
                                    } label: {
                                        Image("location-pin")
                                            .resizable()
                                            .frame(width: 44, height: 44)
                                    }
                                    
                                }
                            }
                        }
                .ignoresSafeArea()
            VStack(spacing: 0){
                Text("dummy")
//                     header
                    .padding()
                  Spacer()
//                locationPreViewStack
                Text("envnt detail")
            }
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsView {
    private var header : some View{
        VStack{
            Button(action: mpVM.toggleLocationList){
                Text("mpVM.postsForUsersModel.body.eventName mpVM.postsForUsersModel.body.eventOwnerName")
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
//                    .animation(.none, value: mpVM.region)
                    .overlay(alignment: .leading){
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: mpVM.showLocationList ? 180 : 0 ))
                    }
              }
            if mpVM.showLocationList {
                LocationListView()
            }

        }.background(.thickMaterial)
            .cornerRadius(10)
            .shadow(color : Color.black.opacity(0.3),radius: 20,
            x: 0,y: 15)

    }

//    private var locationPreViewStack : some View {
//        ZStack{
//            ForEach(vm.locations){ location in
//
//                if vm.mapLocation == location {
//
//                    LocationPreView(location: location)
//                        .shadow(color: Color.black.opacity(0.3),radius: 20)
//                        .padding()
//                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
//                }
//
//            }
//        }
//    }


}
