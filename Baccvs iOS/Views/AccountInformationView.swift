//
//  AccountInformationView.swift
//  Baccvs iOS
//
//  Created by pm on 07/02/2023.
//

import SwiftUI

struct AccountInformationView: View {
    @State var userName: String = ""
    @State var usermobNo: String = ""
    @State var userEmail: String = ""
    @Environment(\.presentationMode) var presentationMode
    @StateObject var aiVM = CheckProfileViewModel()
    var body: some View {
        ZStack{
            VStack{
                ScrollView(.vertical,showsIndicators: false){
                    VStack(spacing: 40){
                        VStack(spacing:15){
                            Text("Name")
                                .font(.Bold16)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .padding(.horizontal,30)
                            HStack{
                                Image("profileic")
                                Spacer()
                                Text(aiVM.checkprofileModel.body.name)
                                    .font(.Regular14)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                Spacer()
                            }.padding(.horizontal,25)
                            VStack{
                                Divider()
                                    .background(Color.secondarytextColor)
                            }.padding(.horizontal,25)
                        }
                        VStack(spacing: 15){
                            Text("Email")
                                .font(.Bold16)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .padding(.horizontal,30)
                            HStack{
                                Image("invitesic")
                                
                                Spacer()
                                Text(aiVM.checkprofileModel.body.email)
                                    .font(.Regular14)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity,alignment: .leading)

                                Spacer()
                            }.padding(.horizontal,25)
                            VStack{
                                Divider()
                                .background(Color.secondarytextColor)
                            }.padding(.horizontal,25)
                        }
                      
                        
                    }.padding(.top,50)
                    
                    Button(action:{}){
                        Text("Logout")
                            .font(.Medium16)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }.frame(height: 65)
                        .background(LinearGradient.secondaryGradient)
                        .cornerRadius(80)
                        .padding(.horizontal,30)
                        .padding(.top,70)
                }
                .padding(.top,30)
                Spacer()
            }.alert(isPresented: $aiVM.showAlert, content: {
                getAlert(alertType: aiVM.alertType, message: aiVM.message)
            })
            if aiVM.showProgress{
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
                    Text("Account information")
                        .foregroundColor(.white)
                }

            }
            .onAppear{
                aiVM.getCheckProfile()
            }
    }
}

struct AccountInformationView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInformationView()
    }
}
