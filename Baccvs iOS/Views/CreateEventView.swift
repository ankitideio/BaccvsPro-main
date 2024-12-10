//
//  CreateEventView.swift
//  Baccvs iOS
//
//  Created by pm on 07/02/2023.
//
import UIKit
import SwiftUI
import Combine
import Photos
import PhotosUI
import AVKit
import CoreTransferable
import SDWebImageSwiftUI
struct CreateEventView: View {
  
    @StateObject var cVM = CreateEventViewModel()
    @Environment(\.presentationMode) var presentationMode
    @StateObject var videPicker = VideoPicker()
    @State var selectedLocation = "location......"
    @State var selectedVides : [AVPlayer] = []
    @State  var startDate = Date()
    @State var endDate  = Date()
    @State var selectedUsers : [User] = []
    @State var isAddMember : Bool = false
    @State private var selectedItem: [PhotosPickerItem] = []
    @State private var showSheet = false
    @State private var showImage = false
    @State private var selectedImage: UIImage? = UIImage(named: "addthumbnail")
//    @ObservedObject var mediaItems = PickedMediaItems()
    @State var player : [AVPlayer] = []
    @State var selections : [String] = []
    @State var items : [String] = ["Chill","Rap","Techno","House","Jazz","Karaoke", "Afro","Raggaeton",
    "Soul","Board games","Pop","Hip Hop","Dance/Electronic",
    "Rock","Indie","R&B","K-Pop","Dancehall","Reggae","Classical",
        "Arab","Country","Punk","Funk & Disco"]
    @State var pricing : [String] = ["Free", "Paid"]
    @State var selectedPricing = ""
    @State var isPad = ""
    @State private var startTime = Date()
       @State private var endTime = Date()
    @ObservedObject var mediaItems = PickedMediaItems()
    @State private var mediaItem : [SelectedMediaYPModel] = []
    @State private var selected = false

    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                ScrollView(.vertical,showsIndicators: false){
                    VStack(spacing:20){
                        TextField("", text: $cVM.createEventModel.event_name)
                            .placeholder(when: cVM.createEventModel.event_name.isEmpty) {
                                Text("Event Name").foregroundColor(.white)
                                    .font(.Regular14)
                            }.foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: TextFieldHeight)
                            .background(Color.textfieldColor)
                            .cornerRadius(24)
                        HStack{
                            TextField("", text: $selectedLocation)
                                .placeholder(when: selectedLocation.isEmpty){
                                    Text(selectedLocation).foregroundColor(.white)
                                        .font(.Regular14)
                                }.foregroundColor(.white)
                                .padding()
                                .frame(height: TextFieldHeight)
                                .background(Color.textfieldColor)
                                .cornerRadius(24)
                            
                            NavigationLink(destination: SearchingView( selectedLocation: $selectedLocation, long: $cVM.createEventModel.longitude, lat: $cVM.createEventModel.latitude), isActive: $cVM.isAddLocation){
                                Button(action:{
                                    cVM.isAddLocation.toggle()
                                }){
                                    Text("Add")
                                        .font(.SemiBold14)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                }.frame(width: 100,height:65)
                                    .background(LinearGradient.secondaryGradient)
                                    .cornerRadius(24)
                            }
                        }
                        HStack{
                            Button(action:{
                                cVM.createEventModel.is_before.toggle()
                            }){
                                Text("Before")
                                    .font(.Regular14)
                                    .foregroundColor(cVM.createEventModel.is_before == true ? .white :.lightTextColor)
                                    .frame(maxWidth: .infinity)
                            }.frame(width: 100,height:65)
                                .background(cVM.createEventModel.is_before == true ? .black : Color.textfieldColor)
                                .cornerRadius(24)
                            
                            Button(action:{
                                cVM.createEventModel.is_party.toggle()
                            }){
                                Text("Party")
                                    .font(.Regular14)
                                    .foregroundColor(cVM.createEventModel.is_party == true ? .white :Color.lightTextColor)
                                    .frame(maxWidth: .infinity)
                            }.frame(width: 100,height:65)
                                .background(cVM.createEventModel.is_party == true ? .black : Color.textfieldColor)
                                .cornerRadius(24)
                            
                            Button(action:{
                                cVM.createEventModel.is_after.toggle()
                            }){
                                Text("AfterParty")
                                    .font(.Regular14)
                                    .foregroundColor(cVM.createEventModel.is_after == true ? .white :Color.lightTextColor)
                                    .frame(maxWidth: .infinity)
                            }.frame(width: 100,height:65)
                                .background(cVM.createEventModel.is_after == true ? .black : Color.textfieldColor)
                                .cornerRadius(24)
                        }
                        HStack{
                            DatePicker("Start Time", selection: $startDate)
                                .font(.Regular14)
                                .foregroundColor(.white)
                                .padding()
                                .accentColor(.textfieldColor)
                                .environment(\.colorScheme, .dark)

                        }.background(Color.textfieldColor)
                            .cornerRadius(24)
                            .frame(maxWidth: .infinity)
                            .frame(height:58)
                        HStack{
                            DatePicker("End Time", selection: $endDate)
//                                .datePickerStyle(.automatic)
                                .font(.Regular14)
                                .foregroundColor(.white)
                                .padding()
                                .accentColor(.textfieldColor)
                                .environment(\.colorScheme, .dark)
                        }.frame(maxWidth: .infinity)
                            .frame(height:58)
                            .background(Color.textfieldColor)
                            .cornerRadius(24)  
                        TextField("", text: $cVM.createEventModel.mobile_number)
                            .placeholder(when: cVM.createEventModel.mobile_number.isEmpty) {
                                Text("Contact Number").foregroundColor(.white)
                                    .font(.Regular14)
                            }.foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: TextFieldHeight)
                            .background(Color.textfieldColor)
                            .cornerRadius(24)
                            .keyboardType(.numberPad)
                        TextField("", text: $cVM.createEventModel.people_allowed)
                            .placeholder(when: cVM.createEventModel.people_allowed.isEmpty) {
                                Text("No of peoples allowed")
                                    .foregroundColor(.white)
                                    .font(.Regular14)
                            } .padding()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: TextFieldHeight)
                            .background(Color.textfieldColor)
                            .cornerRadius(24)
                            .keyboardType(.numberPad)
                        Menu {
                            ForEach(self.items, id: \.self) { item in
                                Button {
                                    if self.selections.contains(item) {
                                        self.selections.removeAll(where: { $0 == item })
                                    }
                                    else {
                                        self.selections.append(item)
                                        print(item)
                                    }
                                } label: {
                                    HStack{
                                        Text(item)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        if self.selections.contains(item) {
                                            Spacer()
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                       } label: {
                            Text(selections.joined(separator: ",") )
                                .placeholder(when: selections.isEmpty) {
                                    HStack{
                                        Text("Select Mood").foregroundColor(.white)
                                            .font(.Regular14)
                                        Spacer()
                                    }
                                }.foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: TextFieldHeight)
                                .background(Color.textfieldColor)
                                .cornerRadius(24)
                        }
                        Menu {
                            ForEach(pricing, id:\.self) { item in
                                Button {
                                    if item == "Free" {
                                        isPad = item
                                        cVM.createEventModel.free_paid = false
                                    }else{
                                        isPad = item
                                        cVM.createEventModel.free_paid = true
                                    }
                                } label: {
                                    Text(item)
                                }
                            }
                        } label: {
                            Text(isPad)
                                .placeholder(when: isPad == "") {
                                    HStack{
                                        Text("Free/Paid").foregroundColor(.white)
                                            .font(.Regular14)
                                        Spacer()
                                    }
                                }.foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: TextFieldHeight)
                                .background(Color.textfieldColor)
                                .cornerRadius(24)
                        }
                        if isPad == "Paid" {
                            TextField("", text: $cVM.createEventModel.price)
                                .placeholder(when: cVM.createEventModel.price.isEmpty) {
                                    Text("Enter Price").foregroundColor(.white)
                                        .font(.Regular14)
                                }.foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: TextFieldHeight)
                                .background(Color.textfieldColor)
                                .cornerRadius(24)
                                .keyboardType(.numberPad)
                        }
                    }
   
                  VStack{
                        Button(
                            action:{
                                showImage.toggle()
                            }
                        ){
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity)
                                .frame(height: 130)
                                .cornerRadius(10)
                                .clipped()
                        }
                    }.padding(.top,20)
                  VStack{
                    NavigationLink(destination: AddFriendsInGroup(selectedUsers: $selectedUsers, usersLimit: 200), isActive: $isAddMember){
                    }
                      
                      HStack{
                          VStack{
                              ScrollView(.vertical,showsIndicators: false){
                                  HStack {
                                      if mediaItem.isEmpty {
                                          VStack{
                                              Button {
                                                        selected.toggle()
                                                    } label: {
                                                        Text("Add Videos")
                                                            .font(.Medium10)
                                                            .foregroundColor(.white)
                                                    }.frame(width: 90,height: 30)
                                                        .background(LinearGradient.secondaryGradient)
                                                        .cornerRadius(18)
                                                        .padding(.top,15)
                                          }.frame(maxWidth : .infinity,alignment : .center)
                                         
                                      } else {
                                          ScrollView(.horizontal, showsIndicators : false){
                                              HStack{
                                                  ForEach(mediaItem.indices, id: \.self) { index in
                                                      ZStack {
                                                          let item = mediaItem[index]
                                                          if !item.isImage  {
                                                              if let url = item.video {
                                                                  VideoPlayer(player: AVPlayer(url: url))
                                                                      .disabled(true)
                                                                      .frame(width: 55, height: 55)
                                                                      .cornerRadius(10)
                                                                      .onAppear {
                                                                          print(url)
                                                                      }.overlay(
                                                                          Button(action: {
                                                                              mediaItem.remove(at: index)
                                                                          }) {
                                                                              Image("cross")
                                                                                  .resizable()
                                                                                  .frame(width: 20, height: 20)
                                                                                  .offset(x: 20, y: -20)
//
                                                                          }
//
                                                                      )
                                                              }
                                                          }
                                                      }
                                                  }
                                              }.padding(.leading,10)
                                             
                                          }
                                     }
                                  }.padding(.top,20)
                              }
                          }

                      }.frame(maxWidth: .infinity, alignment: .leading)
                   
//                   
                }.frame(maxWidth: .infinity)
                    .frame(height:128)
                    .background(RoundedRectangle(cornerRadius: 11).stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundColor(Color(UIColor.gray)))
                    .padding(.top,20)
                    VStack{
                        Button {
                            isAddMember.toggle()
                        } label: {
                            Text("Add Members")
                                .font(.Medium10)
                                .foregroundColor(.white)
                        }.frame(width: 90,height: 30)
                            .background(LinearGradient.secondaryGradient)
                            .cornerRadius(18)
                        if selectedUsers.isEmpty{
//                            Image("members")
                        }else{
                            ScrollView(.horizontal,showsIndicators: false){
                                ZStack{
                                    HStack(spacing: 10){
                                        ForEach(selectedUsers, id: \.userID) { n in
                                            HStack {
                                                ZStack {
                                                    AnimatedImage(url: URL(string: n.userImage))
                                                        .resizable()
                                                        .placeholder {
                                                            Rectangle()
                                                                .foregroundColor(.gray)
                                                                .frame(width: 55, height: 55)
                                                                .cornerRadius(10)
                                                        }
                                                        .scaledToFill()
                                                        .transition(.fade)
                                                        .frame(width: 55, height: 55)
                                                        .cornerRadius(10)
                                                    
                                                    Image("cross")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 20, height: 20)
                                                        .offset(x: 20, y: -20)
                                                        .onTapGesture {
                                                            selectedUsers.removeAll(where: { $0.userID == n.userID })
                                                        }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height:128)
                    .background(RoundedRectangle(cornerRadius:11).stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundColor(Color(UIColor.gray)))
                    .padding(.top,20)
                    Text("Description")
                        .foregroundColor(.white)
                        .font(.Regular14)
                        .foregroundColor(.secondarytextColor)
                    TextEditor(text: $cVM.createEventModel.party_discripation)
                        .font(.Regular14)
                        .frame(maxWidth: .infinity)
                        .frame(height: 162)
                        .scrollContentBackground(.hidden)
                        .background(Color.textfieldColor)
                        .foregroundColor(.white)
                        .cornerRadius(24)
            
                    Button(action:{
                        cVM.isCreateEvent = true
                        let image = selectedImage?.jpegData(compressionQuality: 0.2)
                        cVM.createEventModel.thum_nail = Media(part_vedio_url: image ?? Data(), mimeType: "image/jpeg", fileName: "\(arc4random()).jpeg", paramName: "thum_nail")
                        cVM.createEventModel.start_time = startDate.toString()
                        cVM.createEventModel.end_time = endDate.toString()
                        cVM.createEventModel.add_friend = selectedUsers.map{String($0.userID)}
                            .joined(separator: ",")
                        cVM.createEventModel.music = "\(selections.joined(separator: ","))"
                        cVM.createEvent()
                        
                    }){
                        Text("Create Event")
                            .font(.Medium16)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }.frame(height:65)
                        .background(LinearGradient.secondaryGradient)
                        .cornerRadius(60)
                        .padding(.top,50)
                        .onChange(of: mediaItem.first?.data){ _ in
                                  Task {
                                    mediaItem.forEach { media in
                                        if media.isImage != true{
                                            cVM.createEventModel.part_vedio_url.append( Media(part_vedio_url: (media.isImage ? media.photo?.jpegData(compressionQuality: 1.0) ?? Data() : media.data), mimeType: media.isImage ? "image/jpeg" : "video/mp4", fileName: media.isImage ? "\(arc4random()).jpeg" : "\(arc4random()).mp4", paramName: "part_vedio_url"))
                                        }
                                      }
                                  }
                              }
                       
                }.padding(.top,30)
            }
            .alert(isPresented: $cVM.showAlert, content: {
               getAlert(alertType: cVM.alertType, message: cVM.message)
           })
            .padding(.horizontal,25)
            .onTapGesture {
                      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                  }
            if cVM.showProgress{
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
        } .sheet(isPresented: $selected) {
            PhotoPickers(mediaItems: $mediaItem, maxItems: 5)
        }
        .sheet(isPresented: $showSheet) {
            PhotoPicker(selectionLimit: 4, filter: .any(of: [.videos]), mediaItems: mediaItems) { didSelectItem in
                if didSelectItem{
                    mediaItems.items = []
                }
                print(didSelectItem)
                showSheet = false
            }
        }.cropImagePicker(
            options: [.square],
            show: $showImage,
            croppedImage: $selectedImage
        )
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .background(bgView())
        
        
    }
    
}
struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
    }
}

struct Movie: Transferable {
    let url: URL
    
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { movie in
            SentTransferredFile(movie.url)
        } importing: { receivedData in
            let fileName = receivedData.file.lastPathComponent
            let copy: URL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
            
            if FileManager.default.fileExists(atPath: copy.path) {
                try FileManager.default.removeItem(at: copy)
            }
            
            try FileManager.default.copyItem(at: receivedData.file, to: copy)
            return .init(url: copy)
        }
    }
}
struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    var body: some View {
        VStack{
            Button(action: self.action) {
                HStack{
                    Text(self.title)
                        .foregroundColor(.white)
                        .font(.headline)
                    if self.isSelected {
                        Spacer()
                        Image(systemName: "checkmark")
                    }
                }
            }
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(bgView())
            .navigationBarBackButtonHidden(true)
    }
}
