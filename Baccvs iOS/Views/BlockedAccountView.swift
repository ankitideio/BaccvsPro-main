//
//  BlockedAccountView.swift
//  Baccvs iOS
//
//  Created by pm on 07/02/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct BlockedAccountView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var abVM = AllBlockUserViewModel()
    @StateObject var ubVM = UnBlockUserViewModel()
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    TextField("",text: $abVM.searchBar)
                        .placeholder(when: abVM.searchBar.isEmpty) {
                            
                            Text("search").foregroundColor(.gray)
                                .foregroundColor(.white)
                        }  .padding()
                        .foregroundColor(.white)
                        .font(.Regular14)
                    if !abVM.searchBar.isEmpty {
                        Button(action: {
                            abVM.searchBar = ""
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
                        ForEach(abVM.filteredBlockUsers,id: \.id) { i in
                            HStack{
                                NavigationLink(destination: ProfileView(id: i.id), label: {
                                    AnimatedImage(url: URL(string: i.profileImageURL))
                                        .resizable()
                                        .placeholder {
                                            Rectangle().foregroundColor(.gray)
                                                .frame(width: 55,height: 55)
                                                .cornerRadius(18)
                                        }
                                        .scaledToFill()
                                        .transition(.fade)
                                        .frame(width: 55,height: 55)
                                        .cornerRadius(18)
                                })
                                
                                VStack{
                                    Text(i.name)
                                        .foregroundColor(.white)
                                        .font(.SemiBold14)
                                }.padding(.leading,12)
                                
                                Spacer()
                                Button(action:{
                                    abVM.getAllBlockUserModel.body.removeAll(where: {$0.id == i.id})
                                    ubVM.unBlockUserModel.user_id = i.id
                                    ubVM.unBlockUser()
                                }){
                                    Text("Unblock")
                                        .foregroundColor(.white)
                                        .font(.Medium10)
                                        .frame(maxWidth: .infinity)
                                }.frame(width: 91,height: 29)
                                    .background(LinearGradient.secondaryGradient)
                                    .cornerRadius(60)
                                
                            }.frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .padding(.horizontal,25)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                        }.padding(.vertical,10)
                            .onAppear{
                                UIRefreshControl.appearance().tintColor = UIColor.white
                            }
                    }.refreshable {
                        abVM.allBlockUsers()
                         }
                    .padding(.top,25)
                       
                      
                Spacer()
            }.alert(isPresented: $abVM.showAlert, content: {
                getAlert(alertType: abVM.alertType, message: abVM.message)
            })
            if abVM.showProgress{
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
                    Text("Blocked Account")
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: ListOfUsersView(), label: {
                        Image("addbtn")

                    })
                }


            }
            .onAppear{
                abVM.allBlockUsers()
//                ubVM.unBlockUser()
            }
           
    }
}

struct BlockedAccountView_Previews: PreviewProvider {
    static var previews: some View {
        BlockedAccountView()
    }
}
