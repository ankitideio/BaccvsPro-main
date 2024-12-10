//
//  MyEventsView.swift
//  Baccvs iOS
//
//  Created by pm on 08/02/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct MyEventsView: View {
    @StateObject var meVM = MyEventsViewModel()
    @StateObject var puVM   = PostsForUsersHomeViewModel()
    @Environment(\.presentationMode) var presentationMode
    @StateObject var deVM = DeleteEventViewModel()
    @State var preselectedIndex = 0
    @State  var showalert : Bool =  false
    @State var selectedEvent = GetPostsForUsersHomeBody()

    var body: some View {
        ZStack{
            VStack{
                VStack{
                    CustomSegmentedControl(preselectedIndex: $meVM.selectedIndex, options: ["Past","Today","Upcoming"])
                        .foregroundColor(.white)
                        .font(.Regular16)
                        .padding(.horizontal,20)
                        .onChange(of: meVM.selectedIndex) { newValue in
                            meVM.selectedIndex = newValue
                            meVM.filterData()
                        }
                }.padding(.top,22)
                RefreshableScrollView {
                ForEach(meVM.eventsList, id: \.id){ item in
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                        Menu {
                            NavigationLink(destination: EditEventView(eventEdit: item), label: {
                                Text("Edit Event")
                                    .foregroundColor(.black)
                                    .font(.Regular14)
                            })
                            Button(action:{
                                selectedEvent = item
                                deVM.deleEventModel.evnet_id = item.id
                                deVM.deleEventModel.evnet_id = selectedEvent.id
                                showalert.toggle()
                            }){
                                Text("Delete Event")
                                    .foregroundColor(.black)
                                    .font(.Regular14)
                            }
                        } label: {
                            Button {
                            } label: {
                                Image("tooltipicon")
                                    .foregroundColor(.white)
                            }.frame(width: 34,height: 34)
                                .background(Color.btnColorbg)
                                .cornerRadius(12)
                                .padding(.top,20)
                                .padding(.trailing,10)
                            
                        }.alert(isPresented: $showalert,content:{
                            Alert(
                                title: Text("Delete"), message: Text("Would You Like to Delete this Event"), primaryButton: .destructive(Text("Delete"),action:{
                                    meVM.eventsList.removeAll(where:{$0.id == selectedEvent.id})
                                    deVM.delEvent()
                                }), secondaryButton: .cancel()
                            )
                        })
                        Image("playimg")
                            .frame(width: 79,height: 79)
                            .padding(.trailing,120)
                            .padding(.top,120)
                        
                        ZStack{
                            HStack{
                                AnimatedImage(url: URL(string: item.eventOwnerImage))
                                    .resizable()
                                    .placeholder {
                                        Rectangle().foregroundColor(.gray)
                                            .frame(width: 56,height: 70)
                                            .cornerRadius(5)
                                            .offset(y:-20)
                                    }
                                    .scaledToFill()
                                    .transition(.fade)
                                    .frame(width: 56,height: 70)
                                    .cornerRadius(5)
                                    .offset(y:-20)
                                HStack(spacing: -15){
                                    ForEach(0..<item.user.count,id:\.self){ i in
                                        if (i < 5){
                                            AnimatedImage(url: URL(string: item.user[i].userImage))
                                                .resizable()
                                                .placeholder {
                                                    Rectangle().foregroundColor(.gray)
                                                        .frame(width: 30,height: 32)
                                                        .cornerRadius(5)
                                                    
                                                }.scaledToFill()
                                                .transition(.fade)
                                                .frame(width: 30,height: 32)
                                                .cornerRadius(5)
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                HStack{
                                    Text("\(item.user.count)")
                                        .font(.Bold8)
                                        .foregroundColor(.white)
                                }
                                ForEach(item.music.components(separatedBy: ","),id:\.self){ n in
                                    Text(n.capitalized)
                                        .foregroundColor(.btnTextColor)
                                        .font(.Bold8)
                                        .frame(maxWidth: .infinity)
                                        .frame(width: 54,height: 18)
                                        .background(Color.white)
                                        .cornerRadius(8)
                                }
                            }
                            .padding(.horizontal,15)
                        }.frame(maxWidth: .infinity)
                            .frame(height: 72)
                            .background(MyCustomShape().foregroundColor(.backgroundColor)).padding(.top,300)
                    }.frame(width: 325,height: 343)
                        .background{
                            NavigationLink(destination: EventDetailView(evetDetails : item),isActive: $meVM.isMyevent) {
                                AnimatedImage(url: URL(string:  item.tumNail))
                                    .resizable()
                                    .placeholder {
                                        Rectangle().foregroundColor(.gray)
                                            .frame(width: 325,height: 343)
                                            .cornerRadius(10)
                                    }.scaledToFill()
                                    .transition(.fade)
                                    .frame(width: 325,height: 343)
                                    .cornerRadius(10)
                            }
                        } .cornerRadius(17)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }.padding(.top,10)
                        .onAppear{
                            UIRefreshControl.appearance().tintColor = UIColor.white
                        }
                 }.refreshable {
                meVM.myEvents()
                 }
                 .padding(.top,20)
            }
            if meVM.showProgress{
                ProgressView()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
            }
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .background(bgView())
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    
                        Image("leftarrow")
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                 
           }
                ToolbarItem(placement: .principal){
                      Text("My Events")
                        .foregroundColor(.white)
                        .font(.Medium20)
                }
            }.onAppear{
                meVM.myEvents()
            }
    }
   
}

struct MyEventsView_Previews: PreviewProvider {
    static var previews: some View {
        MyEventsView()
    }
}
