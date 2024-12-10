//
//  MapPage.swift
//  Baccvs iOS
//
//  Created by pm on 27/03/2023.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI
struct MapPage: View {
    @StateObject var mpVM = MapPageViwModel()
    @Environment(\.presentationMode) var presentationMode
    @State var preselectedIndex = 0
    @AppStorage ("userId") var  userId: String = String()

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)){
            Map(coordinateRegion: $mpVM.region, showsUserLocation: true, userTrackingMode: $mpVM.userTrackingMode, annotationItems: mpVM.places) { place in
                       MapAnnotation(coordinate: place.coordinate) {
                           VStack {
                               NavigationLink(destination: EventDetailsPage(eventId: place.userOrEventId)) {
                                   Image("locationic")
                                       .resizable()
                                       .scaledToFill()
                                       .frame(width: 44, height: 44)
                               }
                           }
                       }
                   }
//            Map(coordinateRegion: $mpVM.region, showsUserLocation: true, annotationItems: mpVM.places) { place in
//                MapAnnotation(coordinate: place.coordinate) {
//                    VStack {
//                        NavigationLink(destination: EventDetailsPage(eventId: place.userOrEventId)) {
//                            Image("locationic")
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 44, height: 44)
//                        }
//                    }
//                }
//            }

//            Map(coordinateRegion: $mpVM.region, showsUserLocation: true,  userTrackingMode: .constant(.follow), annotationItems: mpVM.places){ place in
//                            MapAnnotation(coordinate: place.coordinate) {
//                                VStack {
//                                    NavigationLink {
//                                        EventDetailsPage(eventId: place.userOrEventId)
//                                    }  label: {
//                                        Image("locationic")
//                                            .resizable()
//                                            .scaledToFill()
//                                            .frame(width: 44, height: 44)
//                                    }
//                                }
//                            }
//                         }
            VStack{
                VStack{
                    VStack{
                        Image("backarrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width:34,height: 34)
                    }.frame(maxWidth: .infinity,alignment: .leading)
                       .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                       .padding(.top,50)
                       .padding(.horizontal,30)
                   
                    CustomSegmentedControlPage(preselectedIndex: $preselectedIndex, options: ["Events" , "People"])
                        .foregroundColor(.white)
                        .font(.Regular16)
                        .padding(.horizontal,20)
                        .padding(.top, 30)
                        .onChange(of: preselectedIndex) { newValue in
                            mpVM.selectedIndex(index: newValue)
                        }
                    HStack{
                        Spacer()
                        Button(action: {
                                mpVM.userTrackingMode = .follow // Set the tracking mode to follow for the user's location
                            }) {
                                ZStack{
                                    Circle()
                                        .fill(.black.opacity(0.5))
                                        .frame(width: 44, height: 44)
                                    Image(systemName: "location.fill") // You can use a custom image here if needed
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.top, 16) // Adjust the button's position as needed
                            .padding(.trailing, 16)
                    }
                }
                Spacer()
                HStack{
                    if preselectedIndex == 1{
                        PeoplePage(palces: mpVM.places)
                    } else if preselectedIndex == 0 {
                        
                        EventsPage(palces: mpVM.places)
                    }
                }.padding(.bottom,40)
           }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .background(bgView())
        
    }
}

struct MapPage_Previews: PreviewProvider {
    static var previews: some View {
        MapPage()
    }
}


struct PeoplePage : View {
    var palces: [Place]
    @StateObject var mpVM = MeetPeopleOnlineViewModel()

    var body: some View {
        VStack{
            ScrollView(.horizontal,showsIndicators: false){
                    HStack{
                        ForEach(palces,id: \.id) { n in
                                NavigationLink(destination: ProfileView(id: n.userOrEventId)) {
                                    VStack{
                                        AnimatedImage(url: URL(string: n.userOrEventPicture))
                                            .resizable()
                                            .placeholder {
                                                Rectangle().foregroundColor(.gray)
                                                    .frame(width: 172,height: 240)
                                                        .cornerRadius(10)
                                            }
                                            .scaledToFill()
                                            .transition(.fade)
                                            .frame(width: 172,height: 240)
                                                .cornerRadius(10)
                                        Text(n.name)
                                            .font(.Regular14)
                                            .foregroundColor(.white)
                                            .offset(y:-35)
                                    }
                                }
                        }
                }
            }
        }
    }
}
struct EventsPage : View {
    var palces: [Place]
    @AppStorage ("userId") var  userId: String = String()
    var body: some View {
        HStack{
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    ForEach(palces, id: \.id){ n in
                            NavigationLink(destination: EventDetailsPage(eventId: n.userOrEventId)){
                                VStack{
                                    AnimatedImage(url: URL(string: n.userOrEventPicture))
                                        .resizable()
                                        .placeholder {
                                            Rectangle().foregroundColor(.gray)
                                                .frame(width: 172,height: 240)
                                                    .cornerRadius(10)
                                        }
                                        .scaledToFill()
                                        .transition(.fade)
                                        .frame(width: 172,height: 240)
                                            .cornerRadius(10)
                                }
                            }
                    }
                }
            }
        }
    }
}


struct CustomSegmentedControlPage: View {
    @Binding var preselectedIndex: Int
    var options: [String]
    let color = LinearGradient.secondaryGradient
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id:\.self) { index in
                ZStack {
                    Rectangle()
                        .fill(color.opacity(0.1))
                    Rectangle()
                        .fill(color)
                        .cornerRadius(20)
                        .padding(2)
                        .opacity(preselectedIndex == index ? 1 : 0.01)
                        .onTapGesture {
                                withAnimation(.interactiveSpring()) {
                                    preselectedIndex = index
                                }
                            }
                }
                .overlay(
                    Text(options[index])
                )
            }
        }
        .frame(width: 300,height: 40)
        .cornerRadius(20)
    }
}
extension MapPage {
    private var header : some View{
        VStack{
            Button(action: mpVM.toggleLocationList){
                Text("mpVM.posts")
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
}
