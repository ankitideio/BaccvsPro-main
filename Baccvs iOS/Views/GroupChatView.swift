//
//  GroupChatView.swift
//  Baccvs iOS
//
//  Created by pm on 19/05/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct GroupChatView: View {
    var groupID : String
    var groupName : String
    @StateObject var cmVm = GroupChatViewModel()
    @AppStorage ("userId") var  userId: String = String()
    @AppStorage ("userImage") var senderImage : String = String()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            ScrollView{
                ForEach(cmVm.messagesList, id: \.id) { message in
                    if message.senderId == userId{
                        HStack {
                            Spacer()
                            Text(message.text)
                                .font(.Regular12)
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.secondaryColor.opacity(0.5))
                                .cornerRadius(12)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                           }
                      }else{
                          HStack(spacing:5){
                            NavigationLink(destination: ProfileView(id: message.senderId ), label: {
                                AnimatedImage(url: URL(string: senderImage))
                                    .resizable()
                                    .placeholder {
                                        Rectangle().foregroundColor(.gray)
                                            .frame(width: 30,height: 30)
                                            .cornerRadius(12)
                                    }
                                    .scaledToFill()
                                    .transition(.fade)
                                    .frame(width: 40,height: 40)
                                            .cornerRadius(12)
                            })
                            Text(message.text)
                                .font(.Regular12)
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.secondaryColor.opacity(0.2))
                                .cornerRadius(12)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 5)
                            Spacer()
                        }
                    }
                }.rotationEffect(.degrees(180))
            }
            .rotationEffect(.degrees(180))
            HStack{
                TextField("Write Message",text: $cmVm.message.text)
                    .foregroundColor(.white)
                    .padding()
                Button(action:{
                    if cmVm.message.text != ""{
                        cmVm.addMessagesToFireBase(groupID: groupID, senderToId: userId, reciverImage: senderImage)
                    }
                    
                }){
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                }.padding(.trailing,18)
                   
            }.frame(maxWidth: .infinity,alignment: .leading)
                .background(Color.ChatTextFieldColor)
                .cornerRadius(24)
                .padding(.horizontal,25)
                .padding(.bottom,19)
            Spacer()
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .background(bgView())
            .onAppear{
                cmVm.getAllChat(groupID: groupID)
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                        Image("leftarrow")
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                   
                }
                ToolbarItem(placement: .principal){
                    VStack{
                        Text(groupName)
                            .font(.Medium14)
                            .foregroundColor(.white)
                    }
                }
//                ToolbarItem(placement: .navigationBarTrailing){
//
//
//                }

             }
    }
}

//struct GroupChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupChatView(groupID: "")
//    }
//}
