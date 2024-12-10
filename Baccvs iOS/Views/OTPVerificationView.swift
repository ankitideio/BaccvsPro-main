//
//  OtpVerifecationView.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 11/02/2023.
//

import SwiftUI
struct OTPVerificationView: View {
    @StateObject var voVM  = VerifyOtpViewModel()
//    @State var otpText: String = ""
    @FocusState private var isKeyboardShowing: Bool
    var phoneNumber: String
    var reffralCode: String
//    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing: 15){
            Text("4 Digit OTP Code")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,alignment: .center)
                .padding(.top,60)
            Text("Please write your four digit verification code")
                .font(.Regular14)
                .foregroundColor(.secondarytextColor)
            
            HStack(spacing: 0){
                /// - OTP Text Boxes
                /// Change Count Based on your OTP Text Size
                ForEach(0..<4,id: \.self){index in
                    OTPTextBox(index)
                }
            }
            .background(content: {
                TextField("", text: $voVM.verifyOtpModel.code.limit(4))
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .frame(width: 1, height: 1)
                    .opacity(0.001)
                    .blendMode(.screen)
                    .focused($isKeyboardShowing)
            })
            .contentShape(Rectangle())
            /// - Opening Keyboard When Tapped
            .onTapGesture {
                isKeyboardShowing.toggle()
            }
            .padding(.bottom,20)
            .padding(.top,10)
            
          
            NavigationLink( destination: SignupView(reffralCode: reffralCode, phoneNumber: phoneNumber), isActive: $voVM.gotoOtpPage){
                 
               }
            Button(
                   action:{
                       voVM.verifyOtpModel.phone_number = phoneNumber
                       voVM.verifyOTP()
                   }
                   ){
                   Text("Continue")
                       .font(.Medium16)
                       .foregroundColor(.white)
                       .frame(maxWidth: .infinity)
               }.frame(width: 314,height:65)
               .background(LinearGradient.secondaryGradient)
               .cornerRadius(60)
               .padding(.top,80)
            
            
            
//            NavigationLink {
//                SignupView(reffralCode: reffralCode, phoneNumber: phoneNumber)
//
//            } label: {
//                Text("Confirm")
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .padding(.vertical,12)
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 62)
//                    .background(LinearGradient.primaryGradient)
//                    .cornerRadius(60)
//                    .padding(.top,100)
//                    .padding(.horizontal,30)
//            }.disableWithOpacity(voVM.verifyOtpModel.code.count < 4)
        }
        .padding(.all)
        .frame(maxHeight: .infinity,alignment: .top)
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done"){
                    
                    isKeyboardShowing.toggle()
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
            }
//            ToolbarItem(placement: .navigationBarLeading){
//                Button {
//                    
//                } label: {
//                    Image("leftarrow")
//                }
//            }

//
//                    .onTapGesture {
//                        presentationMode.wrappedValue.dismiss()
//                    }
//}
            ToolbarItem(placement: .principal){
                VStack{
                    ProgressBar(progress: (UIScreen.main.bounds.width * 0.6) - 45)
                }

            }
        }
        
            .background(bgView())
    }
    
    // MARK: OTP Text Box
    @ViewBuilder
    func OTPTextBox(_ index: Int)->some View{
        ZStack{
            if voVM.verifyOtpModel.code.count > index{
                /// - Finding Char At Index
                let startIndex = voVM.verifyOtpModel.code.startIndex
                let charIndex = voVM.verifyOtpModel.code.index(startIndex, offsetBy: index)
                let charToString = String(voVM.verifyOtpModel.code[charIndex])
                Text(charToString)
                    .foregroundColor(.white)
            }else{
                Text(" ")
            }
        }
        .frame(width: 45, height: 45)
        .background {
            /// - Highlighting Current Active Box
            let status = (isKeyboardShowing && voVM.verifyOtpModel.code.count == index)
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(status ? Color.white : Color.white,lineWidth: status ? 1 : 0.5)
                /// - Adding Animation
                .animation(.easeInOut(duration: 0.2), value: isKeyboardShowing)
        }
        .frame(maxWidth: .infinity)
    }
}
struct OTPVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: View Extensions
extension View{
    func disableWithOpacity(_ condition: Bool)->some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
}

// MARK: Binding <String> Extension
extension Binding where Value == String{
    func limit(_ length: Int)->Self{
        if self.wrappedValue.count > length{
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}
