//
//  ChatRoomView.swift
//  Baccvs iOS
//  Created by pm on 07/02/2023.
import SwiftUI
import SDWebImageSwiftUI
struct ChatRoomView: View {
    @StateObject var cmVm = ChatMessageViewModel()
    @State private var messageText = ""
    @AppStorage ("userId") var  userId: String = String()
    var senderId: String
    var senderImage : String
    var senderName : String
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
                        HStack {
                            Text(message.text)
                                .font(.Regular12)
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.secondaryColor.opacity(0.2))
                                .cornerRadius(12)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
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
                        cmVm.addMessagesToFireBase(senderToId: senderId, reciverImage: senderImage, senderUserName: senderName)
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
                cmVm.getAllChat(senderToId: senderId)
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
                        Text(senderName)
                            .font(.Medium14)
                            .foregroundColor(.white)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: ProfileView(id: senderId ), label: {
                        AnimatedImage(url: URL(string: senderImage))
                            .resizable()
                            .placeholder {
                                Rectangle().foregroundColor(.gray)
                                    .frame(width: 40,height: 40)
                                            .cornerRadius(12)
                            }
                            .scaledToFill()
                            .transition(.fade)
                            .frame(width: 40,height: 40)
                                    .cornerRadius(12)
                    })
                }
             }
        }
    }

//struct ChatRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatRoomView()
//    }
//}
