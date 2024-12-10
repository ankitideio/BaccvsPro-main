//
//  HomePage.swift
//  Baccvs iOS
//
//  Created by pm on 25/03/2023.
//

import SwiftUI
import RevenueCat
import SDWebImageSwiftUI
struct HomePage: View {
    @StateObject var gaVM = GetAllUsersViewModel()
    @StateObject var buVM = BlockUserViewModel()
    @State private var searchBar = ""
    @State var preselectedIndex = 0
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    TextField("",text: $searchBar)
                        .placeholder(when: searchBar.isEmpty) {
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
                VStack{
                    CustomSegmentedControl(preselectedIndex: $preselectedIndex, options: ["All Users", "Blocked","Requests"])
                        .foregroundColor(.white)
                        .font(.Regular16)
                        .padding(.horizontal,20)
                }.padding(.top,20)
                
                
                if preselectedIndex  == 0 {
                    AllUsers()
                } else if preselectedIndex == 1{
                    Blocked()
                } else if preselectedIndex == 2 {
                    Requests()
                }
            }
           
             }.navigationBarBackButtonHidden(true)
            .background(bgView())
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Image("adminlogo")
                   
                        
                }
                ToolbarItem(placement: .principal){
                             Text("BACCVS")
                            .foregroundColor(.white)
                            .font(.SemiBold20)
                }
                ToolbarItem(placement: .navigationBarTrailing){
//
                    Menu {
//
                        NavigationLink(destination: ReportedEventsPage(), label: {
                            Text("Report Events")
                                .font(.Regular14)
                        })
                        
                        NavigationLink(destination: ReferralCodePage(), label: {
                            Text("Referral")
                                .font(.Regular14)
                        })
                        NavigationLink(destination: ContentView(), label: {
                            Text("Logout")
                                .font(.Regular14)
                        })
                        HStack{
                            
                        }

                    } label: {
                        Button {
                        } label: {
                            Image("tooltipicon")
                                .foregroundColor(.white)
                        }.frame(width: 34,height: 34)
                            .cornerRadius(12)
                    }
                }
           }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}


struct AllUsers : View {
    @StateObject var gaVM = GetAllUsersViewModel()
    @StateObject var buVM = BlockUserViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        VStack{
            ScrollView(.vertical,showsIndicators: false){
                ForEach(gaVM.allUsers.body,id: \.id ){ i in
                    HStack{
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
//                        AsyncImage(url: URL(string: i.profile_image_url)) { image in
//                            image.resizable()
//                                .scaledToFill()
//                        } placeholder: {
//                            ProgressView()
//                        }.frame(width: 55,height: 55)
//                            .cornerRadius(10)
                        Text(i.name)
                            .font(.Regular14)
                            .foregroundColor(.white)
                        
                        Spacer()
                        Button(action:{
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
                    .padding(.horizontal,25)
                }.padding(.vertical,10)
            }.padding(.top,25)
        }
        
    }
}
struct Blocked : View {
    @StateObject var abVM = AllBlockUserViewModel()
    @StateObject var ubVM = UnBlockUserViewModel()

    var body: some View{
        VStack{
            ScrollView(.vertical,showsIndicators: false){
                VStack {
                    ForEach(abVM.getAllBlockUserModel.body,id: \.id) { i in
                        HStack{
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
                            
//                            AsyncImage(url: URL(string: i.profileImageURL)) { image in
//                                image.resizable()
//                                    .scaledToFill()
//                            } placeholder: {
//                                ProgressView()
//                            }.frame(width: 55,height: 55)
//                                .cornerRadius(18)
                            VStack{
                                Text(i.name)
                                    .foregroundColor(.white)
                                    .font(.SemiBold14)
                            }.padding(.leading,12)
                            
                            Spacer()
                            Button(action:{
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
                        
                    }
                    .padding(.vertical,10)
                }
            }.padding(.top,25)
        }
        
    }
}
struct Requests : View {
    @StateObject var gaVM = GetAllUsersViewModel()
    @StateObject var isVM =   IsUnlimitedViewModel()
  
    var body: some View {
        VStack{
            ScrollView(.vertical,showsIndicators: false){
                ForEach(gaVM.allUsers.body,id: \.id ){ i in
                    HStack{
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
                        
//                        AsyncImage(url: URL(string: i.profile_image_url)) { image in
//                            image.resizable()
//                                .scaledToFill()
//                        } placeholder: {
//                            ProgressView()
//                        }.frame(width: 55,height: 55)
//                            .cornerRadius(10)
                        
                        Text(i.name)
                            .font(.Regular14)
                            .foregroundColor(.white)
                        
                        Spacer()
                        Button(action:{
                            isVM.isUnlimitedModel.user_id = i.id
                            isVM.isUnlimited()
                            
                        }){
                            Text("IsUnlimited")
                                .foregroundColor(.white)
                                .font(.Medium10)
                                .frame(maxWidth: .infinity)
                        }.frame(width: 91,height: 29)
                            .background(LinearGradient.secondaryGradient)
                            .cornerRadius(60)
                    }
                    .padding(.horizontal,25)
                }.padding(.vertical,10)
            }.padding(.top,25)
        }
    }
}
