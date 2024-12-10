//
//  SettingView.swift
//  Baccvs iOS
//
//  Created by pm on 06/02/2023.
//

import SwiftUI
struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode
  
    var body: some View {
        VStack{
           Text("See information about your account, download an archive of your data, or learn about your account deactivation options.")
                .padding(.top,30)
                .font(.Regular12)
                .foregroundColor(.secondarytextColor)
                .padding(.horizontal,25)
            VStack(spacing:10){
                NavigationLink(destination: AccountInformationView(), label: {
                    HStack{
                        Image("profileSetting")
                            .frame(width: 24,height: 24)
                        VStack{
                            Text("Account information")
                                .foregroundColor(.white)
                                .font(.Medium16)
                            Text("See your account information like your phone number and email address")
                                .font(.Regular12)
                                .foregroundColor(.secondarytextColor)
                        }
                        .padding(.horizontal,12)
                        Image("rightarrow")
                            .frame(width: 24,height: 24)
                    }.frame(maxWidth: .infinity)
                        .frame(height: 98)
                        .padding(.horizontal,37)
                })
               
                NavigationLink(destination: ChangePasswordView(), label: {
                    HStack{
                        Image("locksetting")
                            .frame(width: 24,height: 24)
                        VStack{
                            Text("Change your password")
                                .foregroundColor(.white)
                                .font(.Medium16)
                            Text("Change your password at any time")
                                .font(.Regular12)
                                .foregroundColor(.secondarytextColor)
                        }
                        .padding(.horizontal,12)
                        Image("rightarrow")
                            .frame(width: 24,height: 24)
                    }.frame(maxWidth: .infinity)
                        .frame(height: 98)
                        .padding(.horizontal,37)
                })
               
                NavigationLink(destination: DeactivateAccount(), label: {
                    HStack{
                        Image("deactivatesetting")
                            .frame(width: 24,height: 24)
                        VStack{
                            Text("Deactivate your account")
                                .foregroundColor(.white)
                                .font(.Medium16)
                            Text("Find out how you can deactivate your account")
                                .font(.Regular12)
                                .foregroundColor(.secondarytextColor)
                        }
                        .padding(.horizontal,12)
                        Image("rightarrow")
                            .frame(width: 24,height: 24)
                    }.frame(maxWidth: .infinity)
                        .frame(height: 98)
                        .padding(.horizontal,37)
                })
                NavigationLink(destination: DeleteAccount(), label: {
                    HStack{
                        Image(systemName: "trash")
                            .frame(width: 24,height: 24)
                            .foregroundColor(.white)
                        VStack{
                            Text("Delete account")
                                .foregroundColor(.white)
                                .font(.Medium16)
                            Text("All your personal information, settings, data and history will be permanently erased")
                                .font(.Regular12)
                                .foregroundColor(.secondarytextColor)
                        }
                        .padding(.horizontal,12)
                        Image("rightarrow")
                            .frame(width: 24,height: 24)
                    }.frame(maxWidth: .infinity)
                        .frame(height: 98)
                        .padding(.horizontal,37)
                })
                
            }
            .padding(.top,15)
               
            Spacer()
        
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
                Text("Settings")
                    .foregroundColor(.white)
            }

        }

    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
