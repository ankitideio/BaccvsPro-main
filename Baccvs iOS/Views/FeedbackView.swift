//
//  FeedbackView.swift
//  Baccvs iOS
//
//  Created by pm on 08/02/2023.
//

import SwiftUI

struct FeedbackView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var fbVM = FeedBackUserViewModel()
    @State var description: String = ""
    @State private var reaction  = ""
    var body: some View {
        ZStack{
            VStack{
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        Text("How do you feel?")
                            .font(.Medium18)
                            .foregroundColor(.white)
                            .padding(.top,50)
                        Text("Tell us about your experience")
                            .font(.Regular10)
                            .foregroundColor(.lightTextColor)
                            .padding(.top,7)
                        HStack(spacing:25){
                            Button(action:{
                                fbVM.feedBack.mood = "laugh"
                            }){
                                Image("laughimg")
                                    .font(.Regular14)
                                    .foregroundColor( fbVM.feedBack.mood  == "laugh" ? .white :.lightTextColor)
                                    .frame(maxWidth: .infinity)
                            }.frame(width: 64,height:64)
                                .background( fbVM.feedBack.mood  == "laugh" ? .btnColor1 : Color.textfieldColor)
                                .cornerRadius(14)
                            
                            Button(action:{
                                fbVM.feedBack.mood = "happy"
                            }){
                                Image("happyimg")
                                    .font(.Regular14)
                                    .foregroundColor(  fbVM.feedBack.mood == "happy" ? .white :Color.lightTextColor)
                                    .frame(maxWidth: .infinity)
                            }.frame(width: 64,height:64)
                                .background(  fbVM.feedBack.mood == "happy" ? .btnColor1 : Color.textfieldColor)
                                .cornerRadius(14)
                            
                            Button(action:{
                                fbVM.feedBack.mood = "sad"
                            }){
                                Image("sadimg")
                                    .font(.Regular14)
                                    .foregroundColor(  fbVM.feedBack.mood == "sad" ? .white :Color.lightTextColor)
                                    .frame(maxWidth: .infinity)
                            }.frame(width: 64,height:64)
                                .background(  fbVM.feedBack.mood == "sad" ? .btnColor1 : Color.textfieldColor)
                                .cornerRadius(14)
                        }
                        .padding(.top,35)
                        Text("Give us feedback")
                            .foregroundColor(.white)
                            .font(.Medium20)
                            .padding(.top,70)
                        
                        TextEditor(text: $fbVM.feedBack.discription)
                            .font(.Regular14)
                            .frame(maxWidth: .infinity)
                            .frame(height: 162)
                            .scrollContentBackground(.hidden)
                            .background(Color.textfieldColor)
                            .foregroundColor(.white)
                            .cornerRadius(24)
                            .padding(.horizontal,25)
                    }
                   Button(action:{
                        fbVM.isComplete = true
                        fbVM.feedBackUser()
                    }){
                        Text("Send Your Feedback")
                            .font(.Regular16)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }.frame(height: 65)
                        .background(LinearGradient.secondaryGradient)
                        .cornerRadius(80)
                        .padding(.horizontal,25)
                        .padding(.top,60)
                }
                .padding(.top,20)
                Spacer()
                
            }.alert(isPresented: $fbVM.showAlert, content: {
                getAlert(alertType: fbVM.alertType, message: fbVM.message)
            })
            .onTapGesture {
                      // Dismiss the keyboard when the user taps outside of the text field or keyboard
                      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                  }
            if fbVM.showProgress{
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
            }
       }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
