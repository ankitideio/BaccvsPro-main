//
//  FollowersPageView.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 22/07/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct FollowersPageView: View {
    @State private var searchBar = ""
    @Environment(\.presentationMode) var presentationMode
    @StateObject var foVM = FollowersViewModel()
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    TextField("",text: $foVM.searchBar)
                        .foregroundColor(.white)
                        .placeholder(when: foVM.searchBar.isEmpty) {
                            Text("Search User").foregroundColor(.white)
                                .foregroundColor(.white)
                        } .padding()
                        .font(.Regular14)
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .background(Color.searchbg)
                .cornerRadius(24)
                .padding(.top,15)
                .padding(.horizontal,25)
                RefreshableScrollView{
                    ForEach(foVM.searchAbleUsersList,id: \.userID) { i in
                                HStack{
                                    NavigationLink {
                                        ProfileView(id: i.userID)
                                    } label: {
                                        AnimatedImage(url: URL(string: i.userImage))
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
                                    }
                                    VStack(alignment:.leading,spacing: 5){
                                        Text(i.userName)
                                            .padding(.leading,12)
                                            .foregroundColor(.white)
                                            .font(.Regular14)
                                       }
                                   
                                    Spacer()
                                    Button(action: {
                                        if foVM.followerUserModel.body.contains(where: { $0.userID == i.userID }) {
                                            foVM.followerUserModel.body.removeAll(where: { $0.userID == i.userID })
                                            foVM.removeFollwerModel.user_id = i.userID
                                            print(foVM.removeFollwerModel.user_id)
                                            foVM.removeFollwer()
                                        } else {
                                            foVM.followingModel.following = i.userID
                                            foVM.followingUser()
                                        }
                                    }) {
                                        Text(buttonText(isFollower: foVM.followerUserModel.body.contains(where: { $0.userID == i.userID })))
                                            .foregroundColor(.white)
                                            .font(.Medium10)
                                            .frame(maxWidth: .infinity)
                                    }
                                    .frame(width: 91, height: 29)
                                    .background(LinearGradient.secondaryGradient)
                                    .cornerRadius(60)

                                }.frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .padding(.horizontal,25)
                        }
                    .padding(.vertical,10)
                }.refreshable {
                    foVM.follower()
                }
            }.alert(isPresented: $foVM.showAlert, content: {
                getAlert(alertType: foVM.alertType, message: foVM.message)
            })
            if  foVM.showProgress{
                ProgressView()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
            }
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(bgView())
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Image("leftarrow")
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                ToolbarItem(placement: .principal){
                    VStack{
                        Text("Followers")
                            .foregroundColor(.white)
                            .font(.Medium20)
                    }
                }
            }
    }
    func buttonText(isFollower: Bool) -> String {
        return isFollower ? "Remove" : "Follow"
    }
    
}

struct FollowersPageView_Previews: PreviewProvider {
    static var previews: some View {
        FollowersPageView()
    }
}
