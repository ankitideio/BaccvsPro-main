//
//  Accept&DeclineRequestView.swift
//  Baccvs iOS
//
//  Created by pm on 06/02/2023.
//

import SwiftUI
struct Accept_DeclineRequestView: View {
    var body: some View {
        VStack{
            VStack{
                HStack{
                    VStack{
                        Divider()
                            .background(Color.white)
                    }
                }
                HStack{
                    Text("Recevied")
                        .font(.Medium16)
                        .foregroundColor(.secondaryColor)
                    Spacer()
                    Text("Sent")
                        .foregroundColor(.white)
                        .font(.Regular16)
                }.padding(.horizontal,52)
                HStack{
                    VStack{
                        Divider()
                            .background(Color.white)
                    }
                }
            }.padding(.top,15)
            
            VStack{
                ScrollView (.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(0..<14) { i in
                            NavigationLink(
                                destination: SettingView(),
                                label: {
                                    HStack{
                                       Image("userprofile")
                                            .frame(width: 55,height: 55)
                                            .cornerRadius(18)
                                        VStack{
                                            Text("Hamza Butt")
                                                .padding(.leading,12)
                                                .foregroundColor(.white)
                                                .font(.SemiBold14)
                                            Button(action:{}){
                                              Text("See Profile")
                                                    .foregroundColor(.white)
                                            .font(.Medium10)
                                            .frame(maxWidth: .infinity)
                                            }.frame(width: 81,height: 26)
                                                .background(Color.btnBackground)     .cornerRadius(60)
                                        }
                                        
                                        Spacer()
                                        VStack{
                                            Button(action:{}){
                                              Text("Accept")
                                                    .foregroundColor(.white)
                                            .font(.Medium10)
                                            .frame(maxWidth: .infinity)
                                            }.frame(width: 81,height: 26)
                                        .background(LinearGradient.secondaryGradient)
                                            .cornerRadius(60)
                                            
                                            Button(action:{}){
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
                                  
                                })
                            }
                        .padding(.vertical,10)
                    }.padding(.top,25)
                }
            }

            
           Spacer()
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .background(bgView())
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    NavigationLink(destination: TabNavPage(), label: {
                        Image("leftarrow")
                    })
  }
                ToolbarItem(placement: .principal){
                    Text("Invites")
                        .font(.Medium20)
                        .foregroundColor(.white)
                }
              
            }
    }
}

struct Accept_DeclineRequestView_Previews: PreviewProvider {
    static var previews: some View {
        Accept_DeclineRequestView()
    }
}
