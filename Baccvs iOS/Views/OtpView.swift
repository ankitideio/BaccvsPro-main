//
//  OtpView.swift
//  Baccvs iOS
//
//  Created by pm on 01/02/2023.
//

import SwiftUI
struct OtpView: View {

    @Environment(\.presentationMode) var presentationMode
    @StateObject private var referralVM = CheckReferralCodeViewMode()
    @State private var firstDigit : String = String()
    @State private var secondDigit: String = String()
    @State private var thirdDigit: String = String()
    @State private var fourthDigit: String = String()
    
    var body: some View {
        VStack(spacing: 15){
            Text("4 Digit OTP Code")
                .font(.Regular18)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,alignment: .center)
                .padding(.top,40)
            Text("Please write your four digit verification \ncode")
                .font(.Regular14)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 270,alignment: .center)
                .foregroundColor(.gray)
                .padding(.top,0)
            HStack(spacing:25){
                
                TextField("", text: $firstDigit)
                    .placeholderOtp(when: firstDigit.isEmpty)  {
                        Text("0").foregroundColor(Color(hex: "#B5B4C8"))
                            .font(.Regular18)
                    }
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hex: "#B5B4C8"))
                    .font(.Regular18)
                    .padding()
                    .frame(width: 62,height: 62)
                
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
                        )
                        .mask(Rectangle())
                    )                    .cornerRadius(24)
                    .padding(.top,30)
                TextField("", text: $secondDigit)
                    .placeholderOtp(when: secondDigit.isEmpty) {
                        Text("0").foregroundColor(Color(hex: "#B5B4C8"))
                            .font(.Regular18)
                    }
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hex: "#B5B4C8"))
                    .font(.Regular18)
                    .padding()
                    .frame(width: 62,height: 62)
                
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
                        )
                        .mask(Rectangle())
                    )
                    .cornerRadius(24)
                    .padding(.top,30)
                TextField("", text: $thirdDigit)
                    .placeholderOtp(when: thirdDigit.isEmpty) {
                        Text("0").foregroundColor(Color(hex: "#B5B4C8"))
                            .font(.Regular14)
                    }
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hex: "#B5B4C8"))
                    .font(.Regular18)
                    .padding()
                    .frame(width: 62,height: 62)
                
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
                        )
                        .mask(Rectangle())
                    )
                    .cornerRadius(24)
                    .padding(.top,30)
                TextField("", text: $fourthDigit)
                    .placeholderOtp(when: fourthDigit.isEmpty) {
                        Text("0").foregroundColor(Color(hex: "#B5B4C8"))
                            .font(.Regular18)
                    }
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hex: "#B5B4C8"))
                    .font(.Regular18)
                    .padding()
                    .frame(width: 62,height: 62)
                
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
                        )
                        .mask(Rectangle())
                    )
                    .cornerRadius(24)
                    .padding(.top,40)
            }
            
            VStack{
                Text("Resend OTP")
                    .font(.Regular14)
                    .foregroundColor(.white)
            }.padding(.top,15)
                .frame(maxWidth: .infinity,alignment: .center)
                .offset(x: 115, y:0)
            Button(action:{
                //                    referralVM.referral()
            }){
                NavigationLink(destination: SignupDetailView(), label: {
                    Text("Continue")
                        .font(.Medium16)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                })
                //                    Text("Continue")
                //                        .font(.Medium16)
                //                        .foregroundColor(.white)
                //                        .frame(maxWidth: .infinity)
            }.frame(width: 325, height: 65)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(hex: "#5F09AF"),Color(hex: "#291846")]),
                        startPoint: UnitPoint(x: 0.9, y: 0.5),
                        endPoint: UnitPoint(x: 0.1, y: 0.5)
                    )
                )
                .cornerRadius(5)
                .padding(.top,50)
                .disabled(referralVM.showProgress)
            
            Spacer()
                .padding(.top,30)
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
                        ProgressBar(progress: (UIScreen.main.bounds.width * 0.6) - 40)
                        
                    }
                    
                }
                
            }
        
    }
 
}
extension View {
    func placeholderOtp<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .center,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
