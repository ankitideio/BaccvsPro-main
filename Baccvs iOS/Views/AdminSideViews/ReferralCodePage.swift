//
//  ReferralCodePage.swift
//  Baccvs iOS
//
//  Created by pm on 25/03/2023.
//

import SwiftUI
struct ReferralCodePage: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var crVM = CreateReferralCodeViewModel()
    @StateObject var acrVM = AllUserReferralCodeViewModel()
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    Text("Warning !")
                        .foregroundColor(.btnColor1)
                        .font(.SemiBold16)
                    Text("To keep our community safe and secure, we have limited the external invites to 5 maximum.  Choose your friends wisely, if they make any trouble in our community events, both of you will be banned.")
                        .font(.Regular12)
                        .foregroundColor(.secondarytextColor)
                        .padding(.top,20)
                    
                }.padding(.top,60)
                    .padding(.horizontal,25)
                Button(action:{
                    crVM.isComplete = true
                    crVM.createReferral()
                }){
                    Text("Copy Referral Code")
                        .font(.Medium16)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }.frame(height: 65)
                    .background(LinearGradient.secondaryGradient)
                    .cornerRadius(80)
                    .padding(.horizontal,30)
                    .padding(.top,90)
                
                Text("Referral Code History")
                    .foregroundColor(.white)
                    .font(.Medium14)
                    .padding(.top,20)
                
                ScrollView(.vertical,showsIndicators: false){
                    ForEach(acrVM.allUserReferralCode.body,id: \.referralCode){ item in
                        VStack(spacing: 20){
                            HStack{
                                HStack{
                                    Text(item.referralCode)
                                        .padding()
                                        .foregroundColor(.white)
                                        
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 0)
                                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                        .foregroundColor(Color(UIColor.gray))
                                )
                                .cornerRadius(8)
                                .frame(width: 300,height: 50)
                                Button(
                                    action:{
                                        crVM.urlShare = item.referralCode
                                            crVM.share()
                                       }){
                                        Image("copy")
                                    }
                            }
                       }
                    }
                }.padding(.top,10)
                
            }.alert(isPresented: $crVM.showAlert, content: {
                getAlert(alertType: crVM.alertType, message: crVM.message)
            })
            if crVM.showProgress {
                ProgressView()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
            }
        }.frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
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
                    Text("Referral Code")
                        .foregroundColor(.white)
                }

            }
    }
}

struct ReferralCodePage_Previews: PreviewProvider {
    static var previews: some View {
        ReferralCodePage()
    }
}
