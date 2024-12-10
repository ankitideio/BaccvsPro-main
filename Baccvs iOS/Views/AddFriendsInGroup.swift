//
//  AddFriendsInGroup.swift
//  Baccvs iOS
//
//  Created by pm on 22/02/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct AddFriendsInGroup: View {
    @StateObject var gaVM = GetAllUsersViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedUsers : [User]
    var usersLimit : Int
    var body: some View {
        VStack{
            HStack{
                TextField("",text: $gaVM.searchBar)
                    .foregroundColor(.white)
                    .placeholder(when: gaVM.searchBar.isEmpty) {
                        Text("search...").foregroundColor(.white)
                            .foregroundColor(.white)
                } .padding()
                .font(.Regular14)
                Button(action:{}){
                    Image("search")
                    .frame(width: 24,height: 24)
                    .padding(.trailing,24)
                }
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .background(Color.searchbg)
            .cornerRadius(24)
            .padding(.top,15)
            .padding(.horizontal,25)
            ScrollView(.vertical, showsIndicators: false){
                VStack {
                    ForEach(gaVM.filteredAllUsers, id: \.id) { i in
                                HStack{
                                    AnimatedImage(url: URL(string: i.profile_image_url))
                                        .resizable()
                                        .placeholder {
                                            Rectangle().foregroundColor(.gray)
                                                .frame(width: 55,height: 55)
                                                .cornerRadius(15)
                                        }
                                        .scaledToFill()
                                        .transition(.fade)
                                        .frame(width: 55,height: 55)
                                        .cornerRadius(18)
                                    
                                 
                                    Text(i.name)
                                            .foregroundColor(.white)
                                            .font(.SemiBold14)
                                            .padding(.leading,12)
                                   Spacer()
                                    Button(action:{
                                        if selectedUsers.contains(where: {$0.userID == i.id}){
                                            selectedUsers.removeAll(where: {$0.userID == i.id})
                                        }else{
                                            selectedUsers.append(User(userImage: i.profile_image_url, userName: i.name, userID: i.id))
                                        }
                                    }){
                                        Text(selectedUsers.contains(where: {$0.userID == i.id}) ? "Remove" : "Add")
                                    .foregroundColor(.white)
                                    .font(.Medium10)
                                    .frame(maxWidth: .infinity)
                                    }.disabled(selectedUsers.count < usersLimit ? selectedUsers.contains(where: {$0.userID == i.id}) : !selectedUsers.contains(where: {$0.userID == i.id}) )
                                    .frame(width: 91,height: 29)
                                .background(LinearGradient.secondaryGradient)
                                    .cornerRadius(60)
                                }.frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .padding(.horizontal,25)
                           
                        }
                    .padding(.vertical,10)
                }
               
            } .padding(.top,25)
              Spacer()
            
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
                    Text("Add Users")
                        .foregroundColor(.white)
                }
            }
    }
}

struct AddFriendsInGroup_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendsInGroup(selectedUsers: .constant([]), usersLimit: 0)
    }
}
