//
//  ReportView.swift
//  Baccvs iOS
//
//  Created by pm on 13/02/2023.
//

import SwiftUI

struct ReportView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
            Text("Report this profile")
                .foregroundColor(.white)
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .background(bgView())
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    NavigationLink(destination: TabNavPage(), label: {
                        Image("leftarrow")
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }

                    })

                }
                ToolbarItem(placement: .principal){
                    Text("Report Account")
                        .foregroundColor(.white)
                }
            }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
