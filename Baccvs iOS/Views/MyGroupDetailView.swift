//
//  MyGroupDetailView.swift
//  Baccvs iOS
//
//  Created by pm on 03/05/2023.
//

import SwiftUI
import AVFoundation
import _AVKit_SwiftUI
import SDWebImageSwiftUI
import Combine
import Photos
import PhotosUI
import CoreTransferable
import AVKit
struct MyGroupDetailView: View {
//    var myGroupDetail : GroupFriends
    @Environment(\.presentationMode) var presentationMode
    @State private var showSheet = false
    @ObservedObject var mediaItems = PickedMediaItems()
    @State var selectedVides : [AVPlayer] = []
    @StateObject var videPicker = VideoPicker()
    @StateObject var cpVM = CreatePostViewModel()
    @State var editGroup :  GroupOwnerDetail
    @StateObject var gpVM =  GetGroupPostsViewModel()
    @State  var isPlay : Bool = true
    @StateObject private var playerVM = PlayerViewModel()
    var body: some View {
        ZStack{
            VStack{
                ScrollView(.vertical,showsIndicators: false){
                    HStack{
                        ForEach(editGroup.user, id:\.userID){ i in
                            AnimatedImage(url: URL(string:  i.userImage))
                                .resizable()
                                .placeholder {
                                    Rectangle().foregroundColor(.gray)
                                        .frame(width: 71,height: 99)
                                        .cornerRadius(15)
                                }
                                .scaledToFill()
                                .transition(.fade)
                                .frame(width: 71,height: 99)
                                .cornerRadius(15)
                        }
                    } .padding(.top,20)
                    VStack{
                        Text(editGroup.groupDescription)
                            .foregroundColor(.white)
                        
                    }.padding(.horizontal,25)
                    VStack(alignment: .center){
                        if mediaItems.items.isEmpty{
//                            Image("videos")
                            NavigationLink {
                                GroupChatView(groupID: editGroup.id, groupName: editGroup.groupName)
                            } label: {
                                HStack{
                                    Image(systemName: "rectangle.3.group.bubble.left")
                                    Text("Group Chat")
                                        .font(.Medium16)
                                        
                                }
                                .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                            }.frame(height:65)
                                .background(LinearGradient.secondaryGradient)
                                .cornerRadius(60)
                            
                        }else{
                            ScrollView(.horizontal,showsIndicators: false){
                                ZStack{
                                    HStack(spacing: 10){
                                        ForEach(mediaItems.items.indices, id: \.self) { n in
                                            if mediaItems.items[n].mediaType == .video {
                                                if let url = mediaItems.items[n].url {
                                                    ZStack(alignment: .topTrailing) {
                                                        VideoPlayer(player: AVPlayer(url: url))
                                                            .frame(width: 100, height: 100)
                                                        Image(systemName: "x.circle.fill")
                                                            .offset(x:4,y:5)
                                                            .font(.title3)
                                                            .onTapGesture {
                                                                mediaItems.deleteAt(index: n)
                                                                mediaItems.items.remove(at: n)
                                                            }
                                                           
                                                    }.cornerRadius(10)
                                                   .padding(.leading,5)
                                                }
                                            } else { EmptyView() }
                                        }
                                    }
                                }
                            }
                             VStack{
                                Button(action:{
                                    cpVM.isGroupPost = true
                                  cpVM.createPostModel.group_id = editGroup.id
                                    mediaItems.items.forEach { ph in
                                        guard let videoData = try? Data(contentsOf: ph.url!) else {
                                            return
                                        }
                       cpVM.createPostModel.video = Media(part_vedio_url: videoData, mimeType: "video/mp4", fileName: "\(arc4random()).mp4", paramName: "video")
                                    }
                                    cpVM.groupPost()
                                    
                                }){
                                    Text("Upload Video")
                                        .font(.Medium14)
                                }.frame(width: 125, height: 41)
                                    .background(LinearGradient.secondaryGradient)
                                    .cornerRadius(60)
                            }.alert(isPresented: $cpVM.showAlert, content: {
                                 getAlert(alertType: cpVM.alertType, message: cpVM.message)
                             }).padding(.top,60)
                            .frame(maxWidth: .infinity,alignment: .trailing)
                        }
                        Spacer()
                    }.padding(.top,50)
                    VStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            VideoPlayerCustom(playerM: gpVM.allVideos)
                        }
                    }.padding(.top, 20)
                  
//                    VStack {
//                        ScrollView(.vertical, showsIndicators: false) {
//                            VStack{
//                                ForEach(editGroup.posts , id: \.videoID) { post in
//                                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
//                                                  VStack{
//                                                      CustomVideoPlayer(playerVM: playerVM, videoURL: post.videoURL )
//                                                    .background(Color.textfieldColor)
//                                                 .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
//                                                 .onTapGesture {
//                                                     isPlay = false
//                                                     if !isPlay {
//                                                         playerVM.player.pause()
//                                                     }
//                                                     if let videoURL = URL(string: post.videoURL) {
//                                    playerVM.setCurrentItem(AVPlayerItem(url: videoURL))
//                                                       do {
//                                                             try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
//                                                                    } catch {
//                                                            print("Failed to set audio session category: \(error)")
//                                                                     }
//                                                                       playerVM.player.play()
//                                                                                  }
//                                                    }
////
//                                                  }
//                                                  if !isPlay {
//                                                      VStack(alignment: .center) {
//                                                          Spacer()
//                                                          Image("playimg")
//                                                         .resizable()
//                                                         .aspectRatio(contentMode: .fit)
//                                                              .frame(width: 79, height: 79)
//                                                              .onTapGesture {
//                                                                  isPlay = true
//                                                                  if isPlay {
//                                                                      do {
//                                                                          try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
//                                                                      }
//                                                                      playerVM.player.play()
//                                                                  }
//                                                              }
//                                                          Spacer()
//                                                      }
//                                                      .frame(maxWidth: .infinity, alignment: .center)
//                                                  }
//                                   }
//
//                                }.frame(maxWidth: .infinity)
//                                    .frame(height: 443)
//                            }
//                        }
//                    }.padding(.top, 20)
                    

                }.padding(.top,10)
            }.frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal,25)
            if cpVM.showProgress{
                ZStack{
                    ProgressView()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.5))
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
                    Text("Please wait while the media is being uploaded.")
                        .foregroundColor(.white)
                        .padding(.top, 50)
                }
              }
        }.sheet(isPresented: $showSheet) {
            PhotoPicker(selectionLimit: 1, filter: .any(of: [.videos]), mediaItems: mediaItems) { didSelectItem in
                if didSelectItem{
                    mediaItems.items = []
                }
                print(didSelectItem)
                showSheet = false
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .background(bgView())
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                        Image("leftarrow")
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                 
  }
                ToolbarItem(placement: .principal){
                    VStack{
                        Text(editGroup.groupName)
                            .font(.Regular18)
                            .foregroundColor(.white)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action:{
                        showSheet.toggle()
                    }){
                        Text("post")
                            .font(.Medium14)
                            .foregroundColor(.white)
                            .padding(.trailing,5)
                    }.frame(width: 62 ,height: 41)
                        .background(LinearGradient.secondaryGradient)
                        .cornerRadius(60)
                    
                }
        }.onDisappear{
                playerVM.player.pause()
            }
        .onAppear{
            gpVM.groupPostsModel.group_id = editGroup.id
            gpVM.groupPostDetails()
        }
    }
    
   
}

