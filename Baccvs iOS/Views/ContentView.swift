//
//  ContentView.swift
//  Baccvs iOS
import SwiftUI
import Foundation

struct ContentView: View {
    @State private var isMembership = false
    @State private var isCreateAccout = false
    @State private var isOpen: Bool? = nil
   
    var body: some View {
        VStack {
            VStack {
               
                Text("BACCVS")
                    .font(.SemiBold48)
                  
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 80)

                GeometryReader { geometry in
                    Image("splashLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: min(geometry.size.width, geometry.size.height))
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
                .padding(.bottom, 25)
                Spacer()

                NavigationLink(destination: ReferralCodeView(), label: {
                    Text("Apply for membership")
                        .font(.Medium16)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                })
                .frame(height: 65)
                .background(
                           LinearGradient(
                               gradient: Gradient(colors: [Color(hex: "#CD3AFF"),Color(hex: "#291846")]),
                               startPoint: UnitPoint(x: 0.0, y: 0.4),
                               endPoint: UnitPoint(x: 0.06, y: 1.0)
                           )
                       )
                .cornerRadius(5)
                .padding(.horizontal, 25)
                .padding(.bottom, 10)

                NavigationLink(destination: SignInView(), label: {
                    Text("I have an account")
                        .font(.Medium16)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                })
                .frame(height: 65)
                .background(
                           LinearGradient(
                               gradient: Gradient(colors: [Color(hex: "#CD3AFF"),Color(hex: "#291846")]),
                               startPoint: UnitPoint(x: 0.9, y: 0.9),
                               endPoint: UnitPoint(x: 0.85, y: 0.3)
                           )
                       )
                .cornerRadius(5)
                .padding(.bottom, 0)
                .padding(.horizontal, 25)

                NavigationLink(destination: SignInView(), label: {
                    Text("Forgot Password?")
                        .font(.Medium16)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                })
                .frame(height: 65)
                .background(Color.clear)
                .cornerRadius(20)
                .padding(.bottom, 10)
                .padding(.horizontal, 25)

                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("blackBackground"), Color("btnColor2")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
//        .background(
//            ZStack {
//                Image("splash")
//                   
//                    .resizable(resizingMode: .stretch)
//                   
//                   .ignoresSafeArea()
//                    
//            }
//        )
    }
    // Function to check if a font is available
   
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

