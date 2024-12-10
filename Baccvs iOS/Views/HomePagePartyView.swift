////
////  HomePagePartyView.swift
////  Baccvs iOS
////
////  Created by pm on 02/02/2023.
////
//
//import SwiftUI
//import Combine
//struct HomePagePartyView: View {
//    @StateObject var puVM = TestPostsForUsersHomeViewModel()
//    @State private var selectedFilter: String = "before"
//
//    var filteredEvents: [Event] {
//        switch selectedFilter {
//        case "before":
//            return events.filter { $0.isBefore }
//        case "party":
//            return events.filter { $0.isParty }
//        case "afterparty":
//            return events.filter { $0.isAfterparty }
//        default:
//            return []
//        }
//    }
//
//    var body: some View {
//        VStack{
//            VStack {
//                Picker("Select Filter", selection: $selectedFilter) {
//                    Text("Before").tag("before")
//                    Text("Party").tag("party")
//                    Text("Afterparty").tag("afterparty")
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding()
//
//                List(filteredEvents) { event in
//                    Text(event.name)
//                }
//            }
////            ScrollView(.vertical,showsIndicators: false){
////                ForEach(puVM.postsForUsersModel.body, id: \.id){ item in
////                    VStack{
////                        HStack{
////                            Text("Event Owner Name :")
////                                .foregroundColor(.black)
////                                .font(.Bold14)
////                            Text(item.eventOwnerName)
////                                .font(.Medium16)
////                                .foregroundColor(.blue)
////                        }
////                        HStack{
////                            Text("Event Name : ")
////                                .foregroundColor(.black)
////                                .font(.Bold14)
////                            Text(item.eventName)
////                                .font(.Medium16)
////                                .foregroundColor(.blue)
////                        }
////                        HStack{
////                            Text("Event Start Time : ")
////                                .foregroundColor(.black)
////                                .font(.Bold14)
////
////                        }
////                        Text(item.startTime.convertToCustomFormat())
////                            .font(.Medium16)
////                            .foregroundColor(.blue)
////                        HStack{
////                            Text("Event End Time : ")
////                                .foregroundColor(.black)
////                                .font(.Bold14)
////
////                        }
////                        Text(item.endTime.convertToCustomFormat())
////                            .font(.Medium16)
////                            .foregroundColor(.blue)
////                    }.frame(maxWidth: .infinity)
////                    .frame(height: 200)
////                        .background(Color.gray.opacity(0.5))
////                        .cornerRadius(15)
////                        .padding(.horizontal,20)
////
////                }
////            }.padding(.top,40)
//        }
//    }
//}
//
//struct HomePagePartyView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomePagePartyView()
//    }
//}
//
//
