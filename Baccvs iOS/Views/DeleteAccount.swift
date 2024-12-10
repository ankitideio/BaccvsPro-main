//
//  DeleteAccount.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 23/07/2023.
//

import SwiftUI
struct DeleteAccount : View{
    @Environment(\.presentationMode) var presentationMode
    @StateObject var deVM = DeActivateUserViewModel()
    @State  var showalert : Bool = false
     var body: some View {
         ZStack{
             VStack{
                 VStack(alignment: .leading){
                     Text("This will delete your account")
                         .font(.Regular14)
                         .foregroundColor(.white)
                         .padding(.top,60)
                     Text("Please remember, this action is irreversible. Once your account is deleted, all your personal information, settings, data and history will be permanently erased from our system and cannot be recovered. If you still need to access some of your information or you are not sure about this decision, we strongly recommend you to think it over. You can always delete your account at a later date.")
                         .padding(.top,15)
                         .font(.Regular12)
                         .foregroundColor(.secondarytextColor)
                 }.padding(.horizontal,25)
                     .frame(maxWidth: .infinity,alignment: .leading)
                     .padding(.top,30)
                 
                 Button(action:{
                     showalert = true
                 }){
                     Text("Delete Account Permanently")
                         .font(.Medium16)
                         .foregroundColor(.white)
                         .frame(maxWidth: .infinity)
                 }.frame(height: 65)
                     .background(Color.red)
                     .cornerRadius(80)
                     .padding(.horizontal,25)
                     .padding(.top,150)
                    
                 Spacer()
             } .alert(isPresented: $showalert,content:{
                 Alert(
                     title: Text("Delete Account"), message: Text("Would You Like to Delete your Account"), primaryButton: .destructive(Text("Delete"),action:{
                         deVM.deleteAccount()
                     }), secondaryButton: .cancel()
                 )
             })
             if deVM.showProgress{
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
                    Text("Delete account")
                        .foregroundColor(.white)
                }

            }
           
    }
}
