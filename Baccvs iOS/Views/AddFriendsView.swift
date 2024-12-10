//
//  AddFriendsView.swift
//  Baccvs iOS
//
//  Created by pm on 06/02/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct AddFriendsView: View {
    @State private var searchBar = ""
    @State var preselectedIndex = 0
    @StateObject var foVM = FollowerUserViewModel()
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
                VStack{
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
                                    }.frame(maxWidth: .infinity)
                                    .frame(height: 55)
                                    .padding(.horizontal,25)
                            }
                        .padding(.vertical,10)
                    }
                }.refreshable {
                    foVM.getAllUsers()
                }
//                VStack{
//                    CustomSegmentedControl(preselectedIndex: $preselectedIndex, options: ["Followers", "Following"])
//                        .foregroundColor(.white)
//                        .font(.Regular16)
//                        .padding(.horizontal,20)
//                        .onChange(of: preselectedIndex) { newValue in
//                            foVM.selection = newValue
//                        }
//                }.padding(.top,20)
//                if preselectedIndex  == 0 {
//                    FollowersView(usersArray: foVM.searchAbleUsersList, foVM: foVM)
//
//                } else if preselectedIndex == 1{
//                    FollowingView(usersArray: foVM.searchAbleUsersList, foVM: foVM)
//                }
            }
            .alert(isPresented: $foVM.showAlert) {
                getAlert(alertType: foVM.alertType, message: foVM.message)
            }
            .onTapGesture {
                      // Dismiss the keyboard when the user taps outside of the text field or keyboard
                      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                  }
            if  foVM.showProgress{
                ProgressView()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
            }
             }.navigationBarBackButtonHidden(true)
            .background(bgView())
          
    }
    
}

struct AddFriendsView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendsView()
    }
}


struct FollowersView: View {
    var usersArray : [User]
    var foVM : FollowerUserViewModel
    var body: some View {
            VStack{
                RefreshableScrollView{
                        ForEach(usersArray,id:\.userID) { i in
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
                                .frame(width: 55,height: 55)
                                .cornerRadius(18)
                                Text(i.userName)
                                    .padding(.leading,12)
                                    .foregroundColor(.white)
                                    .font(.Regular14)
                                Spacer()
                                let isFollower = foVM.followerUserModel.body.contains { $0.userID == i.userID }

                                Button(action: {
                                    if isFollower {
                                        foVM.followerUserModel.body.removeAll { $0.userID == i.userID }
                                        foVM.removeFollwerModel.user_id = i.userID
                                        print(foVM.removeFollwerModel.user_id)
                                        
//                                        usersArray.removeAll(where: {$0.userID == i.userID})
                                        foVM.removeFollwer()
                                    } else {
                                        foVM.followingModel.following = i.userID
                                        foVM.followingUser()
                                    }
                                }) {
                                    Text(buttonText(isFollower: isFollower))
                                        .foregroundColor(.white)
                                        .font(.Medium10)
                                        .frame(maxWidth: .infinity)
                                }
                                .frame(width: 91, height: 29)
                                .background(LinearGradient.secondaryGradient)
                                .cornerRadius(60)
                            
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
                        .onAppear{
                            UIRefreshControl.appearance().tintColor = UIColor.white
                        }
               
                }.refreshable {
                    foVM.follower()
                }
                .padding(.top,25)
                Spacer()
            }
            .onAppear{
                foVM.follower()
        }
    }
    func buttonText(isFollower: Bool) -> String {
        return isFollower ? "Remove" : "Follow"
    }
}

struct FollowingView: View {
    @State var usersArray : [User]
    var foVM : FollowerUserViewModel
    var body: some View {
        VStack{
            RefreshableScrollView{
                    ForEach(usersArray,id: \.userID) { i in
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
                                    Button(action:{
//                                        foVM.followingUserModel.removeAll(where: {$0.youAreFollowing.userID == i.userID})
//
//                                        foVM.unfollowModel.user_id = i.userID
//                                        foVM.unFollow()
                                    }){
                                      Text("Remove")
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
                    .onAppear{
                        UIRefreshControl.appearance().tintColor = UIColor.white
                    }
            
            }.padding(.top,25)
                .refreshable {
                    foVM.following()
                }
            Spacer()
        }.onAppear{
            foVM.following()
        }
        
    }
}
