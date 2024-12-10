//
//  TabNavPage.swift
//  Baccvs iOS
//  Created by pm on 07/02/2023.
//  TabNavPage.swift
//  CryptoParadise
//
//  Created by pm on 01/01/2023.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI
enum Screen {
    case ContentViews
    case AddFriendsView
    case CreateEventView
    case MessagesView
    case MeetPeopleView
}
struct TabNavPage : View{
    @StateObject var cpVM = CheckProfileViewModel()
    @State var selectedColor: Color = Color.btnColor1
    @State var selectedView = "ContentViews"
    @State private var isActive = false
    @State private var isProfile = false
    @State private var isOpen : Bool? = nil
    @State private var isShowView : Bool = false
    @State var isNotifecation :  Bool = false
    @State var eventID : String = ""
    @StateObject private var vm = LocationsViewModel()
  
    var body: some View {
        TabView(selection: $selectedView){
            Group{
                ContentViews(isOpen: $isOpen, isShowView: $isShowView)
                    .tag("ContentViews")
                    .tabItem{
                        Image("homeicon")
                            .renderingMode(.template)
                            .foregroundColor(selectedColor)
                            .onTapGesture {
                                selectedColor = Color.secondarytab
                                selectedView  = "ContentViews"
                            }
                    }
                    .navigationDestination(
                                     isPresented: $isNotifecation) {
                                         EventDetailsPage(eventId: eventID)
                                     }
                    
                AddFriendsView()
                    .tag("AddFriendsView")
                    .tabItem{
                        Image("seacrchicon")
                            .renderingMode(.template)
                            .foregroundColor(selectedColor)
                            .onTapGesture {
                                selectedColor = Color.secondarytab
                                selectedView  = "AddFriendsView"
                            }
                    }
                CreateEventView()
                    .tag("CreateEventView")
                    .tabItem{
                        Image("addicon")
                            .renderingMode(.original)
                            .foregroundColor(selectedColor)
                            .onTapGesture {
                                selectedColor = Color.secondarytab
                                selectedView  = "CreateEventView"
                            }
                      
                    }
                MessagesView()
                    .tag("MessagesView")
                    .tabItem{
                        Image("chaticon")
                            .renderingMode(.template)
                            .foregroundColor(selectedColor)
                            .onTapGesture {
                                selectedColor = Color.secondarytab
                                selectedView  = "MessagesView"
                            }
                    }
                 MeetPeopleView()
                    .tag("MeetPeopleView")
                    .tabItem{
                        Image("meetpeopleicon")
                            .renderingMode(.template)
                            .foregroundColor(selectedColor)
                            .onTapGesture {
                                selectedColor = Color.secondarytab
                                selectedView  = "MeetPeopleView"
                            }
                    }
            }.toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.tabBarColor, for: .tabBar)
        }
        
        .accentColor(.btnColor1)
        .navigationBarBackButtonHidden(true)
        .background(bgView())
        .onAppear{
            UITabBar.appearance().isTranslucent = false
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.secondarytab)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                if selectedView == "ContentViews"{
//                    Image("logoo")
                        VStack{
                            AnimatedImage(url: URL(string: cpVM.checkprofileModel.body.profileImageURL))
                                .resizable()
                                .placeholder {
                                    Rectangle().foregroundColor(.gray)
                                        .frame(width: 100,height: 100)
                                        .cornerRadius(10)
                                }
                                .scaledToFill()
                                .transition(.fade)
                                .frame(width: 40,height: 45)
                                .cornerRadius(10)
                                .onTapGesture {
                                    isOpen = true
                                }
                          
                            }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){
//                tralingNavView(view: selectedView)
                if selectedView == "ContentViews"{
                    HStack(spacing:10){
                        NavigationLink(destination: NotificationView(), label: {
                            Image("bell")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width:28,height: 28)
                                .foregroundColor(.white)
                        })
                        
                        NavigationLink(destination: MapPage(), label: {
                            Image("map")
                           .frame(width: 22,height: 22)
                           .cornerRadius(8)
                        })
                          Image("Filter")
                          .frame(width: 24,height: 24)
                          .onTapGesture {
                          isShowView.toggle()
                          }
                    }
                }
            }
            ToolbarItem(placement: .principal){
                if selectedView == "ContentViews"{
                    Image("midlogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40,height: 40)
                }
                else if selectedView == "AddFriendsView"{
                       Text("Search Users")
                        .foregroundColor(.white)
                        .font(.Medium20)
                }else if selectedView == "CreateEventView"{
                    Text("Create Event")
                     .foregroundColor(.white)
                     .font(.Medium20)
             }else if selectedView == "MessagesView"{
                 Text("Messages")
                  .foregroundColor(.white)
                  .font(.Medium20)
                 
             }else if selectedView ==  "MeetPeopleView" {
                 Text("Meet People")
                  .foregroundColor(.white)
                  .font(.Medium20)
             }
            }
        }
        .environmentObject(vm)
        
    }
}
struct TabNavPage_Previews: PreviewProvider {
    static var previews: some View {
        TabNavPage(isNotifecation: false, eventID: "")
    }
}
@ViewBuilder func leadingNavView(view: String, isOpen: Bool) -> some View {
    switch view {
    case "ContentViews":
        HStack{
                
        }
    case "AddFriendsView":
        Text("Add friends")
            .foregroundColor(.white)
            .font(.Medium20)
            .padding(.horizontal,120)
        
            
    case "CreateEventView":
        Text("Create Event")
            .foregroundColor(.white)
            .font(.Medium20)
            .padding(.leading,120)
    case "MessagesView":

            Text("Messages")
            .font(.Medium20)
            .padding(.leading,120)
            .foregroundColor(.white)
     
    default:
        EmptyView()
    }
}
