//
//  MyGroupsView.swift
//  Baccvs iOS
//
//  Created by pm on 13/02/2023.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine
struct MyGroupsView: View {
    @Environment(\.presentationMode) var presentationMode
//    @StateObject var agVM = MyGroupsViewModel()
    @StateObject var mgVM =  GetMyGroupViewModel()
    @StateObject var dgVM =  DeleteGroupViewModel()
    @StateObject var lgVM = LeaveUserViewModel()
    @AppStorage ("userId") var  userId : String = String()
    @State  var showalert : Bool =  false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var body: some View {
        ZStack{
            RefreshableScrollView{
                ForEach(mgVM.getMyGroupModel.body,id: \.id){ item  in
                       VStack{
                           NavigationLink(destination: MyGroupDetailView(  editGroup: item ), label: {
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
                           })

                           
                            Spacer()
                            VStack{
                                HStack{
                                    Image("info")
                                    Spacer()
                                    Text(item.groupName)
                                        .foregroundColor(.white)
                                    Spacer()

                                    VStack{
                                        if item.groupOwnerId == userId {
                                        Menu {
                                            NavigationLink(destination: EditGroupView(editGroup: item), label: {
                                                Text("Edit Group")
                                                    .foregroundColor(.black)
                                                    .font(.Regular14)
                                            })
                                            Button(action:{
//                                                dgVM.deleteGroupModel.id = item.id
//                                                showalert.toggle()
                                                dgVM.deleteGroupModel.id = item.id
                                                alertTitle = "Delete"
                                                alertMessage = "Would You Like to Delete this Group"
                                                showAlert = true
                                                
                                                
                                            }){
                                                Text("Delete Group")
                                                    .foregroundColor(.black)
                                                    .font(.Regular14)
                                            }
                                        } label: {
                                            Button{
                                               
                                            } label: {
                                                Image("editicon")

                                            }.frame(width: 34,height: 34)
                                                .background(Color.btnColorbg)
                                                .cornerRadius(23)
                                        }
//                                        .alert(isPresented: $showalert,content:{
//                                                Alert(
//                                                    title: Text("Delete"), message: Text("Would You Like to Delete this Group"), primaryButton: .destructive(Text("Delete"),action:{
//                                   mgVM.getMyGroupModel.body.removeAll(where:{$0.id == item.id})
//                                                        dgVM.delGroup()
//                                                    }), secondaryButton: .cancel()
//                                                )
//                                            })
                                        } else {
                                            Button {
                                                lgVM.leaveUserModel.group_id = item.id
                                                lgVM.leaveUserModel.friend_id = userId
//                                                showalert.toggle()
                                                alertTitle = "leave"
                                                alertMessage = "Would You leave this Group"
                                                showAlert = true
                                            } label: {
                                                Image("leavegroupicon")
                                            }.frame(width: 34,height: 34)
                                                .background(Color.btnColorbg)
                                                .cornerRadius(23)

                                        }
                                    }.alert(isPresented: $showAlert) {
                                        Alert(
                                            title: Text(alertTitle),
                                            message: Text(alertMessage),
                                            primaryButton: .destructive(Text(alertTitle), action: {
                                                if alertTitle == "Delete" {
                                mgVM.getMyGroupModel.body.removeAll(where:{$0.id == item.id})
                                                    dgVM.delGroup()
                                                   
                                                } else if alertTitle == "leave" {
                mgVM.getMyGroupModel.body.removeAll(where:{$0.id ==  lgVM.leaveUserModel.group_id})
                                                        lgVM.leaveGroup()
                                                }
                                            }),
                                            secondaryButton: .cancel()
                                        )
                                    }
//                                    .alert(isPresented: $showalert,content:{
//                                        Alert(
//                                            title: Text("Leave"), message: Text("Would You Like to Leave this Group"), primaryButton: .destructive(Text("Remove"),action:{
//
//          mgVM.getMyGroupModel.body.removeAll(where:{$0.id ==  lgVM.leaveUserModel.group_id})
//                                                lgVM.leaveGroup()
//                                            }), secondaryButton: .cancel()
//                                        )
//                                    })
        
                            }.padding(.horizontal,25)
                            }.frame(width: 350,height: 70)
                                .background(MyCustomShape().foregroundColor(.backgroundColor))
                        }.frame(width: 350,height: 200)
//                    })
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }.padding(.top,20)
                    .onAppear{
                        UIRefreshControl.appearance().tintColor = UIColor.white
                    }
            }.refreshable {
                    mgVM.myGroups()
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
                    VStack{
                        Text("My Groups")
                            .foregroundColor(.white)
                    }
                    
                }
            }.onAppear{
                mgVM.myGroups()
            }
    }
}

struct MyGroupsView_Previews: PreviewProvider {
    static var previews: some View {
        MyGroupsView()
    }
}
