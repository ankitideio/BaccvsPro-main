//
//  ReportedEventsPage.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 22/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReportedEventsPage: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var arVM = ReportsViewModel()
    @StateObject var drVM = DeleteReportsViewModel()
    @State  var showalert : Bool =  false

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.vertical,showsIndicators: false){
                ForEach(arVM.getallReportsModel.body ,id: \.eventID){ item in
                    HStack(){
                        AnimatedImage(url: URL(string: item.eventThumbnail ))
                            .resizable()
                            .placeholder {
                                Rectangle().foregroundColor(.gray)
                                    .frame(width: 55,height: 55)
                                        .cornerRadius(10)
                            }
                            .scaledToFill()
                            .transition(.fade)
                            .frame(width: 55,height: 55)
                                .cornerRadius(10)
                        
                        VStack(alignment: .leading,spacing: 10){
                            Text(item.eventName)
                                .font(.Medium14)
                                .foregroundColor(.white)
                            Text("Report Count : \(item.eventTotalReport)")
                                .font(.Medium10)
                                .foregroundColor(.white)
                        }
                        .padding(.leading,25)
                        Spacer()
                        VStack(alignment: .trailing){
                            Button(action:{
                                drVM.delreportModel.event_id = item.eventID
                                showalert.toggle()
                            }){
                                Text("Delete")
                                    .foregroundColor(.white)
                                    .font(.Medium10)
                                    .frame(maxWidth: .infinity)
                            }.frame(width: 91,height: 29)
                                .background(LinearGradient.secondaryGradient)
                                .cornerRadius(60)
                           

                        }.alert(isPresented: $showalert,content:{
                            Alert(
                                title: Text("Delete"), message: Text("Would You Like to Delete this Event"), primaryButton: .destructive(Text("Delete"),action:{
                                    arVM.getallReportsModel.body.removeAll(where:{$0.eventID == item.eventID})
                                    drVM.delReport()
                                }), secondaryButton: .cancel()
                            )
                        })
                    }
                }
            }.padding(.top,5)
        }
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal, 30)
        .background(bgView())
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                    Image("leftarrow")
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }

            }
            ToolbarItem(placement: .principal){
                Text("Reported Events")
                    .foregroundColor(.white)
            }
        }
        .onAppear{
            arVM.allReports()
        }
    }
}

struct ReportedEventsPage_Previews: PreviewProvider {
    static var previews: some View {
        ReportedEventsPage()
    }
}
