//
//  EditEventView.swift
//  Baccvs iOS
//
//  Created by pm on 16/04/2023.
import SwiftUI
import Combine
import Photos
import PhotosUI
import AVKit
import CoreTransferable
import SDWebImageSwiftUI
struct EditEventView : View {
    @StateObject var ueVM = UpdateEventViewModel()
    @StateObject var cVM = CreateEventViewModel()
    @Environment(\.presentationMode) var presentationMode
    @StateObject var videPicker = VideoPicker()
    @State var selectedLocation = "location......"
    @State var selectedVides : [AVPlayer] = []
    @State var startDate = Date.now
    @State var endDate = Date.now
    @State var selectedUsers : [User] = []
    @State var isAddMember : Bool = false
    @State private var selectedItem: [PhotosPickerItem] = []
    @State private var showSheet = false
    @State private var showImage = false
    @State private var selectedImage: UIImage? = UIImage(named: "addthumbnail")
    @ObservedObject var mediaItems = PickedMediaItems()
    @State var player : [AVPlayer] = []
    @State var selections : [String] = []
    @State var selectedUser : [String] = []
    @State var items : [String] = ["Classic","Rap","Techno","Sad","Romantic","Pop"]
    @State var pricing : [String] = ["Free", "Paid"]
    @State var eventEdit : GetPostsForUsersHomeBody
    @State var sTime : Date =  Date()
    @State var eTime : Date = Date()
    @StateObject private var playerVM = PlayerViewModel()
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                ScrollView(.vertical,showsIndicators: false){
                    VStack(spacing:20){
                        TextField("", text: $eventEdit.eventName )
                            .placeholder(when: eventEdit.eventName.isEmpty) {
                            Text("Event Name")
                            .foregroundColor(.white)
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
                                .frame(width: 195,height: TextFieldHeight)
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
                                eventEdit.isBefore.toggle()
                            }){
                                Text("Before")
                                    .font(.Regular14)
                                    .foregroundColor(eventEdit.isBefore == true ? .white :.lightTextColor)
                                    .frame(maxWidth: .infinity)
                            }.frame(width: 100,height:65)
                                .background(eventEdit.isBefore == true ? .ChatTextFieldColor : Color.textfieldColor)
                                .cornerRadius(24)
                            
                            Button(action:{
                                eventEdit.isParty.toggle()
                            }){
                                Text("Party")
                                    .font(.Regular14)
                                    .foregroundColor(eventEdit.isParty == true ? .white :Color.lightTextColor)
                                    .frame(maxWidth: .infinity)
                            }.frame(width: 100,height:65)
                                .background(cVM.createEventModel.is_party == true ? .ChatTextFieldColor : Color.textfieldColor)
                                .cornerRadius(24)
                            
                            Button(action:{
                                eventEdit.isAfter.toggle()
                            }){
                                Text("AfterParty")
                                    .font(.Regular14)
                                    .foregroundColor(eventEdit.isAfter == true ? .white :Color.lightTextColor)
                                    .frame(maxWidth: .infinity)
                            }.frame(width: 100,height:65)
                                .background(eventEdit.isAfter == true ? .ChatTextFieldColor : Color.textfieldColor)
                                .cornerRadius(24)
                        }
                        HStack{
                            DatePicker("Start Time", selection: $sTime)
                                .font(.Regular14)
                                .foregroundColor(.white)
                                .padding()
                                .accentColor(.textfieldColor)
                                .environment(\.colorScheme, .dark)
                            
                        }.background(Color.textfieldColor)
                            .cornerRadius(24)
                            .frame(maxWidth: .infinity)
                            .frame(height:58)
                        HStack{ DatePicker("End Time", selection: $eTime)
                                .font(.Regular14)
                                .foregroundColor(.white)
                                .padding()
                                .accentColor(.textfieldColor)
                                .environment(\.colorScheme, .dark)
                            
                        }.frame(maxWidth: .infinity)
                            .frame(height:58)
                            .background(Color.textfieldColor)
                            .cornerRadius(24)
                        
                        
                        TextField("", text: $eventEdit.mobileNumber)
                            .placeholder(when: eventEdit.mobileNumber.isEmpty) {
                                Text("+1(_) _ ___").foregroundColor(.white)
                                    .font(.Regular14)
                            }.foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: TextFieldHeight)
                            .background(Color.textfieldColor)
                            .cornerRadius(24)
                            .keyboardType(.numberPad)
                        TextField("", text: $eventEdit.peopleAllowed)
                            .placeholder(when: eventEdit.peopleAllowed.isEmpty) {
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
                        
                        Menu{
                            ForEach(self.items, id: \.self) { item in
                                Button {
                                    if selections.contains(  item) {
                                        selections.removeAll(where: {$0 ==  item})
                                    }
                                    else {
                                        self.selections.append( item)
                                        print(item)
                                    }
                                } label: {
                                    HStack{
                                        Text(item)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        if selections.contains(where: {$0 ==  item}) {
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
                        
                        Menu{
                            ForEach(pricing, id:\.self) { item in
                                Button {
                                    if item == "Free" {
//                                        isPad = item
                                        eventEdit.freePaid = false
                                    }else{
//                                        isPad = item
                                        eventEdit.freePaid = true
                                    }
                                } label: {
                                    Text(item)
                                }
                            }
                        } label: {
                            HStack{
                                Text(eventEdit.freePaid == true ? "Paid" : "Free")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: TextFieldHeight)
                                    .background(Color.textfieldColor)
                                    .cornerRadius(24)
                            }
                        }
                    }
                    if eventEdit.freePaid{
                        TextField("", text: $eventEdit.price)
                            .placeholder(when: eventEdit.price.isEmpty) {
                                Text("Price")
                                    .foregroundColor(.white)
                                    .font(.Regular14)
                            } .padding()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: TextFieldHeight)
                            .background(Color.textfieldColor)
                            .cornerRadius(24)
                            .keyboardType(.numberPad)
                            .padding(.top, 10)
                    }
                  VStack{
                      Button {
                          showImage.toggle()
                      } label: {
                          if selectedImage ==  UIImage(named: "addthumbnail"){
                              AnimatedImage(url: URL(string: eventEdit.tumNail))
                                  .resizable()
                                  .frame(height: 130)
                                  .cornerRadius(10)
                                  .placeholder(when: eventEdit.tumNail.isEmpty) {
                                      Rectangle().foregroundColor(.gray)
                                        .frame(height: 130)
                                        .cornerRadius(10)
                                  }
                                  .scaledToFill()
                                  .transition(.fade)
                                  .frame(maxWidth: .infinity)
                                  .frame(height: 130)
                                  .cornerRadius(10)
                                  .clipped()
                          }else{
                              Image(uiImage: selectedImage!)
                                  .resizable()
                                  .frame(height: 130)
                                  .scaledToFill()
                                  .frame(maxWidth: .infinity)
                                  
                                  .cornerRadius(10)
                                  .clipped()
                          }
                          
                      }

                  }.padding(.top, 10)
                  VStack{
                    NavigationLink(destination: AddFriendsInGroup(selectedUsers: $selectedUsers, usersLimit: 200), isActive: $isAddMember){
                    }
                    VStack(alignment: .center){
                        Button {
                            showSheet.toggle()
                        } label: {
                            Text("Add Videos")
                                .font(.Medium10)
                                .foregroundColor(.white)
                        }.frame(width: 90,height: 30)
                            .background(LinearGradient.secondaryGradient)
                            .cornerRadius(18)
                            .padding(.top,15)
                        if mediaItems.items.isEmpty{
                            Image("videos")
                        }else{
                            ScrollView(.horizontal,showsIndicators: false){
                                //                                ZStack{
                                HStack(spacing:10){
                                    ForEach(mediaItems.items.indices, id: \.self) { i in
                                        ZStack{
                                            if mediaItems.items[i].mediaType == .video {
                                                if let url = mediaItems.items[i].url {
                                                    ZStack {
                                                        VideoPlayer(player: AVPlayer(url: url))
                                                            .frame(width: 60, height: 60)
                                                        Image(systemName: "x.circle.fill")
                                                            .font(.title3)
                                                            .onTapGesture {
                                                                if eventEdit.video.contains(where: {$0.video_id == mediaItems.items[i].id}){
                                                                    ueVM.deleteVideoEventModel.event_id = eventEdit.id
                                                                    ueVM.deleteVideoEventModel.id = mediaItems.items[i].id
                                                                    mediaItems.deleteAt(index: i)
                                                                    mediaItems.items.remove(at: i)
                                                                    ueVM.deleteEventVideo(){ comp in
                                                                        if comp{
                                                                            
                                                                        }
                                                                    }
                                                                }else{
                                                                    mediaItems.deleteAt(index: i)
                                                                    mediaItems.items.remove(at: i)
                                                                }
                                                            }
                                                    }.cornerRadius(10)
                                                        .padding(.leading, 5)
                                                }
                                            } else { EmptyView() }
                                        }.cornerRadius(10)
                                            .padding(.leading,5)
                                    }
                                }
                                //                                }
                            }
                            
                            Spacer()
                        }
                    }
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
                            Image("members")
                        }else{
                            ScrollView(.horizontal,showsIndicators: false){
                                //                                ZStack{
                                HStack(spacing: 10){
                                    ForEach(selectedUsers, id: \.userID) { n in
                                        ZStack {
                                            AnimatedImage(url: URL(string: n.userImage))
                                                .resizable()
                                                .placeholder {
                                                    Rectangle().foregroundColor(.gray)
                                                        .frame(width: 55,height: 55)
                                                        .cornerRadius(10)
                                                }
                                                .scaledToFill()
                                                .transition(.fade)
                                                .frame(width: 60,height: 60)
                                                .cornerRadius(10)
                                            Image(systemName: "x.circle.fill")
                                                .font(.title3)
                                            .onTapGesture {
                                                if eventEdit.user.contains(where: {$0.userId == n.userID}){
                                                    // MARK: Delete Api Call
                                                    ueVM.deleteEventUserModel.event_id = eventEdit.id
                                                    ueVM.deleteEventUserModel.friend_id = n.userID
                                                    selectedUsers.removeAll(where: {$0.userID == n.userID})
                                                    ueVM.deleteEventUser()
                                                }else{
                                                    selectedUsers.removeAll(where: {$0.userID == n.userID})
                                                }
                                            }
                                        }.cornerRadius(10)
                                            .padding(.leading, 5)
                                    }
                                    //                                    }
                                }
                            }
                        }
                    
                   }.frame(maxWidth: .infinity)
                    .frame(height:128)
                    .background(RoundedRectangle(cornerRadius:11).stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundColor(Color(UIColor.gray)))
                    .padding(.top,20)
                    Text("Description")
                        .foregroundColor(.white)
                        .font(.Regular14)
                        .foregroundColor(.secondarytextColor)
                    TextEditor(text: $eventEdit.partyDiscripation)
                        .font(.Regular14)
                        .frame(maxWidth: .infinity)
                        .frame(height: 162)
                        .scrollContentBackground(.hidden)
                        .background(Color.textfieldColor)
                        .foregroundColor(.white)
                        .cornerRadius(24)
                    Button(action:{
//                        cVM.isCreateEvent = true
//                        cVM.createEventModel.part_vedio_url = []
//                        mediaItems.items.forEach { ph in
//                            guard let videoData = try? Data(contentsOf: ph.url!) else {
//                                return
//                            }
//                            cVM.createEventModel.part_vedio_url.append(Media(part_vedio_url: videoData, mimeType: "video/mp4", fileName: "\(arc4random()).mp4", paramName: "part_vedio_url"))
//                        }
//                        cVM.createEventModel.thum_nail = Media(part_vedio_url: selectedImage?.jpegData(compressionQuality: 0.2) ?? Data(), mimeType: "image/jpeg", fileName: "\(arc4random()).jpeg", paramName: "thum_nail")
                        // set all veriabeles
                        ueVM.isUpdate = true
                        selectedUsers.forEach { user in
                            
                            if !eventEdit.user.contains(where: {$0.userId == user.userID}){
                                selectedUser.append(user.userID)
                            }
                        }
                        ueVM.updateEventModel.id.evnetID = eventEdit.id
                        ueVM.updateEventModel.updte.price = eventEdit.price
                        ueVM.updateEventModel.updte.music = selections.joined(separator: ",")
                        ueVM.updateEventModel.updte.eventName = eventEdit.eventName
                        ueVM.updateEventModel.updte.longitude = eventEdit.longitude
                        ueVM.updateEventModel.updte.latitude = eventEdit.latitude
                        ueVM.updateEventModel.updte.isParty = eventEdit.isParty
                        ueVM.updateEventModel.updte.isBefore = eventEdit.isBefore
                        ueVM.updateEventModel.updte.isAfter = eventEdit.isAfter
                        ueVM.updateEventModel.updte.startTime = sTime.toString()
                        ueVM.updateEventModel.updte.endTime = eTime.toString()
                        ueVM.updateEventModel.updte.peopleAllowed = eventEdit.peopleAllowed
                        ueVM.updateEventModel.updte.mobileNumber = eventEdit.mobileNumber
                        ueVM.updateEventModel.updte.partyDiscripation = eventEdit.partyDiscripation
                        if selectedImage !=  UIImage(named: "addthumbnail"){
                            // update thumbnil
                            ueVM.updateEventThumbNilModel.event_id = eventEdit.id
                            ueVM.updateEventThumbNilModel.thum_nail = Media(part_vedio_url: selectedImage?.jpegData(compressionQuality: 1.0) ?? Data(), mimeType: "image/jpeg", fileName: "\(arc4random()).jpeg", paramName: "thum_nail")
//                            ueVM.updateThumbnil()
                        }else{
                            ueVM.isUpdateThumbnil = true
                        }
                        // update text
//                        ueVM.updateEvent()
                        // add new user
//                        addEventUserModel
                        if !selectedUser.isEmpty{
                            ueVM.addEventUserModel.event_id = eventEdit.id
                            ueVM.addEventUserModel.friend_list = selectedUser.joined(separator: ",")
                            ueVM.addNewUserEvent()
                        }
                        
//                        selectedUser
                        var videoCount = 0
                        var userCount = 0
                        mediaItems.items.forEach { video in
                            videoCount = videoCount + 1
                            if !eventEdit.video.contains(where: {$0.video_id == video.id}){
                                // update video
                                    guard let videoData = try? Data(contentsOf: video.url!) else {
                                        return
                                    }
                                    ueVM.addEventVideoModel.event_id = eventEdit.id
                                    ueVM.addEventVideoModel.video.append(Media(part_vedio_url: videoData, mimeType: "video/mp4", fileName: "\(arc4random()).mp4", paramName: "video"))
                                ueVM.updateVideo()
                            }
                            if videoCount == mediaItems.items.count{
                                ueVM.isUpdateVideo = true
                            }
                        }
                        ueVM.updateEvent()
//                        selectedUsers.forEach { n in
//                            userCount = userCount + 1
//                            if eventEdit.user.contains(where: {$0.userId == n.userID}){
//                                // update user
//                            }
//                            if userCount == selectedUsers.count{
//                                ueVM.isUpdateUser = true
//                            }
//                        }
                    }){
                        Text("Update Event")
                            .font(.Medium16)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }.frame(height:65)
                        .background(LinearGradient.secondaryGradient)
                        .cornerRadius(60)
                        .padding(.top,50)
                        .alert(isPresented: $ueVM.showAlert, content: {
                            getAlert(alertType: ueVM.alertType, message: ueVM.message)
                        })
                }.padding(.top,30)
            }
           
            .onTapGesture {
                      // Dismiss the keyboard when the user taps outside of the text field or keyboard
                      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                  }
