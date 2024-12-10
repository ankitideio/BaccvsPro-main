//
//  SignInWithPhoneView.swift
//  Baccvs iOS
//
//  Created by pm on 01/02/2023.
import SwiftUI
struct SignInWithPhoneView: View {
    @State private var phNo = ""
    @State private var isContinue = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
        VStack{
            Text("What’s your phone number?")
                .font(.Medium20)
                .foregroundColor(.white)
                .padding(.top,47)
            Text("Please write your phone number for verification code")
                .multilineTextAlignment(.center)
                .font(.Regular14)
                .foregroundColor(.lightTextColor)
                .padding(.top,15)
                .padding(.horizontal,25)
            
            TextField("", text: $phNo)
                .placeholder(when: phNo.isEmpty) {
                    Text("+1(____________)").foregroundColor(.gray)
                        .font(.Regular14)
            }.foregroundColor(.lightTextColor)
                .padding()
                .frame(width: 316,height: TextFieldHeight)
                .background(Color.textfieldColor)
                .cornerRadius(24)
                .padding(.top,60)
            
            NavigationLink(destination: OtpView(), label: {
                Text("confirm")
                    .font(.Medium16)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }).frame(width: 314,height:65)
                .background(LinearGradient.secondaryGradient)
                .cornerRadius(60)
                .padding(.top,120)
                
        }
        .frame(maxWidth: .infinity,alignment: .center)
        Spacer()
        }.background(bgView())
        .frame(maxWidth: .infinity,maxHeight: .infinity)
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
                   Text("Sign in ")
                        .foregroundColor(.white)
                        .font(.Medium20)
                }
                
            }

        }
    }
}
    struct SignInWithPhoneView_Previews: PreviewProvider {
        static var previews: some View {
            SignInWithPhoneView()
        }
    }
