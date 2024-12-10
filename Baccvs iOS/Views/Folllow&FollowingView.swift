//
//  Folllow&FollowingView.swift
//  Baccvs iOS
//
//  Created by pm on 07/02/2023.
//

import SwiftUI

struct Folllow_FollowingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var preselectedIndex = 0
    var body: some View {
        VStack{
            VStack{
                CustomSegmentedControl(preselectedIndex: $preselectedIndex, options: ["Followers", "Following"])
                    .foregroundColor(.white)
                    .font(.Regular16)
                    .padding(.horizontal,20)
            }
           
            if preselectedIndex == 0 {
                Followers()
            }else if preselectedIndex == 1 {
                Following()
            }
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
            }
    }
}

struct Folllow_FollowingView_Previews: PreviewProvider {
    static var previews: some View {
        Folllow_FollowingView()
    }
}


struct  Followers : View{
    var body: some View{
        VStack{
            ScrollView (.vertical, showsIndicators: false){
                VStack {
                    ForEach(0..<14) { i in
                                HStack{
                                   Image("userprofile")
                                        .frame(width: 55,height: 55)
                                        .cornerRadius(18)
                                    VStack(alignment:.leading,spacing: 5){
                                        Text("Ronaldo")
                                            .padding(.leading,12)
                                            .foregroundColor(.white)
                                            .font(.Regular14)
                                        Text("X invited you to his")
                                            .font(.Regular12)
                                            .foregroundColor(.white)
                                    }
                                   
                                    Spacer()
                                    Button(action:{}){
                                      Text("Delete")
                                            .foregroundColor(.white)
                                    .font(.Medium10)
                                    .frame(maxWidth: .infinity)
                                    }.frame(width: 91,height: 29)
                                .background(LinearGradient.secondaryGradient)
                                    .cornerRadius(60)
                                    
                                }.frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .padding(.horizontal,25)
                           
                        }
                    .padding(.vertical,10)
                }.padding(.top,25)
            }
        }
    }
}
struct  Following : View{
    var body: some View{
        VStack{
            ScrollView (.vertical, showsIndicators: false){
                VStack {
                    ForEach(0..<14) { i in
                                HStack{
                                   Image("userprofile")
                                        .frame(width: 55,height: 55)
                                        .cornerRadius(18)
                                    VStack(alignment:.leading,spacing: 5){
                                        Text("Ronaldo")
                                            .padding(.leading,12)
                                            .foregroundColor(.white)
                                            .font(.Regular14)
                                        Text("X invited you to his")
                                            .font(.Regular12)
                                            .foregroundColor(.white)
                                    }
                                   
                                    Spacer()
                                    Button(action:{}){
                                      Text("Following")
                                            .foregroundColor(.white)
                                    .font(.Medium10)
                                    .frame(maxWidth: .infinity)
                                    }.frame(width: 91,height: 29)
                                .background(LinearGradient.secondaryGradient)
                                    .cornerRadius(60)
                                    
                                }.frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .padding(.horizontal,25)
                           
                        }
                    .padding(.vertical,10)
                }.padding(.top,25)
            }
        }
    }
}

