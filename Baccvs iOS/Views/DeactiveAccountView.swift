//
//  DeactivateAccount.swift
//  Baccvs iOS
//
//  Created by pm on 07/02/2023.
//

import SwiftUI
struct DeactivateAccount: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var deVM = DeActivateUserViewModel()
    @State  var showalert : Bool = false
     var body: some View {
         ZStack{
             VStack{
                 VStack(alignment: .leading){
                     Text("This will deactivate your account")
                         .font(.Regular14)
                         .foregroundColor(.white)
                         .padding(.top,60)
                     Text("You’re about to start the process of deactivating your Baccvs account. Your display name, @username, and public profile will no longer be viewable on Baccvs.")
                         .padding(.top,15)
                         .font(.Regular12)
                         .foregroundColor(.secondarytextColor)
                 }.padding(.horizontal,25)
                     .frame(maxWidth: .infinity,alignment: .leading)
                     .padding(.top,30)
                 
                 Button(action:{
                     deVM.deactivateModel.is_delete.toggle()
                     showalert.toggle()
                     
                 }){
                     Text("Deactivate")
                         .font(.Medium16)
                         .foregroundColor(.white)
                         .frame(maxWidth: .infinity)
                 }.frame(height: 65)
                     .background(LinearGradient.secondaryGradient)
                     .cornerRadius(80)
                     .padding(.horizontal,25)
                     .padding(.top,150)
                    
                 Spacer()
             } .alert(isPresented: $showalert,content:{
                 Alert(
                     title: Text("Deactivate"), message: Text("Would You Like to Deactivate your Account"), primaryButton: .destructive(Text("Report"),action:{
                         deVM.deActivateUser()
                     }), secondaryButton: .cancel()
                 )
             })
//             .alert(isPresented: $deVM.showAlert, content: {
//                 getAlert(alertType: deVM.alertType, message: deVM.message)
//             })
//
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
                    Text("Deactivate account")
                        .foregroundColor(.white)
                }

            }
           
    }
}

struct DeactivateAccount_Previews: PreviewProvider {
    static var previews: some View {
        DeactivateAccount()
    }
}
