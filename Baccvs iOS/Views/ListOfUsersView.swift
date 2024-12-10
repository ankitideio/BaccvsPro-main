//
//  ListOfUsersView.swift
//  Baccvs iOS
//
//  Created by pm on 10/03/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct ListOfUsersView: View {
    @StateObject var gaVM = GetAllUsersViewModel()
    @StateObject var buVM = BlockUserViewModel()
//    @ObservedObject var luVM = ListOfUsersViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    TextField("",text: $gaVM.searchBar)
                        .placeholder(when: gaVM.searchBar.isEmpty) {
                            
                            Text("search").foregroundColor(.gray)
                                .foregroundColor(.white)
                        }  .padding()
                        .foregroundColor(.white)
                        .font(.Regular14)
                    if !gaVM.searchBar.isEmpty {
                        Button(action: {
                            gaVM.searchBar = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 24)
                    } else {
                        Image("search")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 24)
                    }
                    }.frame(maxWidth: .infinity,alignment: .leading)
                    .background(Color.searchbg)
                    .cornerRadius(24)
                    .padding(.horizontal,25)
                    .padding(.top,20)
                RefreshableScrollView{
                    ForEach(gaVM.filteredAllUsers,id: \.id){ i in
                        HStack{
                            NavigationLink(destination: ProfileView( id: i.id), label: {
                                AnimatedImage(url: URL(string: i.profile_image_url))
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
                                
                            })
                            
                            Text(i.name)
                                .font(.Regular14)
                                .foregroundColor(.white)
                            
                            Spacer()
                            Button(action:{
                                gaVM.allUsers.body.removeAll(where: {$0.id == i.id})
                                buVM.blockUserModel.user_id = i.id
                                buVM.blockUser{ comp in
                                    if comp{
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }){
                                Text("Block")
                                    .foregroundColor(.white)
                                    .font(.Medium10)
                                    .frame(maxWidth: .infinity)
                            }.frame(width: 91,height: 29)
                                .background(LinearGradient.secondaryGradient)
                                .cornerRadius(60)
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }.padding(.horizontal,25)
                        .onAppear{
                            UIRefreshControl.appearance().tintColor = UIColor.white
                        }
                }.refreshable {
                    gaVM.getAllUsers()
                }
                .padding(.top,30)
                   
            }.alert(isPresented: $gaVM.showAlert, content: {
                getAlert(alertType: gaVM.alertType, message: gaVM.message)
            })
            if gaVM.showProgress{
                ProgressView()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
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
                    Text("Users")
                        .foregroundColor(.white)
                }


            }
            .onAppear{
                gaVM.getAllUsers()
            }
    }
}

struct ListOfUsersView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfUsersView()
    }
}
