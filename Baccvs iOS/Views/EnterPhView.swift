//
//  EnterPhView.swift
//  Baccvs iOS
//
//  Created by pm on 03/02/2023.
import SwiftUI

struct EnterPhView: View {
    @State private var phNo = ""
    @State private var isContinue = false
    var reffrarlcode: String
    @Environment(\.presentationMode) var presentationMode
    @StateObject var soVM = OTPCheckViewModel()
    @State private var countryCode = ""
    
    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: 15) {
                    Text("What’s your phone number?")
                        .font(.Medium20)
                        .foregroundColor(.white)
                   
                    Text("Please write your phone number for verification code")
                        .multilineTextAlignment(.center)
                        .font(.Regular14)
                        .foregroundColor(.lightTextColor)
                
                    HStack {
                        Menu {
                            ForEach(dectContry, id: \.id) { c in
                                Button {
                                    soVM.selectedCode = c.dialCode
                                    print(c.dialCode)
                                } label: {
                                    CountryCodeListView(dialCode: c.dialCode, flag: c.flag, name: c.name)
                                }
                            }
                        } label: {
                            HStack {
                                Text(soVM.selectedCode)
                                    .foregroundColor(.gray)
                                    .padding()
                                    .frame(width: 94)
                                    .frame(height: 56)
                                    .background(Color.textfieldColor)
                                    .cornerRadius(24)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Spacer()
                        
                        TextField("", text: $soVM.sendOtpModel.phone_number)
                            .placeholder(when: soVM.sendOtpModel.phone_number.isEmpty) {
                                Text("000000")
                                    .foregroundColor(.gray)
                                    .font(.Regular14)
                            }
                            .foregroundColor(.lightTextColor)
                            .padding()
                            .frame(width: 210, height: TextFieldHeight)
                            .background(Color.textfieldColor)
                            .cornerRadius(24)
                            .keyboardType(.numberPad)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 30)
                    .padding(.top, 30)
               }
            
                NavigationLink(destination: OTPVerificationView(phoneNumber: getCompletePhoneNumber(), reffralCode: reffrarlcode), isActive: $soVM.gotoOtpPage) {
                  
                }
                
                Button(action: {
                    soVM.sendOTP()
                }) {
                    Text("Continue")
                        .font(.Medium16)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }
                .frame(width: 314, height: 65)
                .background(LinearGradient.secondaryGradient)
                .cornerRadius(60)
                .padding(.top, 80)
                .disabled(soVM.showProgress) // Disable the button while in progress

                Spacer()
            }
            .padding(.top, 30)
            .alert(isPresented: $soVM.showAlert, content: {
                getAlert(alertType: soVM.alertType, message: soVM.message)
            })

            if soVM.showProgress {
                ProgressView()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(bgView())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image("leftarrow")
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            ToolbarItem(placement: .principal) {
                VStack {
                    ProgressBar(progress: (UIScreen.main.bounds.width * 0.4) - 45)
                }
            }
        }
    }
    
    func getCompletePhoneNumber() -> String {
        return soVM.selectedCode + soVM.sendOtpModel.phone_number
    }
    
    func countryFlag(_ countryCode: String) -> String {
        String(String.UnicodeScalarView(countryCode.unicodeScalars.compactMap {
            UnicodeScalar(127397 + $0.value)
        }))
    }
}

struct EnterPhView_Previews: PreviewProvider {
    static var previews: some View {
        EnterPhView(reffrarlcode: "")
    }
}

struct CountryCodeListView: View {
    var dialCode: String
    var flag: String
    var name: String
    
    var body: some View {
        HStack {
            Text(dialCode) +
            Text(flag) +
            Text(name)
                .font(.Regular12)
                .foregroundColor(.black)
        }
    }
}
