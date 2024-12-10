//
//  NotificationView.swift
//  Baccvs iOS
//
//  Created by pm on 29/04/2023.
//

import SwiftUI
import Combine
import SDWebImage
import SDWebImageSwiftUI
struct NotificationView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var noVM = NotificationViewModel()
    var body: some View {
        VStack{
             RefreshableScrollView{
                 ForEach(noVM.getNotificationModel.body,id:\.notificationID){ i in
                     if notifecationTypes.contains(i.notificationType){
                         NavigationLink(destination: notifecationView(view: i.notificationType, id:  i.notificationPurposeId), label: {
                             HStack{
                                 AnimatedImage(url: URL(string: i.notificationImage))
                                     .resizable()
                                     .placeholder {
                                         Rectangle().foregroundColor(.gray)
                                             .frame(width: 55,height: 55)
                                             .cornerRadius(23)
                                     }.scaledToFill()
                                     .transition(.fade)
                                     .frame(width: 55,height: 55)
                                     .cornerRadius(23)
                                 Text(i.notificationMessage)
                                     .font(.Regular12)
                                     .foregroundColor(.white)
                                     .padding(.leading,25)
                             }.frame(maxWidth: .infinity,alignment: .leading)
                                 .padding(.horizontal,25)
                         })
                     }
                 }.onAppear{
                        UIRefreshControl.appearance().tintColor = UIColor.white
                    }
                }.refreshable {
                    noVM.notification()
                }
                .padding(.top,20)
           
           
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
                        Text("Notifications")
                            .foregroundColor(.white)
                            .font(.Medium20)
                    }
                }
            }
        
    }
    @ViewBuilder func notifecationView(view: String, id: String) -> some View {
        if view == "event_invitation"{
            EventDetailsPage(eventId: id)
        }else if view == "follow"{
            ProfileView(id: id)
        }
//        else if view == "group_like"{
//            EmptyView()
//        }
//        else if view == "add_user_group"{
//            EmptyView()
//        }
//        else if view == "create_group"{
//            EmptyView()
//        }
        else if view == "people_like"{
            ProfileView(id: id)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
let notifecationTypes = ["event_invitation", "follow", "people_like"]
