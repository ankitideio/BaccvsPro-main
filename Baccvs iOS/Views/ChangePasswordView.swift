//
//  ChangePasswordView.swift
//  Baccvs iOS
//
//  Created by pm on 07/02/2023.
//

import SwiftUI
struct ChangePasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var upVM = UpdatePasswordViewModel()
    @AppStorage ("email") var  email: String = String()
    @State private var isPasswordVisible = false
    var body: some View {
        ZStack{
            VStack{
                VStack(spacing: 20){
                    SecureField("", text: $upVM.currentPassword)
                        .placeholder(when: upVM.currentPassword.isEmpty) {
                            Text("current Password").foregroundColor(.white)
                                .font(.Regular14)
                        }.foregroundColor(.white)
                        .padding()
                        .frame(width: 316,height: TextFieldHeight)
                        .background(Color.textfieldColor)
                        .cornerRadius(24)
                    
                    SecureField("", text: $upVM.updatePasswordModel.password)
                        .placeholder(when: upVM.updatePasswordModel.password.isEmpty) {
                            Text("Password").foregroundColor(.white)
                                .font(.Regular14)
                        }.foregroundColor(.white)
                        .padding()
                        .frame(width: 316,height:TextFieldHeight)
                        .background(Color.textfieldColor)
                        .cornerRadius(24)
                    
                    SecureField("", text: $upVM.confirmpassword)
                        .placeholder(when: upVM.confirmpassword.isEmpty) {
                            Text("confirm Password").foregroundColor(.white)
                                .font(.Regular14)
                        }.foregroundColor(.white)
                        .padding()
                        .frame(width: 316,height: TextFieldHeight)
                        .background(Color.textfieldColor)
                        .cornerRadius(24)
                }
                .padding(.top,80)
                Button(action:{
                    
                    upVM.loginModel.username = email
                    upVM.loginModel.password = upVM.currentPassword
                    if  upVM.confirmpassword == upVM.updatePasswordModel.password {
                        upVM.signin { log in
                            if log {
                                upVM.updatePssword()
                            }
                        }
                   }else {
                        upVM.alertMessage = "New password and confirm password do not match."
                        upVM.showAlert = true
                    }
                }){
                    Text("Update")
                        .font(.Medium16)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }.frame(height: 65)
                    .background(LinearGradient.secondaryGradient)
                    .cornerRadius(80)
                    .padding(.horizontal,30)
                    .padding(.top,70)
                    .alert(isPresented: $upVM.showAlert) {
                        Alert(title: Text("Does Not Change Your Password becacase Missing something "), message: Text(upVM.alertMessage), dismissButton: .default(Text("OK")))
                    }
                   
                Spacer()
            }.alert(isPresented: $upVM.showAlert, content: {
                getAlert(alertType: upVM.alertType, message: upVM.message)
            })
            if upVM.showProgress{
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
                    Text("Change Password")
                        .foregroundColor(.white)
                }

            }
           
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
