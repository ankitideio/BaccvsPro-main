//
//  ReferralCodeView.swift
//  Baccvs iOS
//
//  Created by pm on 31/01/2023.
//

import SwiftUI
struct ReferralCodeView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var referralVM = CheckReferralCodeViewMode()
   
    var body: some View {
        ZStack{
            VStack{
                VStack(spacing:15){
                    Text("What’s your referral code?")
                        .font(.Medium20)
                        .foregroundColor(.white)
                    Text("Please write your referral code")
                        .font(.Regular14)
                        .foregroundColor(.lightTextColor)
                    TextField("", text: $referralVM.refferalCode.referral_code)
                        .multilineTextAlignment(.center)
                        .placeholder(when: referralVM.refferalCode.referral_code.isEmpty) {
                            Text("0000000000").foregroundColor(Color(hex: "#B5B4C8"))
                                .font(.Regular16)
                        }.foregroundColor(Color(hex: "#B5B4C8"))
                        .font(.Regular16)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width-100,height: TextFieldHeight)
                        
                        .background(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [
                                     Color(hex: "#CD3AFF").opacity(0.3),
                                        Color(hex: "#000000").opacity(1.0)
                                    ]
                                ),
                                startPoint: .top,
                                endPoint: .bottom
                            )                                    )
                        .cornerRadius(24)
                        .padding(.top,30)
                }
                
//                NavigationLink(destination: EnterPhView(reffrarlcode: referralVM.refferalCode.referral_code),isActive: $referralVM.isrefCode) {
//                }
                NavigationLink(destination: EnterPhView(reffrarlcode: referralVM.refferalCode.referral_code), isActive: $referralVM.isrefCode) {
                  
                }
           
                
               Button(action:{
                  
                }){
                    NavigationLink(destination: RefferalPhoneView(), label: {
                        Text("Continue")
                            .font(.Medium16)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    })
                   
                }.frame(width: UIScreen.main.bounds.width-60,height:65)
                    .background(
                               LinearGradient(
                                   gradient: Gradient(colors: [Color(hex: "#5F09AF"),Color(hex: "#291846")]),
                                   startPoint: UnitPoint(x: 0.9, y: 0.5),
                                   endPoint: UnitPoint(x: 0.1, y: 0.5)
                               )
                           )
                .cornerRadius(5)
                .padding(.top,60)
                .disabled(referralVM.showProgress)
               
              Spacer()
            } .padding(.top,30)
            .alert(isPresented: $referralVM.showAlert, content: {
                getAlert(alertType: referralVM.alertType, message: referralVM.message)
            })
            if  referralVM.showProgress{
                ProgressView()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
            }
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(bgView())
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Image("leftarrow")
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
}
            ToolbarItem(placement: .principal){
                VStack{
                    ProgressBar(progress: (UIScreen.main.bounds.width * 0.25) - 40)

                }
                
            }

        }
       
    }
}
    struct ReferralCodeView_Previews: PreviewProvider {
        static var previews: some View {
            ReferralCodeView()
        }
    }


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .center,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
