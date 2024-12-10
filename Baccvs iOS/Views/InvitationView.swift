//
//  InvitationView.swift
//  Baccvs iOS
//
//  Created by pm on 07/02/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct InvitationView: View {
    @State var preselectedIndex = 0
    @State private var isOpen : Bool? = nil
    @Environment(\.presentationMode) var presentationMode
    @StateObject var ivVM = InvitationViewModel()

    var body: some View {
        ZStack{
            VStack{
                VStack{
                    CustomSegmentedControl(preselectedIndex: $preselectedIndex, options: ["Received", "Send"])
                        .foregroundColor(.white)
                        .font(.Regular16)
                        .padding(.horizontal,30)
                        .padding(.top,40)
                }
                if preselectedIndex  == 0 {
                    ReceveidInvitesView()
                    
                } else if preselectedIndex == 1{
                    SendInvitesView()
                }
            }
            .alert(isPresented: $ivVM.showAlert, content: {
                getAlert(alertType: ivVM.alertType, message: ivVM.message)
            })
            if ivVM.showProgress{
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
                    Text("Invites")
                        .font(.Medium20)
                        .foregroundColor(.white)
                }
              
            }
    }
}

struct InvitationView_Previews: PreviewProvider {
    static var previews: some View {
        InvitationView()
    }
}

struct CustomSegmentedControl: View {
    @Binding var preselectedIndex: Int
    var options: [String]
    let color = LinearGradient.secondaryGradient

    var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id:\.self) { index in
                ZStack {
                    Rectangle()
                        .fill(color.opacity(0.1))
                        Rectangle()
                        .fill(color)
                        .cornerRadius(20)
                        .padding(2)
                        .opacity(preselectedIndex == index ? 1 : 0.01)
                        .onTapGesture {
                                withAnimation(.interactiveSpring()) {
                                    preselectedIndex = index
                                }
                            }
                }
                .overlay(
                    Text(options[index])
                )
            }
        }
        .frame(height: 40)
        .cornerRadius(20)
    }
}

struct ReceveidInvitesView: View {
    @StateObject var ivVM = InvitationViewModel()
    @StateObject var aeVM = EventAcceptedViewModel()
    @StateObject var irVM = InvitationRefuseViewModel()
    @AppStorage ("userId") var  userId: String = String()
    var body: some View{
        VStack{
            RefreshableScrollView{
                ForEach(ivVM.invitationModel.body,id: \.eventID) { i in
                            HStack{
                                if i.eventOwnerID == userId{
                                    NavigationLink(destination: PersonalProfileView(), label: {
                                        AnimatedImage(url: URL(string: i.eventThumbNail))
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
                                   
                                }else {
           NavigationLink(destination: ProfileView(id: i.eventOwnerID ), label: {
                                        AnimatedImage(url: URL(string: i.eventThumbNail))
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
                                }
                               VStack(alignment: .leading){
                                    Text(i.eventName)
                                        .foregroundColor(.white)
                                        .font(.Regular14)
                                   NavigationLink(destination: EventDetailsPage(eventId: i.eventID), label: {
                                        Text("View Event")
                                             .foregroundColor(.white)
                                             .font(.Regular10)
                                             .frame(maxWidth: .infinity)
                                            .frame(width: 64,height: 26)
                                           .background(Color.btnBackground)
                                       .cornerRadius(60)
                                    })
                                       
                                  }
                              Spacer()
                                VStack{
                                    Button(action:{
                                        ivVM.invitationModel.body.removeAll(where: {$0.eventID == i.eventID})
                                        aeVM.eventAcceptedModel.event_id = i.eventID
                                        aeVM.eventAccepted()
                                    }){
                                      Text("Accept")
                                        .foregroundColor(.white)
                                    .font(.Medium10)
                                    .frame(maxWidth: .infinity)
                                    }.frame(width: 81,height: 26)
                                    .background(LinearGradient.secondaryGradient)
                                    .cornerRadius(60)
                                    Button(action:{
                                        ivVM.invitationModel.body.removeAll(where: {$0.eventID == i.eventID})
                                        irVM.invitationRefuse.event_id = i.eventID
                                        irVM.eventRefuse()
                                    }){
                                      Text("Refuse")
                                        .foregroundColor(.white)
                                    .font(.Medium10)
                                    .frame(maxWidth: .infinity)
                                    }.frame(width: 81,height: 26)
                                     .background(Color.btnBackground)
                                    .cornerRadius(60)
                                }
                              }.frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .padding(.horizontal,25)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .padding(.vertical,10)
                     }
            }.refreshable {
                ivVM.listofUsers()
            }
                    
//
                        .onAppear{
                            UIRefreshControl.appearance().tintColor = UIColor.white
                        }
                .padding(.top,40)
        }.onAppear{
            ivVM.listofUsers()

        }
    }
}


struct SendInvitesView: View {
    @StateObject var giVM = SentInvitationViewModel()
    @State private var showingSheet = false
    @State  var  users :  [UserSent] = []
    var body: some View{
        VStack{
            RefreshableScrollView{
                ForEach(giVM.sentInviteModel.body , id: \.eventID) { i in
                    HStack{
    //                            NavigationLink(destination: ProfileView(id: i.eventID), label: {
                            AnimatedImage(url: URL(string: i.eventThumnail))
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
    //                            })
                       
                        VStack(alignment: .leading){
                            Text(i.eventName)
                                .foregroundColor(.white)
                                .font(.Regular14)
                            Button(action:{
                                users = i.users
                                print(users)
                                showingSheet.toggle()
                            }){
                                    Text("View Invitations")
                                      .foregroundColor(.white)
                                  .font(.Regular12)
                                  .frame(maxWidth: .infinity)
                              
                            }.frame(width: 120,height: 30)
                            .background(Color.btnBackground)
                            .cornerRadius(60)
                        }
                      Spacer()
                      }.frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .padding(.horizontal,25)
                    .padding(.vertical,10)
                   }
                    .onAppear{
                        UIRefreshControl.appearance().tintColor = UIColor.white
                    }
            }.refreshable {
                giVM.inviteSent()
            }
            

        }.onAppear{
            giVM.inviteSent()
        }.sheet(isPresented: $showingSheet) {
            InvitationViewFriends(invitationList: users)
        }
    }
}
