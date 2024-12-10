//
//  YouLikeGroupDetailView.swift
//  Baccvs iOS
//  Created by pm on 07/04/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct YouLikeGroupDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var groupdetail : GroupLikeYou
    var body: some View {
        VStack{
            Text(groupdetail.groupName)
                .foregroundColor(.white)
                .padding(.top,30)
            
            HStack{
                ForEach(groupdetail.user, id:\.userID){ i in
                    AnimatedImage(url: URL(string:  i.userImage))
                        .resizable()
                        .placeholder {
                            Rectangle().foregroundColor(.gray)
                                .frame(width: 71,height: 99)
                                    .cornerRadius(15)
                        }
                        .scaledToFill()
                        .transition(.fade)
                        .frame(width: 71,height: 99)
                            .cornerRadius(15)
                    
                }
            }
            .padding(.top,30)
            
            Text("Descrption")
                .font(.Medium20)
                .foregroundColor(.white)
                .padding(.top,50)
            VStack{
                Text(groupdetail.groupDescription)
                    .multilineTextAlignment(.leading)
                    .font(.Regular14)
                    .foregroundColor(.descrptionText)
                    .padding(.top,30)
                    .padding(.horizontal,25)
                Spacer()
            }.frame(maxWidth: .infinity)
                .frame(height: 162)
                .background(Color.textfieldColor)
                .cornerRadius(24)
                .padding(.horizontal,25)
            Spacer()
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(bgView())
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
                        Text(groupdetail.groupName)
                            .foregroundColor(.white)
                            .font(.Medium20)
                        
                    }
                }
            }
    }
}

struct YouLikeGroupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        YouLikeGroupDetailView(groupdetail: GroupLikeYou())
    }
}
