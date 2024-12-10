//
//  CommunityView.swift
//  Baccvs iOS
//
//  Created by pm on 07/02/2023.
//

import SwiftUI

struct CommunityView: View {
    var body: some View {
        VStack{
           Text("community")
                .padding(.top,15)
                .foregroundColor(.white)
            Spacer()
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color.bg2)
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
