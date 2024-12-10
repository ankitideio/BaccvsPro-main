//
//  ContentViews.swift
//  Baccvs iOS
//
//  Created by pm on 06/02/2023.
//

import SwiftUI
import RevenueCat
struct ContentViews: View {
    @State var show = false
    @Binding var isOpen : Bool?
    @Binding var isShowView : Bool
    var body: some View {
        VStack{
            ZStack{
                CustomSideBarMenuView(isOpen: $isOpen)
                    .padding(.top, 50)
                    .opacity(isOpen ?? false ? 1 : 0)
                    .offset(x: isOpen ?? false ? 0 : -300)
                    .rotation3DEffect(.degrees(isOpen ?? false ? 0 : 30), axis: (x: 0, y: 1, z: 0))
                    .ignoresSafeArea(.all, edges: .top)
                
                HomeView(isOpen: $isOpen, isShowView: $isShowView)
                //          .safeAreaInset(edge: .bottom) {
                //              Color.clear.frame(height: 80)
                //          }
                //          .safeAreaInset(edge: .top) {
                //              Color.clear.frame(height: 104)
                //          }
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .rotation3DEffect(.degrees(isOpen ?? false ? 30 : 0), axis: (x: 0, y: -1, z: 0), perspective: 1)
                    .offset(x: isOpen ?? false ? 265 : 0)
                    .scaleEffect(isOpen ?? false ? 0.9 : 1)
                    .scaleEffect(show ? 0.92 : 1)
                    .ignoresSafeArea()
                    .padding(.top,20)
                Spacer()
            }
        }.navigationBarBackButtonHidden(true)
        .background(bgView())
        .navigationBarHidden(isOpen ?? false)
    }
}

//struct ContentViews_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentViews()
//    }
//}
