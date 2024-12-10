//
//  EditGroupView.swift
//  Baccvs iOS
//
//  Created by pm on 13/02/2023.
//

import SwiftUI
import Combine
import Photos
import PhotosUI
import AVKit
import CoreTransferable
import SDWebImageSwiftUI
struct EditGroupView: View {
    @Environment(\.presentationMode) var presentationMode
    //    @State private var groupName = ""
    //    @State private var description = ""
    @State var editGroup :  GroupOwnerDetail
    @State var selectedUsers : [User] = []
    @State var  selectedUser :[ String] = []
    @State var isAddMember : Bool = false
    @State private var showSheet = false
    @ObservedObject var mediaItems = PickedMediaItems()
    @StateObject var ugVM = UdpateGroupVeiwModel()
    @StateObject var duVM = DeleteGroupUserViewModel()
    @StateObject var upgVM =  UpdateUserGroupViewModel()
    var body: some View {
        ZStack{
            VStack{
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        TextField("", text: $editGroup.groupName)
                            .placeholder(when: editGroup.groupName.isEmpty) {
                                Text("Economy Party").foregroundColor(.gray)
                                    .font(.Regular14)
                            }.foregroundColor(.white)
                            .padding()
                            .frame(height: TextFieldHeight)
                            .background(Color.textfieldColor)
                            .cornerRadius(24)
                            .padding(.top,40)
                        NavigationLink(destination: AddFriendsInGroup(selectedUsers: $selectedUsers, usersLimit: 200), isActive: $isAddMember){
                        }
                        
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
                                    if editGroup.user.contains(where: {$0.userID == n.userID}){
                                                            // MARK: Delete Api Call
                                        duVM.deleteGroupUserModel.group_id = editGroup.id
                                        duVM.deleteGroupUserModel.friend_id = n.userID
                        selectedUsers.removeAll(where: {$0.userID == n.userID})
                                                            duVM.delGroupUser()
                                                        }else{
                                                            selectedUsers.removeAll(where: {$0.userID == n.userID})
                                                        }
                                                    }
                                            }.cornerRadius(10)
                                                .padding(.leading, 5)
                                        }
                                    }
                                }
                            }
                            
                        }.frame(maxWidth: .infinity)
                            .frame(height:128)
                            .background(RoundedRectangle(cornerRadius:11).stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                .foregroundColor(Color(UIColor.gray)))
                            .padding(.top,30)
                        
                        
                        TextEditor(text: $editGroup.groupDescription)
                            .font(.Regular14)
                            .frame(maxWidth: .infinity)
                            .frame(height: 162)
                            .padding(.top,30)
                            .scrollContentBackground(.hidden)
                            .background(Color.textfieldColor)
                            .foregroundColor(.white)
                            .cornerRadius(24)
                        
                        Button(
                            action:{
//                              selectedUsers.forEach { user in
//                                if !editGroup.user.contains(where: {$0.userID == user.userID}){
//                                        selectedUser.append(user.userID)
//                                    }
//                                }
//
//                                if !selectedUser.isEmpty{
//                                    upgVM.updateUserGroupModel.group_id   = editGroup.id
//                                    upgVM.updateUserGroupModel.friend_list = selectedUser.joined(separator: ",")
//                                }
                                if !selectedUsers.isEmpty {
                                    let newlyAddedUsers = selectedUsers.filter { user in
                                        !editGroup.user.contains(where: { $0.userID == user.userID })
                                    }
                                    
                                    if !newlyAddedUsers.isEmpty {
                                        let newlyAddedUserIDs = newlyAddedUsers.map { $0.userID }
                                        upgVM.updateUserGroupModel.group_id = editGroup.id
                                        upgVM.updateUserGroupModel.friend_list = newlyAddedUserIDs.joined(separator: ",")
                                        upgVM.UpdateUserGroup()
                                    }
                                }

                                
                                ugVM.updateGroupModel.groupID.id = editGroup.id
                                ugVM.updateGroupModel.groupData.groupName = editGroup.groupName
                                ugVM.updateGroupModel.groupData.groupDescription = editGroup.groupDescription
                                ugVM.isUpdate = true
                                ugVM.updateGroup()
                            }){
                                Text("Update Group")
                                    .font(.Medium16)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                            }.frame(height: 65)
                            .background(LinearGradient.secondaryGradient)
                            .cornerRadius(60)
                            .padding(.top,40)
                    }.alert(isPresented: $ugVM.showAlert, content: {
                        getAlert(alertType: ugVM.alertType, message: ugVM.message)
                    })
                }.frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal,25)
                
            }
            .onTapGesture {
                      // Dismiss the keyboard when the user taps outside of the text field or keyboard
                      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                  }
            if ugVM.showProgress{
                ZStack{
                    ProgressView()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.5))
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
                    Text("Please wait while the group is being updated.")
                        .foregroundColor(.white)
                        .padding(.top, 50)
                }
              }
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
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
                        Text("Edit Group")
                            .foregroundColor(.white)
                    }
                    
                }
                
            }
            .onAppear{
                 _ = editGroup.user.map({ u in
                     selectedUsers.append(User(userImage: u.userImage, userName: u.userName, userID: u.userID))
                })
            }
    }
}

//struct EditGroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditGroupView()
//    }
//}
