//
//  EventDetailView.swift
//  Baccvs iOS
//  Created by pm on 09/03/2023.

import SwiftUI
import AVFoundation
import _AVKit_SwiftUI
import CoreLocation
import MapKit
import Combine
import SDWebImageSwiftUI
struct EventDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var evetDetails : GetPostsForUsersHomeBody
//    @StateObject  var  elVM =  EventLikeViewModel()
    @State var videoItem : AVPlayer = AVPlayer()
    @State var selected = "user"
    @State var isPlay : Bool = true
    @State var selectedVideoIndex = 0
    @StateObject private var playerVM = PlayerViewModel()
    @AppStorage ("userId") var  userId: String = String()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State var annotations : [EventLocation] = []
    @StateObject private var elVM =  PostsForUsersHomeViewModel()
    @State private var selectedVideo: Int = 0
    @StateObject var uVM  = UpgrageViewModel()

    var body: some View {
        ZStack{
            VStack{
                VStack(spacing:-55){
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                        TabView{
                            ForEach(evetDetails.video, id: \.video_id) { i in
                                VStack{
                                    CustomVideoPlayer(playerVM: playerVM, videoURL: i.video_link )
                                        .background(Color.textfieldColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                        .onAppear{
                                            selectedVideoIndex = evetDetails.video.firstIndex(where: {$0.video_id == i.video_id}) ?? 0
                                            playerVM.setCurrentItem(AVPlayerItem(url: URL(string: i.video_link)!))
                                            do {
                                                try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                                            }
                                            playerVM.player.play()
                                        }
                                }.background(Color.textfieldColor)
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
                            ForEach(evetDetails.music.components(separatedBy: ","),id:\.self){ i in
                                Text(i.capitalized)
                                    .foregroundColor(.white)
                           }
                        }.frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.top,20)
                        .padding(.leading,25)
                        HStack{
                            Image("labelimg")
                            Text(evetDetails.freePaid == true ? "paid" : "free")
                                .foregroundColor(.white)
                        }
                        .padding(.top,20)
                        .padding(.trailing,25)
                        Button(
                            action: {
                                if elVM.allLikes.contains(evetDetails.id){
                                    elVM.eventLikeModel.event_id = evetDetails.id
                                    elVM.eventLikeModel.dir = false
                                    elVM.eventLike()
                                    elVM.allLikes.removeAll(where: {$0 == evetDetails.id})
                                }else{
                                    elVM.eventLikeModel.event_id = evetDetails.id
                                    elVM.eventLikeModel.dir = true
                                    elVM.eventLike()
                                    elVM.allLikes.append(evetDetails.id)
                                }
                            }
                        ) {
                            Image(elVM.allLikes.contains(evetDetails.id) ? "flamefill" : "fire")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }.padding(.trailing,25)
                        .padding(.top,350)
                        HStack{
                            ForEach(0..<evetDetails.video.count, id: \.self) { i in
                                Circle()
                                    .frame(width: 6, height: 6)
                                    .foregroundColor(selectedVideoIndex == i ? .bg1 : .white)
                            }
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                            .padding(.bottom, 80)

                    } .frame(maxWidth: .infinity)
                    .frame(height: 443)

                    VStack{
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)){
                            HStack{
                                Spacer()
                                Text(evetDetails.eventOwnerName)
                                    .font(.Bold16)
                                    .foregroundColor(.white)
                                    .padding(.leading,25)
                               Spacer()
                                if evetDetails.eventOwnerID == userId {
                                    EmptyView()
                                }else{
                                    if uVM.isPro {
                                        VStack{
                                            NavigationLink(destination: ChatRoomView(senderId: evetDetails.eventOwnerID, senderImage: evetDetails.eventOwnerImage, senderName: evetDetails.eventOwnerName), label: {
                                                Image("message")
                                            })
                                                Text("Message")
                                                    .font(.Bold8)
                                                    .foregroundColor(.white)
                                             }
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
                                        .onTapGesture {
                                            selected = "time"
                                        }
                                    Text("Time")
                                        .font(.Bold8)
                                        .foregroundColor(.white)
                                }
                                VStack{
                                    Image("profileic")
                                        .font(.Bold8)
                                        .foregroundColor(.white)
                                        .onTapGesture {
                                            selected = "user"
                                        }
                                    Text("People")
                                        .font(.Bold8)
                                        .foregroundColor(.white)
                                }

                 if evetDetails.eventOwnerID == userId {
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
                                } else if evetDetails.user.contains(where: { $0.userId == userId}) {
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

                             }.padding(.horizontal,15)
                            .frame(height: 62)
                           if evetDetails.eventOwnerID == userId{
                                NavigationLink(destination: PersonalProfileView(), label: {
                                    VStack{
                                        AnimatedImage(url: URL(string: evetDetails.eventOwnerImage))
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
                                    }
                                    .padding(.leading, 15)
                                    .offset(y:-15)
                                })
                            } else {
                                NavigationLink(destination: ProfileView(id: evetDetails.eventOwnerID), label: {
                                    VStack{
                                        AnimatedImage(url: URL(string: evetDetails.eventOwnerImage))
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
                                     }
                                     .padding(.leading, 15)
                                     .offset(y:-15)
                                })
                            }
                        }
                    }
                    .background(Color.textfieldColor)
                    .frame(maxWidth: .infinity)
                }.background(Color.textfieldColor)
                .cornerRadius(17)
                .frame(height:498)
               VStack{
            ScrollView(.vertical,showsIndicators: false){
                        VStack{
                            if selected == "user"{
                        ForEach(evetDetails.user,id: \.userId){ i in
                            if i.userId == userId {
                               NavigationLink(destination: PersonalProfileView(), label: {
                                    HStack{
                                        AnimatedImage(url: URL(string: i.userImage))
                                            .resizable()
                                            .placeholder {
                                                Rectangle().foregroundColor(.gray)
                                                    .frame(width: 55,height: 55)
                                                        .cornerRadius(10)
                                            }.scaledToFill()
                                            .transition(.fade)
                                            .frame(width: 55,height: 55)
                                                .cornerRadius(10)


                                        Text(i.userName)
                                            .font(.Regular14)
                                            .foregroundColor(.white)
                                            .padding(.leading,25)

                                    }.frame(maxWidth: .infinity,alignment: .leading)
                                        .padding(.horizontal,25)
                                })
                            } else {
                                NavigationLink(destination: ProfileView(id: i.userId), label: {
                                    HStack{
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

                                    }.frame(maxWidth: .infinity,alignment: .leading)
                                        .padding(.horizontal,25)
                                        })
                                  }
                               }
                            }
                            else if selected == "description"{
                                VStack{
                                    Text(evetDetails.partyDiscripation)
                                        .frame(maxWidth : .infinity,alignment : .leading)
                                        .multilineTextAlignment(.leading)
                                        .font(.Regular11)
                                        .foregroundColor(.white)
                                        .padding(.leading,20)

                                }
                            }
                            else if selected == "time"{
                                VStack{
                                    HStack{
                                        Image("dateicon")
                                            .renderingMode(.template)
                                            .foregroundColor(.btnColor1)
                                        Text(evetDetails.startTime.convertToCustomFormat())
                                            .font(.Bold16)
                                            .foregroundColor(.white)
                                    }
                                    HStack{
                                        Image("dateicon")
                                            .renderingMode(.template)
                                            .foregroundColor(.btnColor1)
                                        Text(evetDetails.endTime.convertToCustomFormat())
                                            .font(.Bold16)
                                            .foregroundColor(.white)
                                    }

                                }
                            }
                            else if selected == "map" {
                              Map(coordinateRegion: $region, annotationItems: annotations) {
                                            MapPin(coordinate: $0.coordinate)
                                        }.frame(height: 350)

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
                    VStack{
                        Text(evetDetails.eventName)
                            .font(.Bold18)
                            .foregroundColor(.white)
                    }
                }
            }
            .onAppear{
                let clloc = CLLocationCoordinate2D(latitude: Double(evetDetails.latitude) ?? 0.0, longitude: Double(evetDetails.longitude) ?? 0.0)
              region = MKCoordinateRegion(center: clloc, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                annotations = [EventLocation(name: "", coordinate: clloc)]
            }
            .onDisappear{
                playerVM.player.pause()
            }
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(evetDetails: GetPostsForUsersHomeBody())
    }
}

struct CustomVideoPlayer: UIViewRepresentable {
    @ObservedObject var playerVM: PlayerViewModel
    var videoURL: String
    func makeUIView(context: Context) -> PlayerView {
        let view = PlayerView()
        view.player = playerVM.player
        return view
    }

    func updateUIView(_ uiView: PlayerView, context: Context) { }
}
struct EventLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}




