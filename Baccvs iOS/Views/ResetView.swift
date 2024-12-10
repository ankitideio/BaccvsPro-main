//
//  ResetView.swift
//  Baccvs iOS
//
//  Created by pm on 01/02/2023.
//

import SwiftUI

struct ResetView: View {
    @State private var email: String = ""
    var body: some View {
        VStack{
            Text("Reset Password")
                .font(.title2)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,alignment: .center)
                .padding(.top,40)
            Text("Please enter your email address to request a password reset")
                .foregroundColor(.white)
                .padding(.top,42)
            
            HStack{
                Image("mail")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17,height: 17)
                TextField("abc@email.com", text: $email)
                    
            }.padding()
            .frame(maxWidth: .infinity,alignment: .leading)
            .background(Color.white)
            .cornerRadius(12)
            .padding(.top,13)

            NavigationLink(destination: EnterReferralCodeView(reffralCode: "reffralCode", phoneNumber: "phoneNumber"), label: {
                Text("Continue")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }).frame(height:58)
                .background(Color.black)
                .cornerRadius(60)
                .padding(.top,44)
               
               
            
            Spacer()
        }.navigationBarBackButtonHidden(true)
            .padding(.horizontal,25)
            .background(LinearGradient.primaryGradient)
    }
}

struct ResetView_Previews: PreviewProvider {
    static var previews: some View {
        ResetView()
    }
}
