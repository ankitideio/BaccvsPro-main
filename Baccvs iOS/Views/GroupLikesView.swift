//
//  GroupLikesView.swift
//  Baccvs iOS
//
//  Created by pm on 11/02/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct GroupLikesView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var preselectedIndex = 0
    @StateObject var glVM = GetMyGroupViewModel()
    @StateObject var   agVM  =  MyGroupsViewModel()
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    CustomSegmentedControl(preselectedIndex: $preselectedIndex, options: ["Likes you", "You Like"])
                        .foregroundColor(.white)
                        .font(.Regular16)
                        .padding(.horizontal,20)
                }.padding(.top,20)
                if preselectedIndex == 0{
                    WhoLikesYou()
                }else if preselectedIndex == 1{
                    YouLike()
                }
                Spacer()
            }.alert(isPresented: $agVM.showAlert, content: {
                getAlert(alertType: agVM.alertType, message: agVM.message)
            })
            if agVM.showProgress {
                ProgressView()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
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
                        Text("Groups")
                            .foregroundColor(.white)
                            .font(.Medium20)
                        
                    }
                }
            }
    }
}

struct GroupLikesView_Previews: PreviewProvider {
    static var previews: some View {
        GroupLikesView()
    }
}

struct WhoLikesYou : View{
    @State private var isFlame : Bool = false
    @StateObject var glVM = GetMyGroupViewModel()
    @State  var  users : [UserDetail] =  []
    @State private var showingSheet = false
    var body: some View {
        VStack{
            RefreshableScrollView{
                ForEach(glVM.getMyGroupModel.body,id: \.id){ item  in
                              VStack{
                                  HStack{
                                      ForEach(item.user,id: \.userID){ i in
                                          AnimatedImage(url: URL(string: i.userImage))
                                              .resizable()
                                              .placeholder {
                                                  Rectangle().foregroundColor(.gray)
                                                      .frame(width: 74,height: 110)
                                                      .cornerRadius(10)
                                              }
                                              .scaledToFill()
                                              .transition(.fade)
                                              .frame(width: 74,height: 110)
                                              .cornerRadius(10)
                                      }
                                  }
                                  .padding(.top,50)
                                  Spacer()
                                  VStack{
                                      HStack{
                                          Image("info")
                                          
                                          Spacer()
                                          Text(item.groupName)
                                              .foregroundColor(.white)
                                          Spacer()
                                          Button(
                                              action:{
                                                      users = item.userLikeGroup
                                                          showingSheet.toggle()
                                                                              }){
                                                              Text("View Likes")
                                                              .foregroundColor(.white)
                                                              .font(.Regular10)
                                                                                  }.frame(width: 86,height: 32)
                                          .background(LinearGradient.secondaryGradient)
                                              .cornerRadius(20)
                                      }.padding(.horizontal,25)
                                  }.frame(width: 350,height: 70)
                                      .background(MyCustomShape().foregroundColor(.backgroundColor))
                              }.frame(width: 350,height: 200)
                    
                             
                        
                          }
                            .onAppear{
                                      UIRefreshControl.appearance().tintColor = UIColor.white
                                  }
                      }.refreshable {
                      glVM.myGroups()
                  }
                  
            
            }.sheet(isPresented: $showingSheet) {
            ListLikesOfGroupView(userLikeGroup: users)
        }
    }
}
struct YouLike : View {
    @StateObject var gylVM = GroupsLikeYouViewModel()
    var body: some View {
                 VStack{
                     RefreshableScrollView{
                         ForEach(gylVM.getGroupslikeYou.body,id: \.id){ item  in
                          NavigationLink(destination: YouLikeGroupDetailView( groupdetail: item), label: {
                                 VStack{
                                   HStack{
                                              ForEach(item.user,id: \.userID){ i in
                                                  AnimatedImage(url: URL(string: i.userImage))
                                                      .resizable()
                                                      .placeholder {
                                                          Rectangle().foregroundColor(.gray)
                                                              .frame(width: 74,height: 110)
                                                              .cornerRadius(10)
                                                      }
                                                      .scaledToFill()
                                                      .transition(.fade)
                                                      .frame(width: 74,height: 110)
                                                      .cornerRadius(10)
                                              }
                                          }
                                          .padding(.top,50)
                                          Spacer()
                                          VStack{
                                              HStack{
                                                  Image("info")
                                                  
                                                  Spacer()
                                                  Text(item.groupName)
                                                      .foregroundColor(.white)
                                                 Spacer()
                                                  //                                         Image("fire")
                                                  //                                    Button(action: {
                                                  //                                        isFlame.toggle()
                                                  //                                    }, label: {
                                                  //                                        Image(self.isFlame ?  "flamefill" : "fire")
                                                  //                                    })
                                              }.padding(.horizontal,25)
                                              
                                          }.frame(width: 350,height: 70)
                                              .background(MyCustomShape().foregroundColor(.backgroundColor))
                                      }.frame(width: 350,height: 200)
                             })
                          .listRowBackground(Color.clear)
                          .listRowSeparator(.hidden)
                           }
                         .onAppear{
                                   UIRefreshControl.appearance().tintColor = UIColor.white
                               }
                     }.refreshable {
                          gylVM.groupsLikeYou()
                    }
            }
    }
}

