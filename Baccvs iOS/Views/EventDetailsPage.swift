//
//  EventDetailsPage.swift
//  Baccvs iOS
//
//  Created by pm on 29/03/2023.
//


import SwiftUI
import AVFoundation
import _AVKit_SwiftUI
import CoreLocation
import MapKit
import SDWebImageSwiftUI
struct EventDetailsPage: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @Environment(\.presentationMode) var presentationMode
    @StateObject var edVM =   EventDetailsViewModel()
    @State var videoItem : AVPlayer = AVPlayer()
    @State var selected = "user"
    @State var isPlay : Bool = true
    @AppStorage ("userId") var  userId: String = String()
    @State var eventId : String
    @StateObject private var playerVM = PlayerViewModel()
    @State var selectedVideoIndex = 0
    @StateObject var uVM  = UpgrageViewModel()
    var body: some View {
        ZStack{
            VStack{
                VStack(spacing:-55){
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                        TabView {
                            ForEach(edVM.getEventIdModel.body.video, id: \.video_id) { i in
                                VStack{
                                    CustomVideoPlayer(playerVM: playerVM, videoURL: i.video_link )
                                        .background(Color.textfieldColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                        .onAppear{
           selectedVideoIndex = edVM.getEventIdModel.body.video.firstIndex(where: {$0.video_id == i.video_id}) ?? 0
                           playerVM.setCurrentItem(AVPlayerItem(url: URL(string: i.video_link)!))
                                            do {
                                                try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                                            }
                                            playerVM.player.play()
                                        }
                                }
                                .background(Color.textfieldColor)
                            }
                        }.tabViewStyle(.page(indexDisplayMode: .never))
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                        .onTapGesture {
                            isPlay = false
                            if !isPlay{
                                playerVM.player.pause()
                            }
                        }
                        if !isPlay{
                            VStack(alignment: .center){
                                Spacer()
                                Image("playimg")
                                    .frame(width: 79,height: 79)
                                    .onTapGesture {
                                        isPlay = true
                                        if isPlay{
                                            do {  try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                                            }
                                            playerVM.player.play()
                                        }

                                    }
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        HStack{
                            Image("musicic")
                            ForEach(edVM.getEventIdModel.body.music.components(separatedBy: ","),id:\.self){ i in
                                Text(i.capitalized)
                                 .foregroundColor(.white)
                           }
                        }.frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.top,20)
                        .padding(.leading,25)
                        HStack{
                            ForEach(0..<edVM.getEventIdModel.body.video.count, id: \.self) { i in
                                Circle()
                                    .frame(width: 6, height: 6)
                                    .foregroundColor(selectedVideoIndex == i ? .bg1 : .white)
                            }
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                            .padding(.bottom, 80)
                        }.frame(maxWidth: .infinity)
                    VStack{
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)){
                            HStack{
                                Spacer()
                                if edVM.getEventIdModel.body.eventOwnerID == userId {
                                    EmptyView()

                                }else{
                                    if uVM.isPro {
                                        NavigationLink(destination: ChatRoomView(senderId: edVM.getEventIdModel.body.eventOwnerID, senderImage: edVM.getEventIdModel.body.eventOwnerImage, senderName: edVM.getEventIdModel.body.eventOwnerName), label: {
                                            VStack{
                                                Image("message")
                                                Text("Message")
                                                    .font(.Bold8)
                                                    .foregroundColor(.white)
                                            }
                                        })
                                    }else {
                                        NavigationLink(destination: OffersView(), label: {
                                            Image("lockmessage")
                                        })
                                    }
                                    }
                                VStack{
                                    Image("descrption")
                                        .font(.Bold8)
                                        .foregroundColor(.white)
                                        .onTapGesture {
                                            selected = "description"
                                        }
                                    Text("Description")
                                        .font(.Bold8)
                                        .foregroundColor(.white)
                                }
                                VStack{
                                    Image("timeic")
                                        .font(.Bold8)
                                        .foregroundColor(.white)

                                      Text("Time")
                                        .font(.Bold8)
                                        .foregroundColor(.white)
                                }.onTapGesture {
                                    selected = "time"
                                }
                                VStack{
                                    Image("profileic")
//                                    Text("\(edVM.getEventIdModel.body.user.count)")
                                        .font(.Bold8)
                                        .foregroundColor(.white)
                                    Text("People")
                                        .font(.Bold8)
                                        .foregroundColor(.white)
                                }.onTapGesture {
                                    selected = "user"
                                }
                                if  edVM.getEventIdModel.body.eventOwnerID == userId {
                                                   VStack{
                                                           Image("Location")
                                                               .font(.Bold8)
                                                               .foregroundColor(.white)

                                                           Text("Location")
                                                               .font(.Bold8)
                                                               .foregroundColor(.white)

                                                   } .onTapGesture{
                                                       selected = "map"
                                                   }
                                               } else if edVM.getEventIdModel.body.user.contains(where: { $0.userID == userId}) {
                                                   VStack{
                                                           Image("Location")
                                                               .font(.Bold8)
                                                               .foregroundColor(.white)

                                                           Text("Location")
                                                               .font(.Bold8)
                                                               .foregroundColor(.white)

                                                   } .onTapGesture{
                                                       selected = "map"
                                                   }
                                               }

//                                VStack{
//                                        Image("Location")
//                                            .font(.Bold8)
//                                            .foregroundColor(.white)
//
//                                        Text("Location")
//                                            .font(.Bold8)
//                                            .foregroundColor(.white)
////                                    }
//
//                                }  .onTapGesture{
//                                    selected = "map"
//                                }
//                                if  edVM.getEventIdModel.body.eventOwnerID == userId
//                                       {
//                                    VStack{
//                                        Image("Location")
////                                            .font(.Bold8)
////                                            .foregroundColor(.white)
//                                        Text("Location")
//                                            .font(.Bold8)
//                                            .foregroundColor(.white)
//                                    }.onTapGesture{
//                                        selected = "map"
//                                    }
//                                }

                            }.padding(.horizontal,15)
                            .frame(height: 62)
                            VStack{
                                if edVM.getEventIdModel.body.eventOwnerID == userId{
                                    NavigationLink(destination: PersonalProfileView(), label: {
                                        AnimatedImage(url: URL(string: edVM.getEventIdModel.body.eventOwnerImage))
                                            .resizable()
                                            .placeholder {
                                                Rectangle().foregroundColor(.gray)
                                                    .frame(width: 56,height: 70)
                                                    .cornerRadius(5)
                                            }
                                            .scaledToFill()
                                            .transition(.fade)
                                            .frame(width: 56,height: 70)
                                            .cornerRadius(5)
                                            .offset(y: -20)

                                    })
                                }else {
                                    NavigationLink(destination: ProfileView(id: edVM.getEventIdModel.body.eventOwnerID), label: {
                                        AnimatedImage(url: URL(string: edVM.getEventIdModel.body.eventOwnerImage))
                                            .resizable()
                                            .placeholder {
                                                Rectangle().foregroundColor(.gray)
                                                    .frame(width: 56,height: 70)
                                                    .cornerRadius(10)
                                            }
                                            .scaledToFill()
                                            .transition(.fade)
                                            .frame(width: 56,height: 70)
                                            .cornerRadius(10)
                                            .offset(y: -20)
                                    })
                                }
                            }.padding(.leading, 10)
                            HStack{
                                Text(edVM.getEventIdModel.body.eventOwnerName)
                                    .font(.Bold16)
                                    .foregroundColor(.white)
                                    .padding(.leading,80)
                                    .offset(y: -15)
                            }
                        }.padding(.horizontal,15)
                    } .background(Color.textfieldColor)
                    .frame(maxWidth: .infinity)
                }.background(Color.textfieldColor)
               .cornerRadius(17)
               .frame(height:498)
                VStack{
                    ScrollView(.vertical,showsIndicators: false){
                        VStack{
                            if selected == "user" {
                                ForEach(edVM.getEventIdModel.body.user,id: \.userID){ i in
                                    HStack{
                                        if edVM.getEventIdModel.body.eventOwnerID == userId {
                                            NavigationLink(destination: PersonalProfileView(), label: {
                                                AnimatedImage(url: URL(string: i.userImage))
                                                    .resizable()
                                                    .placeholder {
                                                        Rectangle().foregroundColor(.gray)
                                                            .frame(width: 55,height: 55)
                                                            .cornerRadius(10)
                                                    }
                                                    .scaledToFill()
                                                    .transition(.fade)
                                                    .frame(width: 55,height: 55)
                                                    .cornerRadius(10)
                                                Text(i.userName)
                                                    .font(.Regular14)
                                                    .foregroundColor(.white)
                                                    .padding(.leading,25)
                                            })

                                        }else {
                                            NavigationLink(destination: ProfileView(id: i.userID), label: {
                                                AnimatedImage(url: URL(string: i.userImage))
                                                    .resizable()
                                                    .placeholder {
                                                        Rectangle().foregroundColor(.gray)
                                                            .frame(width: 55,height: 55)
                                                            .cornerRadius(10)
                                                    }
                                                    .scaledToFill()
                                                    .transition(.fade)
                                                    .frame(width: 55,height: 55)
                                                    .cornerRadius(10)
                                                Text(i.userName)
                                                    .font(.Regular14)
                                                    .foregroundColor(.white)
                                                    .padding(.leading,25)
                                            })
                                        }
                                    }.frame(maxWidth: .infinity,alignment: .leading)
                                        .padding(.horizontal,25)
                                }
                            }
                            else if selected == "description"{
                                VStack{
                                    Text(edVM.getEventIdModel.body.partyDiscripation)
                                        .frame(maxWidth : .infinity,alignment : .leading)
                                        .multilineTextAlignment(.leading)
                                        .font(.Regular11)
                                        .foregroundColor(.white)
                                        .padding(.leading,20)
                                }
                            }
                            else if selected == "time"{
                                VStack{
                                    Text(edVM.getEventIdModel.body.startTime.convertToCustomFormat())
                                        .foregroundColor(.white)
                                    Text(edVM.getEventIdModel.body.endTime.convertToCustomFormat())
                                        .foregroundColor(.white)
                                }
                            }
                            else if selected == "map" {
                                Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                                    .frame( height: 350)
                            }
                        }
                    }
                }
               Spacer()
            }
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(bgView())
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Image("leftarrow")
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                ToolbarItem(placement: .principal){
                    Text(edVM.getEventIdModel.body.eventName)
                        .foregroundColor(.white)
                }
            }
            .onAppear{
                edVM.eventIdModel.event_id = eventId
                edVM.eventDetails()
            }
            .onAppear{
               region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(edVM.getEventIdModel.body.latitude) ?? 0.0, longitude: Double(edVM.getEventIdModel.body.longitude) ?? 0.0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            }
            .onDisappear{
                playerVM.player.pause()
            }
    }
}
struct EventDetailsPage_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsPage(eventId: "")
    }
}
