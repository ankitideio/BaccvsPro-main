//
//  GroupDetailView.swift
//  Baccvs iOS
//
//  Created by pm on 15/03/2023.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine
import Photos
import PhotosUI
import CoreTransferable
import AVKit
   struct GroupDetailView: View {
    var geoupDetail : GroupFriends
    @Environment(\.presentationMode) var presentationMode
    @State private var showSheet = false
    @ObservedObject var mediaItems = PickedMediaItems()
    @State var selectedVides : [AVPlayer] = []
    @StateObject var videPicker = VideoPicker()
    @StateObject var cpVM = CreatePostViewModel()
    var body: some View {
        ZStack{
            VStack{
                ScrollView(.vertical,showsIndicators: false){
                HStack{
                    ForEach(geoupDetail.user, id:\.userID){ i in
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
                }.padding(.top,30)
                    VStack{
                        Text(geoupDetail.groupDescription)
                            .foregroundColor(.white)
                        
                    }.padding(.horizontal,25)

                    
//                VStack(alignment: .center){
//                    Button {
//                        showSheet.toggle()
//                    } label: {
//                        Text("Add Video")
//                            .font(.Medium10)
//                            .foregroundColor(.white)
//                    }.frame(width: 90,height: 30)
//                        .background(LinearGradient.secondaryGradient)
//                        .cornerRadius(18)
//                        .padding(.top,15)
//                    if mediaItems.items.isEmpty{
//                        Image("videos")
//                    }else{
//                        ScrollView(.horizontal,showsIndicators: false){
//                            ZStack{
//                                HStack(spacing: 10){
//                                    ForEach(mediaItems.items.indices, id: \.self) { n in
//                                        if mediaItems.items[n].mediaType == .video {
//                                            if let url = mediaItems.items[n].url {
//                                                ZStack {
//                                                    VideoPlayer(player: AVPlayer(url: url))
//                                                        .frame(width: 60, height: 60)
//                                                    Image(systemName: "x.circle.fill")
//                                                        .font(.title3)
//                                                        .onTapGesture {
//                                                            mediaItems.deleteAt(index: n)
//                                                            mediaItems.items.remove(at: n)
//                                                        }
//                                                }.cornerRadius(10)
//                                                    .padding(.leading, 5)
//                                            }
//                                        } else { EmptyView() }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    Spacer()
//                }
//                VStack(alignment: .center){
//                    Button(action:{
//                      cpVM.createPostModel.group_id = geoupDetail.id
//                        mediaItems.items.forEach { ph in
//                            guard let videoData = try? Data(contentsOf: ph.url!) else {
//                                return
//                            }
//                            cpVM.createPostModel.video = Media(part_vedio_url: videoData, mimeType: "video/mp4", fileName: "\(arc4random()).mp4", paramName: "video")
//                        }
//                        cpVM.groupPost()
//                        
//                    }){
//                        Text("Post Video")
//                            .font(.Medium14)
//                    }.frame(width: 125, height: 41)
//                        .background(LinearGradient.secondaryGradient)
//                        .cornerRadius(60)
//                    
//                    
//                }
               
               
                Spacer()
                }.padding(.top,20)
            }
        }.sheet(isPresented: $showSheet) {
            PhotoPicker(selectionLimit: 1, filter: .any(of: [.videos]), mediaItems: mediaItems) { didSelectItem in
                // Handle didSelectItems value here...
                if didSelectItem{
                    mediaItems.items = []
                }
                print(didSelectItem)
                showSheet = false
            }
        }
//        .cropImagePicker(
//            options: [.square],
//            show: $showImage,
//            croppedImage: $selectedImage
//        )
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
                        Text(geoupDetail.groupName)
                            .font(.Regular18)
                            .foregroundColor(.white)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Image("edit")
                    
                }
        }
    }
}

//struct GroupDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupDetailView(id: "")
//    }
//}
