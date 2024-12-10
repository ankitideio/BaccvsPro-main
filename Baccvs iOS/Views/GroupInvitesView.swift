//
//  GroupInvitesView.swift
//  Baccvs iOS
//
//  Created by pm on 15/03/2023.
//

import SwiftUI

struct GroupInvitesView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
            Text("group Invites")
                .foregroundColor(.white)
            Spacer()
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
                    Text("Invites")
                        .font(.Medium20)
                        .foregroundColor(.white)
                }
              
            }
        
    }
}

struct GroupInvitesView_Previews: PreviewProvider {
    static var previews: some View {
        GroupInvitesView()
    }
}
