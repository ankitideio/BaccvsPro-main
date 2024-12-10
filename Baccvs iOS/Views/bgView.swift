//
//  bgView.swift
//  Baccvs iOS
//
//  Created by pm on 03/02/2023.
//

import SwiftUI
struct bgView: View {
    var body: some View {
            VStack{
                Image("appbg")
//                Circle()
//                    .fill(Color.bg1)
//                    .blur(radius: 130)
//                    .frame(width: 320,height: 320)
//                    .offset(y: -243)
//                Spacer()
            }.frame(maxWidth: .infinity,maxHeight: .infinity)
//                .background(Color.bg2)
    }
}

struct bgView_Previews: PreviewProvider {
    static var previews: some View {
        bgView()
    }
}
