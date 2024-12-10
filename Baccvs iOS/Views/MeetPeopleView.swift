//
//  MeetPeopleView.swift
//  Baccvs iOS
//
//  Created by pm on 13/02/2023.

import SwiftUI
import SDWebImageSwiftUI
struct MeetPeopleView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var preselectedIndex = 0
    @StateObject var mpVM = MeetPeopleOnlineViewModel()
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    CustomSegmentedControl(preselectedIndex: $preselectedIndex, options: ["Online", "Groups"])
                        .foregroundColor(.white)
                        .font(.Regular16)
                        .padding(.horizontal,20)
                }
                .padding(.top,20)
                if preselectedIndex == 0{
                    PeopleView()
                }else if preselectedIndex == 1 {
//                    GroupView()
                    VStack{
                        Spacer()
                        Text("Coming Soon")
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                Spacer()
            }
            .alert(isPresented: $mpVM.showAlert, content: {
                getAlert(alertType: mpVM.alertType, message: mpVM.message)
            })
            if  mpVM.showProgress{
                ProgressView()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
            }
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(bgView())
            .navigationBarBackButtonHidden(true)
        }
}
struct MeetPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        MeetPeopleView()
    }
}
struct PeopleView : View{
    @StateObject var mpVM = MeetPeopleOnlineViewModel()
    @StateObject var pdVM = UserProfielDetailViewModel()
    private let columns : [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    var body: some View{
        VStack{
            RefreshableScrollView{
                LazyVGrid(columns: columns){
                    ForEach(mpVM.meetPeopleOnlineModel.body,id:\.id){ i in
                        NavigationLink(destination: ProfileView(id: i.id)) {
                            VStack{
                                AnimatedImage(url: URL(string:i.image))
                                    .resizable()
                                    .placeholder {
                                        Rectangle().foregroundColor(.gray)
                                            .frame(width: 172,height: 240)
                                            .cornerRadius(10)
                                    }
                                    .scaledToFill()
                                    .transition(.fade)
                                    .frame(width: 172,height: 240)
                                    .cornerRadius(10)
                                
                                
                                Text(i.name)
                                    .font(.Regular14)
                                    .foregroundColor(.white)
                                    .offset(y:-35)
                            }
                        }
                        
                    }
                    .onAppear{
                        UIRefreshControl.appearance().tintColor = UIColor.white
                    }
                }
            }.refreshable {
                mpVM.meetPeopleOnline()
            }
            .padding(.top,20)
        }.onAppear{
            mpVM.meetPeopleOnline()
        }
    }
}
struct GroupView : View{
    @State private var isFlame : Bool = false
    @StateObject var   agVM  =  MyGroupsViewModel()
//    @ObservedObject var   glVM   =  ResGroupLikeViewModel()
    var body: some View{
        VStack{
            RefreshableScrollView{
                ForEach(agVM.allGroupList.body,id: \.id){ item  in
                    NavigationLink(destination: GroupDetailView(geoupDetail: item)){
                        VStack{
                            HStack{
                                ForEach(item.user,id: \.userID){ i in
                                    AnimatedImage(url: URL(string: i.userImage))
                                        .resizable()
                                        .placeholder {
                                            Rectangle().foregroundColor(.gray)
                                                .frame(width: 74,height: 110)
                                                .cornerRadius(10)
                                        }.scaledToFill()
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
                                        action: {
                                            if agVM.allLikes.contains(item.id){
                                                agVM.groupLikeModel.group_id = item.id
                                                agVM.groupLikeModel.dir = false
                                                agVM.groupLike()
                                                agVM.allLikes.removeAll(where: {$0 == item.id})
                                            }else{
                                                agVM.groupLikeModel.group_id = item.id
                                                agVM.groupLikeModel.dir = true
                                                agVM.groupLike()
                                                agVM.allLikes.append(item.id)
                                            }
                                        }
                                    ) {
                                        Image(agVM.allLikes.contains(item.id) ? "flamefill" : "fire")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                    }

                                }.padding(.horizontal,25)
                            }.frame(width: 350,height: 70)
                                .background(MyCustomShape().foregroundColor(.backgroundColor))
                        }.frame(width: 350,height: 200)
                    }
                   
                } .onAppear{
                    UIRefreshControl.appearance().tintColor = UIColor.white
                    
                   
                }
            }.refreshable {
                agVM.getAllGroup()
            }
             
        }
    }
}

