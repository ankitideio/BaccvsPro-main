//
//  InvitationViewFriends.swift
//  Baccvs iOS
//
//  Created by pm on 30/03/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct InvitationViewFriends: View {
    @Environment(\.dismiss) var dismiss
    var invitationList : [UserSent]
    var body: some View {
        VStack{
            Button(action:{
                dismiss()
            }){
                Image(systemName: "multiply.circle.fill")
                    .resizable()
                    .frame(width: 34,height: 34)
                    .foregroundColor(.white)
           }
            .padding(.top,30)
            .frame(maxWidth: .infinity,alignment: .trailing)
            .padding(.horizontal,15)
            Spacer()
            ScrollView(.vertical,showsIndicators: false){
               VStack{
                   ForEach(invitationList, id:\.userId){ item in
                           HStack{
                                   AnimatedImage(url: URL(string: item.userImage))
                                       .resizable()
                                       .placeholder {
                                           Rectangle().foregroundColor(.gray)
                                               .frame(width: 50,height: 50)
                                               .cornerRadius(15)
                                       }
                                       .scaledToFill()
                                       .transition(.fade)
                                       .frame(width: 50,height: 50)
                                       .cornerRadius(15)
                             
                               Text(item.userName)
                                   .font(.Regular14)
                                   .foregroundColor(.white)
                                   .padding(.leading,30)

                           }.padding(.horizontal,25)
                            .frame(maxWidth: .infinity,alignment: .leading)
                       
                      
                   }.padding(.vertical,10)
                }
            }
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(bgView())
            .navigationBarBackButtonHidden(true)
    }
}

struct InvitationViewFriends_Previews: PreviewProvider {
    static var previews: some View {
        InvitationViewFriends(invitationList: [])
    }
}