struct MyGroupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyGroupDetailView(editGroup: GroupOwnerDetail())
    }
}



struct VideoPlayerCustom : View{
    @State  var isPlay : Bool = true
    var playerM : [DynamicPlayer]
    @State var selectedVideoID : [DynamicPlayer] = []
    var body: some View{
        VStack{
            ForEach(playerM, id: \.id) { post in
                
                
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    VStack {
                        CustomVideoPlayer1(video: post)
                            .background(Color.textfieldColor)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .onTapGesture {
//                                selectedVideoID.append(post.id)
                                selectedVideoID.forEach { video in
                                    video.player.pause()
                                }
                                selectedVideoID.removeAll()
//                                }
//                                selectedVideoID.removeAll()
                            }
                       }

                    if !selectedVideoID.contains(where: {$0.id == post.id}) {
                        VStack(alignment: .center) {
                            Spacer()
                            Image("playimg")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 79, height: 79)
                                .onTapGesture {
                                    selectedVideoID.append(post)
                                    if selectedVideoID.contains(where: {$0.id == post.id}){
                                        selectedVideoID.forEach { video in
                                            video.player.pause()
                                        }
                                        selectedVideoID.removeAll()
                                        selectedVideoID.append(post)
                                        post.player.play()
                                    }
                                }
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .frame(maxWidth: .infinity)
                    .frame(height: 443)
            }
            
        }
        
    }
}
import AVKit

struct CustomVideoPlayer1: UIViewControllerRepresentable{
    
    var video: DynamicPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        
        let view = AVPlayerViewController()
        view.player = video.player
        view.showsPlaybackControls = false
        view.view.backgroundColor = .clear
        view.videoGravity = .resizeAspectFill
        
        return view
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
        print(uiViewController.videoBounds.height)
    }
}
struct DynamicPlayer{
    var id : String
    var player: AVPlayer
}
