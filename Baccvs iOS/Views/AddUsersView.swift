//
//  AddUsersView.swift
//  Baccvs iOS
//
//  Created by pm on 14/02/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct AddUsersView: View {
    @StateObject var ahVM = AllUserHashmiViewModel()
//    @ObservedObject var buVM = BlockUserViewModel()
    @Environment(\.presentationMode) var presentationMode
    
   var body: some View {
        VStack{
            HStack{
                TextField("",text: $ahVM.searchBar)
                    .placeholder(when: ahVM.searchBar.isEmpty) {
                        Text("search").foregroundColor(.white)
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
                VStack{
                    ForEach(ahVM.filteredAllUsers,id:\.id) { i in
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
                                        .cornerRadius(15)
                                   
                                        Text(i.name)
                                        .onAppear{
                                            print(i.name)
                                        }
                                            .foregroundColor(.white)
                                            .font(.SemiBold14)
                                            .padding(.leading,12)
                                   Spacer()
                                    Button(action:{
                                        print(i.id)
//                                        buVM.blockUserModel.user_id = i.id
//                                        buVM.blockUser()
                                    }){
                                      Text("Block")
                                            .foregroundColor(.white)
                                    .font(.Medium10)
                                    .frame(maxWidth: .infinity)
                                    }.frame(width: 91,height: 29)
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
            .onAppear{
                ahVM.allUsers()
//                buVM.blockUser()
            }
    }
}

struct AddUsersView_Previews: PreviewProvider {
    static var previews: some View {
        AddUsersView()
    }
}