//            .alert(isPresented: $ueVM.showAlert, content: {
//                getAlert(alertType: ueVM.alertType, message: ueVM.message)
//            })
            .padding(.horizontal,25)
            if cVM.showProgress{
                if ueVM.isUpdateText == true && ueVM.isUpdateText == true && ueVM.isUpdateVideo == true{
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
              }
        }.sheet(isPresented: $showSheet) {
            PhotoPicker(selectionLimit: 4, filter: .any(of: [.videos]), mediaItems: mediaItems) { didSelectItem in
              
                if didSelectItem{
//                    mediaItems.items = []
                }
                print(didSelectItem)
                showSheet = false
            }
        }.cropImagePicker(
            options: [.square],
            show: $showImage,
            croppedImage: $selectedImage
        )
//        .alert(isPresented: $cVM.showAlert, content: {
//            getAlert(alertType: cVM.alertType, message: cVM.message)
//        })
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .background(bgView())
        .onAppear{
            sTime   = eventEdit.startTime.toDate()
            eTime  = eventEdit.endTime.toDate()
            selections = eventEdit.music.capitalized.components(separatedBy: ",")
            _ = eventEdit.user.map({ user in
                selectedUsers.append(User(userImage: user.userImage, userName: user.userName, userID: user.userId))
            })
            _ = eventEdit.video.map { video in
                if !video.video_link.isEmpty{
                    print(video.video_id)
                    mediaItems.items.append(PhotoPickerModel(with: (URL(string: video.video_link)!), videoId: video.video_id))
                }
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
                Text("Edit Event")
                    .foregroundColor(.white)
            }

        }
        
    }
}
struct EditEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
    }
}
