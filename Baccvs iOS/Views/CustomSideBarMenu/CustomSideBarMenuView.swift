//
//  CustomSideBarMenuView.swift
//  Baccvs iOS
//
//  Created by pm on 05/02/2023.
//

import SwiftUI
struct CustomSideBarMenuView: View {
    @Binding var isOpen : Bool?
   var body: some View {
        VStack {
            HStack{
                VStack(alignment: .center, spacing: 2){
                    Image("cross")
//                    Image("profileimg1")
//                        .frame(width: 56,height: 58)
//                    Text("Kathrin Down")
//                        .font(.SemiBold16)
                 }.onTapGesture {
                    isOpen = false
                }
                Spacer()
            }
            .padding()
            VStack(alignment: .leading,spacing: 25){
                ForEach(SideMenuEnum.allCases,id: \.self){  item in
                    NavigationLink(destination:moduleView(name: item)){
                        HStack(spacing:20){
                            Image(item.imageName)
                            Text(item.title)
                                .font(.SemiBold17)
                        }
                    }
                }
//                ForEach(menu, id: \.self){ user  in
//                    NavigationLink(destination:moduleView(name: user)){
//                        HStack{
//                                 Image("profileic")
//                                .frame(width: 24,height: 24)
//                            Text(user)
//                                .font(.SemiBold17)
//                        }
//                    }
//
//                }
            }.padding(.leading,39)
            .frame(maxWidth: .infinity,alignment: .leading)
           Spacer()
        }.foregroundColor(.white)
        .frame(maxWidth: 288,maxHeight: .infinity)
//        .background(Color.sidebarbg)
        .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}

struct CustomSideBarMenuView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSideBarMenuView(isOpen: .constant(true))
    }
}


@ViewBuilder
func moduleView(name: SideMenuEnum) -> some View {
    switch name {
    case .profile:
        PersonalProfileView()
    case .invites:
        InvitationView()
//    case .groupInvites :
//        GroupInvitesView()
    case .grouplikes:
        GroupLikesView()
    case .peoplelikes:
        PeopleLikesView()
    case .events:
        MyEventsView()
    case .upgrade:
       UpgradeView()
    case .settings:
       SettingView()
    case .blocked:
       BlockedAccountView()
    case .feedback:
       FeedbackView()
    case .signOut:
        ContentView()
            .onAppear{
                resetDefaults()
            }
    default:
        ReferralView()
    }
}


enum SideMenuEnum : Int, CaseIterable{
 case profile
 case invites
//  case groupInvites
 case grouplikes
 case peoplelikes
 case events
 case upgrade
 case settings
 case blocked
 case feedback
 case ReferralCode
 case signOut

 var title : String {
  switch self {
   case .profile : return "Profile"
   case .invites : return "Event Invites"
//  case  .groupInvites : return "Group Invites"
   case .grouplikes : return "Group likes"
  case  .peoplelikes : return "People likes"
   case .events : return "Events"
   case .upgrade : return "Upgrade"
   case .settings : return "Settings"
   case .blocked : return "Blocked"
   case .feedback : return "FeedBack"
   case .ReferralCode : return "Referral Code"
  case .signOut : return "Logout"

  }
 }
 var imageName : String {
  switch self {
   case .profile : return "profileic"
   case .invites : return "invitesic"
//  case .groupInvites : return "peoples"
  case  .grouplikes : return "groupic"
   case .peoplelikes : return "peopleic"
   case .events : return "eventic"
   case .upgrade : return "upgradeic"
   case .settings : return "settingic"
  case  .blocked : return "blockedic"
  case  .feedback : return "feedbackic"
  case  .ReferralCode : return "referralcodeic"
  case .signOut : return "logout"
  }
 }
}
