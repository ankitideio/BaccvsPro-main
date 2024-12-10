//
//  RefferalPhoneView.swift
//  Baccvs iOS
//
//  Created by IDEIO SOFT on 18/12/23.
//

import SwiftUI
struct RefferalPhoneView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var referralVM = CheckReferralCodeViewMode()
   
    var body: some View {
        ZStack{
            VStack{
                VStack(spacing:15){
                    Text("Phone number")
                        .font(.Medium20)
                        .foregroundColor(.white)
                    Text("Please insert your phone number.")
                        .font(.Regular14)
                        .foregroundColor(.lightTextColor)
                    HStack(alignment: .bottom, spacing: 10) {
                        Spacer()
                        
                        Button(action: {
                            // Your action code here
                        }) {
                            HStack(alignment: .center) {
                                Spacer()
                                Text("+33")
                                    .font(.Regular16)
                                    .foregroundColor(Color(hex: "#B5B4C8"))
                                    .frame(maxWidth: 30)

                                Image(uiImage: UIImage(named: "downArrow") ?? UIImage())
                                    .frame(alignment: .leading)
                                Spacer()
                            }
                        }
                        .frame(width: 94, height: 62)
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
                        .padding(.top, 80)
                        TextField("", text: $referralVM.refferalCode.referral_code)
                            .placeholderPhone(when: referralVM.refferalCode.referral_code.isEmpty) {
                                Text("0000000000").foregroundColor(Color(hex: "#B5B4C8"))
                                    .font(.Regular16)
                            }
                            .font(.Regular16)
                            .background(Color.clear)
                            .padding()
                            .frame(width: .infinity,height: 62)
                            
                            
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
                                        
                            .foregroundColor(Color(hex: "#B5B4C8"))
                               .cornerRadius(24)
                               .padding(.top, 50)
                               .keyboardType(.numberPad)
                        Spacer()

                    }
                    .padding(.top, -30)
                    .frame(width: UIScreen.main.bounds.width-20)
                }
                
//                NavigationLink(destination: EnterPhView(reffrarlcode: referralVM.refferalCode.referral_code),isActive: $referralVM.isrefCode) {
//                }
//                NavigationLink(destination: EnterPhView(reffrarlcode: referralVM.refferalCode.referral_code), isActive: $referralVM.isrefCode) {
//                  
//                }
           
                
               Button(action:{
//                    referralVM.referral()
                }){
                    NavigationLink(destination: OtpView(), label: {
                        Text("Continue")
                            .font(.Medium16)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    })
//                    Text("Continue")
//                        .font(.Medium16)
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
                }.frame(width: UIScreen.main.bounds.width-60,height:65)
                    .background(
                               LinearGradient(
                                   gradient: Gradient(colors: [Color(hex: "#5F09AF"),Color(hex: "#291846")]),
                                   startPoint: UnitPoint(x: 0.9, y: 0.5),
                                   endPoint: UnitPoint(x: 0.1, y: 0.5)
                               )
                           )
                .cornerRadius(5)
                .padding(.top,20)
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
                    ProgressBar(progress: (UIScreen.main.bounds.width * 0.4) - 40)

                }
                
            }

        }
       
    }
}
 
extension View {
    func placeholderPhone<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
