//
//  CreateGroup.swift
//  Baccvs iOS
//
//  Created by pm on 13/02/2023.
//

import SwiftUI
import Photos
import PhotosUI
import AVKit
import SDWebImageSwiftUI
struct CreateGroup: View {
    @State private var isAddMember = false
    @Environment(\.presentationMode) var presentationMode
    @State var selectedUsers : [User] = []
    @StateObject var cgVM = CreateGroupViewModel()
    var body: some View {
        ZStack{
            VStack{
                ScrollView(.vertical,showsIndicators: false){
                VStack(spacing:20){
                    TextField("", text: $cgVM.createGroupModel.group_name)
                        .placeholder(when: cgVM.createGroupModel.group_name.isEmpty) {
                            Text("Group Name").foregroundColor(.gray)
                                .font(.Regular14)
                        }.foregroundColor(.white)
                        .padding()
                        .frame(height: TextFieldHeight)
                        .background(Color.textfieldColor)
                        .cornerRadius(24)
                        .padding(.horizontal,25)
                    
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
                                ZStack{
                                    HStack(spacing: 10){
                                        ForEach(selectedUsers, id: \.userID) { n in
                                            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
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
                                                    .offset(x: 5,y: -5)
                                                    .onTapGesture {
                                                        selectedUsers.removeAll(where: {$0.userID == n.userID})
                                                    }
                                                   
                                            }
                                                
                                        }
                                    }
                                }
                            }
                        }
                        NavigationLink(destination: AddFriendsInGroup(selectedUsers: $selectedUsers, usersLimit: 4), isActive: $isAddMember){
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height:128)
                    .background(RoundedRectangle(cornerRadius:11).stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundColor(Color(UIColor.gray)))
                    .padding(.top,20)
                    
                    TextEditor(text: $cgVM.createGroupModel.group_description)
                        .font(.Regular14)
                        .frame(maxWidth: .infinity)
                        .frame(height: 162)
                        .scrollContentBackground(.hidden)
                        .background(Color.textfieldColor)
                        .foregroundColor(.white)
                        .cornerRadius(24)
                    
                }
                .padding(.top,79)
                //            NavigationLink(destination:TabNavPage(), label: {
                Button(action:{
                    cgVM.createGroupModel.add_friend = selectedUsers.map{String($0.userID)}.joined(separator: ",")
                    cgVM.createGroup()
                }){
                    Text("Create")
                        .font(.Medium16)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }.frame(height: 65)
                    .background(LinearGradient.secondaryGradient)
                    .cornerRadius(60)
                    .padding(.horizontal,25)
                    .padding(.top,70)
            }
            Spacer()
        }
        .alert(isPresented: $cgVM.showAlert, content: {
            getAlert(alertType: cgVM.alertType, message: cgVM.message)
        }) .onTapGesture {
                  // Dismiss the keyboard when the user taps outside of the text field or keyboard
                  UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
              }
        .padding(.horizontal,25)
            if  cgVM.showProgress{
                ProgressView()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
            }
           } .frame(maxWidth: .infinity,maxHeight: .infinity)
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
                        Text("Create Group")
                            .foregroundColor(.white)
                    }
                    
                }

            }
    }
}

struct CreateGroup_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroup()
    }
}

