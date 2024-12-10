//
//  MessagesView.swift
//  Baccvs iOS
//
//  Created by pm on 07/02/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct MessagesView: View {
    @StateObject var cVM = ConversationViewModel()
    @StateObject var abVM = AllBlockUserViewModel()
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    TextField("",text: $cVM.searchBar)
                        .placeholder(when: cVM.searchBar.isEmpty) {
                            Text("search").foregroundColor(.gray)
                                .foregroundColor(.white)
                        } .padding()
                        .foregroundColor(.white)
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
                .padding(.horizontal,25)
                .padding(.top,20)
                VStack{
                   RefreshableScrollView{
                       if cVM.searchAbleUsersList.isEmpty {
                                Text("No chat users available")
                                    .font(.Regular14)
                                     .foregroundColor(.white)
                                         .padding()
                       } else {
                           ForEach(cVM.searchAbleUsersList, id: \.id) { i in
                   if abVM.getAllBlockUserModel.body.contains(where: { $0.id == i.id }){
                       NavigationLink(destination: ProfileView(id: i.id ?? "" ), label: {
                           HStack{
                               AnimatedImage(url: URL(string: i.imageUrl ))
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
                               
                               VStack(alignment: .leading,spacing: 5){
                                   Text(i.userName)
                                       .foregroundColor(.white)
                                       .font(.SemiBold14)
                                   Text(i.lastText)
                                       .font(.Regular12)
                                       .foregroundColor(.secondarytextColor)
                               }.padding(.leading,12)
                               Spacer()
                               VStack{
       //                                                Image("onlinestatus")
                                   Text("\(i.timeStamp.getElapsedInterval())")
                                       .font(.Regular12)
                                       .foregroundColor(.secondarytextColor)
                               }
                           }.frame(maxWidth: .infinity)
                               .frame(height: 55)
                               .padding(.horizontal,25)
                            })
                               }else {
                                   NavigationLink(
                                       destination: ChatRoomView(senderId: i.userId, senderImage: i.imageUrl, senderName: i.userName),
                                       label: {
                                           HStack{
                                               AnimatedImage(url: URL(string: i.imageUrl))
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
                                               VStack(alignment: .leading,spacing: 5){
                                                   Text(i.userName)
                                                       .foregroundColor(.white)
                                                       .font(.SemiBold14)
                                                   Text(i.lastText)
                                                       .font(.Regular12)
                                                       .foregroundColor(.secondarytextColor)
                                               }.padding(.leading,12)
                                               Spacer()
                                               VStack{
       //                                                Image("onlinestatus")
                                                   Text("\(i.timeStamp.getElapsedInterval())")
                                                       .font(.Regular12)
                                                       .foregroundColor(.secondarytextColor)
                                               }
                                               
                                           }.frame(maxWidth: .infinity)
                                           .frame(height: 55)
                                           .padding(.horizontal,25)
                                       })
                               }
                                   }.padding(.vertical,10)
                                     .onAppear{
                                       UIRefreshControl.appearance().tintColor = UIColor.white
                                   }
                       }
                   
                   }.refreshable {
                       cVM.getAllChat()
                   }.padding(.top,25)
                }
            } .onTapGesture {
                      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                  }
            Spacer()
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .background(bgView())
            
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
