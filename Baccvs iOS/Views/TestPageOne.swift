//
//  TestPageOne.swift
//  Baccvs iOS
//
//  Created by pm on 22/03/2023.
//

import SwiftUI

struct TestPageOne: View {
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Image("img1")
                }
                .padding(.top,50)
               Spacer()
                VStack{
                    HStack{
                        Image("info")
                        Spacer()
                        Text("group Name")
                            .foregroundColor(.white)
                        Spacer()
                        Image("fire")
                    }.padding(.horizontal,25)
                }.frame(width: 350,height: 70)
                    .background(MyCustomShape().foregroundColor(.backgroundColor))
            }.frame(width: 350,height: 400)
                .background(Color.gray)
            
        }
    }
}

struct TestPageOne_Previews: PreviewProvider {
    static var previews: some View {
        TestPageOne()
    }
}
