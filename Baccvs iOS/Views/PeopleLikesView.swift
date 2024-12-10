//
//  PeopleLikesView.swift
//  Baccvs iOS
//
//  Created by pm on 11/02/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct PeopleLikesView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var preselectedIndex = 0
    var body: some View {
        VStack{
            VStack{
                CustomSegmentedControl(preselectedIndex: $preselectedIndex, options: ["Likes you", "You Like"])
                    .foregroundColor(.white)
                    .font(.Regular16)
                    .padding(.horizontal,20)
            }
            .padding(.top,20)
            
            if preselectedIndex == 0 {
                PeopleWhoLIkesYou()
            }else if  preselectedIndex == 1 {
                YouLikes()
                   
            }
           
         Spacer()
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
                        Text("Peoples")
                            .foregroundColor(.white)
                            .font(.Medium20)
                    }
                }
            }
      }
}

struct PeopleLikesView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleLikesView()
    }
}


struct PeopleWhoLIkesYou : View{
    @StateObject var lyVM = PeopleLikesYouViewModel()
    private let columns : [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    var body: some View{
        VStack{
            RefreshableScrollView{
                LazyVGrid(columns: columns){
                    ForEach(lyVM.peopleLikesYouModel.body, id:\.userID){ i in
                        NavigationLink(destination: ProfileView(id: i.userID)) {
                            VStack{
                                AnimatedImage(url: URL(string: i.userImage))
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
                                Text("\(i.userName)")
                                    .foregroundColor(.white)
                                    .font(.Regular14)
                                    .offset(y:-35)
                            }
                        }
                        
                    }
                    .onAppear{
                        UIRefreshControl.appearance().tintColor = UIColor.white
                    }
                }
            }.refreshable {
                lyVM.peopleLikes()
            }
        }.onAppear{
            lyVM.peopleLikes()
        }
    }
}
struct YouLikes : View{
    @StateObject var ylVM = GetPeopleLikeViewModel()
    private let columns : [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    var body: some View{
        VStack{
            RefreshableScrollView{
                LazyVGrid(columns: columns){
                    ForEach(ylVM.getPeopleLikeModel.body , id: \.id){ item in
                        NavigationLink(destination: ProfileView(id: item.id)){
                            VStack{
                                AnimatedImage(url: URL(string: item.profile_image_url))
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
                                Text("\(item.name)")
                                    .font(.Regular14)
                                    .foregroundColor(.white)
                                    .offset(y: -35)
                            }
                        }
                    }
                    .onAppear{
                        UIRefreshControl.appearance().tintColor = UIColor.white
                    }
                }
            }.refreshable {
                ylVM.getPeopleILike()
            }
        }.onAppear{
            ylVM.getPeopleILike()
        }
    }
}
