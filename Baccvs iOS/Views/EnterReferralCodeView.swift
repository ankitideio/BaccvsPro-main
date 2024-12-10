//
//  EnterReferralCodeView.swift
//  Baccvs iOS
//
//  Created by pm on 01/02/2023.

import SwiftUI

struct EnterReferralCodeView: View {
   
    @State private var isContinue = false
    @StateObject var otpmodel: OTPCodeViewModel = .init()
    @FocusState var activeField : Otpfield?
    @Environment(\.presentationMode) var presentationMode
    var reffralCode : String
    var phoneNumber : String
    var body: some View {
        VStack{
            VStack{
               Text("4 Digit OTP Code")
                        .font(.Medium20)
                        .foregroundColor(.white)
                        .padding(.top,37)
                    Text("Please write your four digit verification code")
                        .font(.Regular14)
                        .foregroundColor(.lightTextColor)
                        .multilineTextAlignment(.center)
                        .padding(.top,15)
                        .padding(.horizontal,50)
              
                  Otpfield()
                .padding(.top,70)
                    NavigationLink {
                        SignupView(reffralCode: reffralCode, phoneNumber: phoneNumber)
                    } label: {
                        Text("continue")
                            .foregroundColor(.white)
                            .font(.Medium16)
                            .frame(maxWidth: .infinity)
                    }.frame(height:65)
                        .background(LinearGradient.secondaryGradient)
                            .cornerRadius(60)
                            .padding(.horizontal,25)
                            .padding(.top,120)
            }
            Spacer()
        }
        
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
                VStack{
                    ProgressBar(progress: (UIScreen.main.bounds.width * 0.6) - 45)
                }
                
            }

        }
//        .enableLightStatusBar()
    }
    func otpcondition(value:[String]){
        for index in 0..<3{
            if value[index].count == 1 && activeStateForIndex(index: index) == activeField{
                activeField=activeStateForIndex(index: index + 1)
            }
        }
        
        for index in 1...3{
            if value[index].isEmpty && !value[index - 1].isEmpty{
                activeField=activeStateForIndex(index:index - 1)
            }
        }
        
        for index in 0..<4{
            if value[index].count>1{
                otpmodel.otpfields[index]=String(value[index].last!)
            }
        }
    }
    @ViewBuilder
    func Otpfield()->some View{
        HStack(spacing:30){
            ForEach(0..<4,id: \.self){index in
                VStack(spacing: 8){
                    TextField("", text: $otpmodel.otpfields[index])
                        .font(.Regular24)
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .focused($activeField,equals: activeStateForIndex(index: index))
                        .background(Rectangle()
                    .fill(activeField==activeStateForIndex(index: index) ? .white :.gray.opacity(0.1) )
                            .frame(height: 55)
                            .cornerRadius(24))
                        .aspectRatio(1, contentMode: .fit)
                        
                }.frame(width: 55)
            }
        }
    }
    func activeStateForIndex(index:Int)->Otpfield{
        switch index{
        case 0 :return .field1
        case 1 :return .field2
        case 2 :return .field3
        default :return .field4
        }
    }
}

struct EnterReferralCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterReferralCodeView(reffralCode: "", phoneNumber: "")
    }
}

enum Otpfield{
    case field1
    case field2
    case field3
    case field4
}
