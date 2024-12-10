//
//  HomeView.swift
//  Baccvs iOS
//  Created by pm on 01/02/2023.
import SwiftUI
import AVKit
import SDWebImageSwiftUI
import OneSignal
import RevenueCat
struct HomeView: View {
    @StateObject var puVM = PostsForUsersHomeViewModel()
    @StateObject var reVM = ReportEventViewModel()
    @StateObject var ncVM = NetworkMonitor()
    @StateObject var uVM  = UpgrageViewModel()
    @Binding var isOpen : Bool?
    @Binding var isShowView : Bool
    @State  var showalert : Bool =  false
    @State var isSencitive : Bool = false
    @State var btn1 = partyStatus.isBefore
    @State var btn2 = partyStatus.isAfter
    @State var btnTime1 = partyStatus.missed
    @State var btnTime2 = partyStatus.upcomming
    var body: some View {
        ZStack{
            VStack{
                VStack(spacing:-85){
                    VStack(spacing: -35){
                        HStack(spacing:58){
                            Button(action:{
                               let valueS = puVM.swapFunction(initialVallue: btn1, selectedValue: puVM.selectedStatus)
                                btn1 = valueS.swiped
                                puVM.selectedStatus = valueS.selectedValue
                                puVM.filterData()
                            }){
                                Text(puVM.checkSelectedValue(selected: btn1))
                                    .rotationEffect(Angle(degrees: -6))
                                    .padding(.top,50)
                                    .font(.Medium14)
                                    .foregroundColor(.white)
                            }
                                Text(puVM.checkSelectedValue(selected: puVM.selectedStatus))
                                    .padding(.top,45)
                                    .font(.Bold18)
                                    .foregroundColor(.secondaryColor)
                            Button(action:{
                                let valueS = puVM.swapFunction(initialVallue: btn2, selectedValue: puVM.selectedStatus)
                                 btn2 = valueS.swiped
                                 puVM.selectedStatus = valueS.selectedValue
                                puVM.filterData()
                            }){
                                Text(puVM.checkSelectedValue(selected: btn2))
                                    .rotationEffect(Angle(degrees: 6))
                                    .padding(.top,50)
                                    .font(.Medium14)
                                    .foregroundColor(.white)
                            }
                        }.padding(.top,30)
                        GeometryReader { geometry in
                            Path { path in
                                let start = CGPoint(x: 0, y: geometry.size.height / 2)
                                let end = CGPoint(x: geometry.size.width, y: geometry.size.height / 2)
                                let control = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 4)
                                path.move(to: start)
                                path.addQuadCurve(to: end, control: control)
                            }
                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                        }.frame(maxWidth: .infinity)
                            .frame(height: 116)
                            .padding(.top,10)
                    }
                    VStack(spacing:-35){
                        HStack(spacing:58){
                            Button(action:{
                                let valueS = puVM.swapFunction(initialVallue: btnTime1, selectedValue: puVM.selectedTime)
                                 btnTime1 = valueS.swiped
                                 puVM.selectedTime = valueS.selectedValue
                                puVM.filterData()
                            }){
                                Text(puVM.checkSelectedValue(selected: btnTime1))
                                    .rotationEffect(Angle(degrees: -6))
                                    .font(.Medium14)
                                    .padding(.top,15)
                                    .foregroundColor(.white)
                            }
                                Text(puVM.checkSelectedValue(selected: puVM.selectedTime))
                                    .font(.Bold18)
                                    .foregroundColor(.secondaryColor)
                            Button(action:{
                                let valueS = puVM.swapFunction(initialVallue: btnTime2, selectedValue: puVM.selectedTime)
                                 btnTime2 = valueS.swiped
                                 puVM.selectedTime = valueS.selectedValue
                                puVM.filterData()
                            }){
                                Text(puVM.checkSelectedValue(selected: btnTime2))
                                    .rotationEffect(Angle(degrees: 6))
                                    .font(.Medium14)
                                    .padding(.top,15)
                                    .foregroundColor(.white)
                            }
                        }.padding(.top,20)
                        GeometryReader { geometry in
                            Path { path in
                                let start = CGPoint(x: 0, y: geometry.size.height / 2)
                                let end = CGPoint(x: geometry.size.width, y: geometry.size.height / 2)
                                let control = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 4)
                                path.move(to: start)
                                path.addQuadCurve(to: end, control: control)
                            }
                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                        }.frame(maxWidth: .infinity)
                            .frame(height: 116)
                            .padding(.top,8)
                    }
                }
                .frame(height: 145)
                .padding(.top,15)
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        ForEach(puVM.filteredEvents, id:\.id){ item  in
          ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                                Button(action:{
                                        reVM.reportEventModel.event_id = item.id
                                        showalert.toggle()
                                    }){
                                        Image("tooltipicon")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(7)
                                            .frame(width: 34,height: 34)

                                    }
                                    .background(Color.btnColorbg)
                                    .cornerRadius(12)
                                    .padding(.top,20)
                                    .padding(.trailing,280)
                                    .alert(isPresented: $showalert,content:{
                                        Alert(
                                            title: Text("Report"), message: Text("Would You Like to Report this Event"), primaryButton: .destructive(Text("Report"),action:{
                                                reVM.reportEvent()
                                            }), secondaryButton: .cancel()
                                        )
                                    })
                                    VStack{
                                        HStack{
                                            Image("labelimg")
                                            Text(item.freePaid == true ? "paid" : "Free")
                                                .foregroundColor(.white)
                                        }
                                       
                                    }.frame(width: 104,height: 34)
                                        .background(Color.btnColorbg)
                                        .cornerRadius(17)
                                        .padding(.top,20)
                                        .padding(.trailing,10)
                                NavigationLink(destination: EventDetailView(evetDetails: item)) {
                                    if !item.isSensitive{
                                        Image("playimg")
                                            .frame(width: 79,height: 79)
                                            .padding(.trailing,120)
                                            .padding(.top,120)
                                    }
                                }
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
                                                                        
                                                                }
                                                                .scaledToFill()
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
                              ForEach(item.music.components(separatedBy: ","),id:\.self) { n in
                                      Text(n.capitalized)
                                      .foregroundColor(.btnTextColor)
                                      .font(.Bold8)
                                      .frame(maxWidth: .infinity)
                                      .frame(width: 54,height: 18)
                                      .background(Color.white)
                                      .cornerRadius(8)
                                  
                                   }
                                        }.padding(.horizontal,10)
                                    }.frame(maxWidth: .infinity)
                                        .frame(height: 72)
                                        .background(MyCustomShape().foregroundColor(.backgroundColor))
                                        .padding(.top,300)
                                }.frame(width: 325,height: 343)
                .background( VStack{
                                        if item.isSensitive{
                                            ZStack{
                                                
                                                AnimatedImage(url: URL(string: item.tumNail))
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(height: 343)
                                                Color.black.opacity(0.9)
                                                VStack{
                                                    Image("isSencitive")
                                                    Text("Sensitive content")
                                                        .font(.Bold14)
                                                        .foregroundColor(.white)
                                                    Text("This video may contain graphic or violent content.")
                                                        .foregroundColor(.white)
                                                }
                                            }
                                        }else{
                                            AnimatedImage(url: URL(string: item.tumNail))
                                                .resizable()
                                                .scaledToFill()
                                                .frame(height: 343)
                                        }
                                    }).cornerRadius(17)
                              }.padding(.top,10)
                        }
                }.padding(.top,10)
                Spacer()
            }
            if puVM.showProgress{
                ProgressView()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
            }
            if isShowView {
                EventDetail(puVM: puVM)
                .offset(y:-200)
            }
            if  puVM.showProgress{
                ProgressView()
                 .progressViewStyle(CircularProgressViewStyle(tint: .secondaryColor))
                 .scaleEffect(2)
                 .padding(.top,150)
            }
           Spacer()
        }.background(bgView())
        .onAppear{
            Purchases.shared.getCustomerInfo { (customerInfo, error) in
                // access latest customerInfo
                if customerInfo?.entitlements["pro"]?.isActive == true {
                    uVM.isPro = true
                    uVM.isProModel.pro = true
                    uVM.isProprofile()
                    // Unlock that great "pro" content
                    print("true")
                }else{
                    uVM.isProModel.pro = false
                    uVM.isProprofile()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(isOpen: .constant(true), isShowView: .constant(true))
    }
}
//struct HomeView: View {
//    @StateObject var puVM = PostsForUsersHomeViewModel()
//    @StateObject var reVM = ReportEventViewModel()
//    @StateObject var ncVM = NetworkMonitor()
//    @StateObject var uVM  = UpgrageViewModel()
//    @Binding var isOpen : Bool?
//    @Binding var isShowView : Bool
//    @State  var showalert : Bool =  false
//    @State var isSencitive : Bool = false
//    var body: some View {
//        ZStack{
//            VStack{
//                VStack(spacing:-85){
//                    VStack(spacing: -35){
//                        HStack(spacing:58){
//                            Button(action:{
//                                puVM.selectUserText(selectedParam: "Before")
//                            }){
//                                Text(puVM.filterModel.first)
//                                    .rotationEffect(Angle(degrees: -6))
//                                    .padding(.top,50)
//                                    .font(.Medium14)
//                                    .foregroundColor(.white)
//                            }
//                            Button(action:{}){
//                                Text(puVM.filterModel.third)
//                                    .padding(.top,45)
//                                    .font(.Bold18)
//                                    .foregroundColor(.secondaryColor)
//                            }
//                            Button(action:{
//                                puVM.selectUserText(selectedParam: "AfterParty")
//                            }){
//                                Text(puVM.filterModel.secound)
//                                    .rotationEffect(Angle(degrees: 6))
//                                    .padding(.top,50)
//                                    .font(.Medium14)
//                                    .foregroundColor(.white)
//                            }
//                        }.padding(.top,30)
//                        GeometryReader { geometry in
//                            Path { path in
//                                let start = CGPoint(x: 0, y: geometry.size.height / 2)
//                                let end = CGPoint(x: geometry.size.width, y: geometry.size.height / 2)
//                                let control = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 4)
//                                path.move(to: start)
//                                path.addQuadCurve(to: end, control: control)
//                            }
//                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
//                        }.frame(maxWidth: .infinity)
//                            .frame(height: 116)
//                            .padding(.top,10)
//                    }
//                    VStack(spacing:-35){
//                        HStack(spacing:58){
//                            Button(action:{
//                                puVM.selectTimeText(selectedParam : "Missed")
//                            }){
//                                Text(puVM.filterModel.four)
//                                    .rotationEffect(Angle(degrees: -6))
//                                    .font(.Medium14)
//                                    .padding(.top,15)
//                                    .foregroundColor(.white)
//                            }
//                            Button(action:{ }){
//                                Text(puVM.filterModel.five)
//                                    .font(.Bold18)
//                                    .foregroundColor(.secondaryColor)
//                            }
//                            Button(action:{
//                                puVM.selectTimeText(selectedParam : "Upcoming")
//                            }){
//                                Text(puVM.filterModel.six)
//                                    .rotationEffect(Angle(degrees: 6))
//                                    .font(.Medium14)
//                                    .padding(.top,15)
//                                    .foregroundColor(.white)
//                            }
//                        }.padding(.top,20)
//                        GeometryReader { geometry in
//                            Path { path in
//                                let start = CGPoint(x: 0, y: geometry.size.height / 2)
//                                let end = CGPoint(x: geometry.size.width, y: geometry.size.height / 2)
//                                let control = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 4)
//                                path.move(to: start)
//                                path.addQuadCurve(to: end, control: control)
//                            }
//                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
//                        }.frame(maxWidth: .infinity)
//                            .frame(height: 116)
//                            .padding(.top,8)
//                    }
//                }
//                .frame(height: 145)
//                .padding(.top,15)
//                ScrollView(.vertical,showsIndicators: false){
//                    VStack{
//                        ForEach(puVM.filteredEvents, id:\.id){ item  in
//          ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
//                                Button(action:{
//                                        reVM.reportEventModel.event_id = item.id
//                                        showalert.toggle()
//                                    }){
//                                        Image("tooltipicon")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .padding(7)
//                                            .frame(width: 34,height: 34)
//
//                                    }
//                                    .background(Color.btnColorbg)
//                                    .cornerRadius(12)
//                                    .padding(.top,20)
//                                    .padding(.trailing,280)
//                                    .alert(isPresented: $showalert,content:{
//                                        Alert(
//                                            title: Text("Report"), message: Text("Would You Like to Report this Event"), primaryButton: .destructive(Text("Report"),action:{
//                                                reVM.reportEvent()
//                                            }), secondaryButton: .cancel()
//                                        )
//                                    })
//                                    VStack{
//                                        HStack{
//                                            Image("labelimg")
//                                            Text(item.freePaid == true ? "paid" : "Free")
//                                                .foregroundColor(.white)
//                                        }
//
//                                    }.frame(width: 104,height: 34)
//                                        .background(Color.btnColorbg)
//                                        .cornerRadius(17)
//                                        .padding(.top,20)
//                                        .padding(.trailing,10)
//                                NavigationLink(destination: EventDetailView(evetDetails: item)) {
//                                    if !item.isSensitive{
//                                        Image("playimg")
//                                            .frame(width: 79,height: 79)
//                                            .padding(.trailing,120)
//                                            .padding(.top,120)
//                                    }
//                                }
//                                   ZStack{
//                                        HStack{
//                                            AnimatedImage(url: URL(string: item.eventOwnerImage))
//                                                .resizable()
//                                                .placeholder {
//                                                    Rectangle().foregroundColor(.gray)
//                                                        .frame(width: 56,height: 70)
//                                                        .cornerRadius(5)
//                                                        .offset(y:-20)
//                                                }
//                                                .scaledToFill()
//                                                .transition(.fade)
//                                                .frame(width: 56,height: 70)
//                                                .cornerRadius(5)
//                                                .offset(y:-20)
//                                            HStack(spacing: -15){
//                                                    ForEach(0..<item.user.count,id:\.self){ i in
//                                                        if (i < 5){
//                                                            AnimatedImage(url: URL(string: item.user[i].userImage))
//                                                                .resizable()
//                                                                .placeholder {
//                                                                    Rectangle().foregroundColor(.gray)
//                                                                        .frame(width: 30,height: 32)
//                                                                        .cornerRadius(5)
//
//                                                                }
//                                                                .scaledToFill()
//                                                                .transition(.fade)
//                                                                .frame(width: 30,height: 32)
//                                                                .cornerRadius(5)
//                                                        }
//                                                    }
//                                                }
//                                                    Spacer()
//
//                                            HStack{
//                                                Text("\(item.user.count)")
//                                                    .font(.Bold8)
//                                                    .foregroundColor(.white)
//                                             }
//                              ForEach(item.music.components(separatedBy: ","),id:\.self) { n in
//                                      Text(n.capitalized)
//                                      .foregroundColor(.btnTextColor)
//                                      .font(.Bold8)
//                                      .frame(maxWidth: .infinity)
//                                      .frame(width: 54,height: 18)
//                                      .background(Color.white)
//                                      .cornerRadius(8)
//
//                                   }
//                                        }.padding(.horizontal,10)
//                                    }.frame(maxWidth: .infinity)
//                                        .frame(height: 72)
//                                        .background(MyCustomShape().foregroundColor(.backgroundColor))
//                                        .padding(.top,300)
//                                }.frame(width: 325,height: 343)
//                .background( VStack{
//                                        if item.isSensitive{
//                                            ZStack{
//
//                                                AnimatedImage(url: URL(string: item.tumNail))
//                                                    .resizable()
//                                                    .scaledToFill()
//                                                    .frame(height: 343)
//                                                Color.black.opacity(0.9)
//                                                VStack{
//                                                    Image("isSencitive")
//                                                    Text("Sensitive content")
//                                                        .font(.Bold14)
//                                                        .foregroundColor(.white)
//                                                    Text("This video may contain graphic or violent content.")
//                                                        .foregroundColor(.white)
//                                                }
//                                            }
//                                        }else{
//                                            AnimatedImage(url: URL(string: item.tumNail))
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(height: 343)
//                                        }
//                                    }).cornerRadius(17)
//                              }.padding(.top,10)
//                        }
//                }.padding(.top,10)
//                Spacer()
//            }
//            if puVM.showProgress{
//                ProgressView()
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .background(Color.black.opacity(0.5))
//                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
//            }
//            if isShowView {
//                EventDetail(puVM: puVM)
//                .offset(y:-200)
//            }
//            if  puVM.showProgress{
//                ProgressView()
//                 .progressViewStyle(CircularProgressViewStyle(tint: .secondaryColor))
//                 .scaleEffect(2)
//                 .padding(.top,150)
//            }
//           Spacer()
//        }.background(bgView())
//        .onAppear{
//            Purchases.shared.getCustomerInfo { (customerInfo, error) in
//                // access latest customerInfo
//                if customerInfo?.entitlements["pro"]?.isActive == true {
//                    uVM.isPro = true
//                    uVM.isProModel.pro = true
//                    uVM.isProprofile()
//                    // Unlock that great "pro" content
//                    print("true")
//                }else{
//                    uVM.isProModel.pro = false
//                    uVM.isProprofile()
//                }
//            }
//        }
//    }
//}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(isOpen: .constant(true), isShowView: .constant(true))
//    }
//}

struct MyCustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.00133*width, y: 0.21695*height))
        path.addCurve(to: CGPoint(x: 0.01258*width, y: 0.1699*height), control1: CGPoint(x: 0.00133*width, y: 0.19349*height), control2: CGPoint(x: 0.0061*width, y: 0.17352*height))
        path.addLine(to: CGPoint(x: 0.11927*width, y: 0.11026*height))
        path.addCurve(to: CGPoint(x: 0.8885*width, y: 0.11145*height), control1: CGPoint(x: 0.37414*width, y: -0.03222*height), control2: CGPoint(x: 0.63366*width, y: -0.03182*height))
        path.addLine(to: CGPoint(x: 0.98621*width, y: 0.16638*height))
        path.addCurve(to: CGPoint(x: 0.99744*width, y: 0.21342*height), control1: CGPoint(x: 0.99268*width, y: 0.17002*height), control2: CGPoint(x: 0.99744*width, y: 0.18998*height))
        path.addLine(to: CGPoint(x: 0.99744*width, y: 0.55238*height))
        path.addLine(to: CGPoint(x: 0.99744*width, y: 0.93993*height))
        path.addCurve(to: CGPoint(x: 0.98356*width, y: 0.98137*height), control1: CGPoint(x: 0.99744*width, y: 0.96624*height), control2: CGPoint(x: 0.99078*width, y: 0.98611*height))
        path.addLine(to: CGPoint(x: 0.98356*width, y: 0.98137*height))
        path.addCurve(to: CGPoint(x: 0.03748*width, y: 0.97668*height), control1: CGPoint(x: 0.67084*width, y: 0.77642*height), control2: CGPoint(x: 0.35036*width, y: 0.77483*height))
        path.addLine(to: CGPoint(x: 0.01582*width, y: 0.99066*height))
        path.addCurve(to: CGPoint(x: 0.00133*width, y: 0.94728*height), control1: CGPoint(x: 0.00827*width, y: 0.99552*height), control2: CGPoint(x: 0.00133*width, y: 0.97475*height))
        path.addLine(to: CGPoint(x: 0.00133*width, y: 0.53333*height))
        path.addLine(to: CGPoint(x: 0.00133*width, y: 0.21695*height))
        path.closeSubpath()
        return path
    }
}
struct EventDetail : View {
    @State var freePaidSwitch = false
    @State private var gender = ""
    @StateObject var puVM : PostsForUsersHomeViewModel
    @State var selections : [String] = []
    @State var items : [String] = ["Classic","Rap","Techno","Sad","Romantic"]

 var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)){
            VStack(spacing: 10){
                ScrollView(.vertical,showsIndicators: false){
                VStack(spacing:5){
                    Text("Free/Paid")
                        .font(.Regular10)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity,alignment: .trailing)
                    Toggle("", isOn: $freePaidSwitch)
                        .toggleStyle(SwitchToggleStyle(tint: .gray))
                        .onChange(of: freePaidSwitch) { newValue in
                            if newValue{
                                puVM.isFree = newValue
                            }else{
                                puVM.isFree = newValue
                            }
                        }
                        
                }.frame(maxWidth: .infinity,alignment: .trailing)
                    .padding(.horizontal,25)
                    
                    if freePaidSwitch == true {
                        HStack(spacing:10){
                            Image("freePaid")
                            Text("Price")
                                .font(.Medium10)
                                .foregroundColor(.white)
                            TextField("", text:$puVM.minFreePaid)
                                .placeholder(when: puVM.minFreePaid.isEmpty) {
                                    Text("Min").foregroundColor(.gray)
                                        .font(.Regular14)
                                }.padding()
                                .frame(width: 97,height: 36)
                                .foregroundColor(.white)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(1)))
                            TextField("", text:$puVM.maxFreePaid)
                                .placeholder(when: puVM.maxFreePaid.isEmpty) {
                                    Text("Max").foregroundColor(.gray)
                                        .font(.Regular14)
                                }.padding()
                                .frame(width: 97,height: 36)
                                .foregroundColor(.white)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(1)))
                        }
                        HStack(spacing:10){
                            Image("peoples")
                            Text("People")
                                .font(.Medium10)
                                .foregroundColor(.white)
                            TextField("", text:$puVM.peopleMin)
                                .placeholder(when: puVM.peopleMin.isEmpty) {
                                    Text("Min").foregroundColor(.gray)
                                        .font(.Regular14)
                                }.padding()
                                .frame(width: 97,height: 36)
                                .foregroundColor(.white)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(1)))
                            TextField("", text:$puVM.peopleMax)
                                .placeholder(when: puVM.peopleMax.isEmpty) {
                                    Text("Max").foregroundColor(.gray)
                                        .font(.Regular14)
                                }.padding()
                                .frame(width: 97,height: 36)
                                .foregroundColor(.white)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(1)))
                        }
                        HStack(spacing:10){
                            Image("Location")
                            Text("Location")
                                .font(.Medium10)
                                .foregroundColor(.white)
                            TextField("", text:$puVM.location)
                                .placeholder(when: puVM.location.isEmpty) {
                                    Text("Location").foregroundColor(.gray)
                                        .font(.Regular14)
                                }.padding()
                                .frame(width: 202,height: 36)
                                .foregroundColor(.white)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(1)))
                        }
                    
                    }else {
                        HStack(spacing:10){
                            Image("peoples")
                            Text("People")
                                .font(.Medium10)
                                .foregroundColor(.white)
                            TextField("", text:$puVM.peopleMin)
                                .placeholder(when: puVM.peopleMin.isEmpty) {
                                    Text("Min").foregroundColor(.gray)
                                        .font(.Regular14)
                                }.padding()
                                .frame(width: 97,height: 36)
                                .foregroundColor(.white)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(1)))
                            TextField("", text:$puVM.peopleMax)
                                .placeholder(when: puVM.peopleMax.isEmpty) {
                                    Text("Max").foregroundColor(.gray)
                                        .font(.Regular14)
                                }.padding()
                                .frame(width: 97,height: 36)
                                .foregroundColor(.white)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(1)))
                        }
//                        HStack(spacing:20){
//                            Image("music")
//                            Text("Mood")
//                                .font(.Medium10)
//                                .foregroundColor(.white)
//                            TextField("", text:$puVM.mood)
//                                .placeholder(when: puVM.mood.isEmpty) {
//                                    Text("Mood").foregroundColor(.gray)
//                                        .font(.Regular14)
//                                }.padding()
//                                .frame(width: 202,height: 36)
//                                .foregroundColor(.white)
//                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(1)))
//
//                        }
                        HStack(spacing:20){
                            Image("music")
                            Text("Mood")
                                .font(.Medium10)
                                .foregroundColor(.white)

                            Menu {
                                ForEach(self.items, id: \.self) { item in
                                    Button {
                                        if self.selections.contains(item) {
                                            self.selections.removeAll(where: { $0 == item })
                                        }
                                        else {
                                            self.selections.append(item)
                                            print(item)
                                        }
                                    } label: {
                                        HStack{
                                               Text(item)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                            if self.selections.contains(item) {
                                                Spacer()
                                                Image(systemName: "checkmark")
                                            }
                                        }
                                    }
                                }
                           } label: {
                                Text(selections.joined(separator: ",") )
                                    .placeholder(when: selections.isEmpty) {
                                        HStack{
                                            Text("Select Mood")
                                                .foregroundColor(.gray)
                                                .font(.Regular14)
                                            Spacer()
                                        }
                                    }
                                    .padding()
                                    .frame(width: 202,height: 36)
                                    .foregroundColor(.white)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(1)))
                            }
                        }
                        HStack(spacing:10){
                            Image("Location")
                            Text("Location")
                                .font(.Medium10)
                                .foregroundColor(.white)
                            TextField("", text:$puVM.location)
                                .placeholder(when: puVM.location.isEmpty) {
                                    Text("Location").foregroundColor(.gray)
                                        .font(.Regular14)
                                }.padding()
                                .frame(width: 202,height: 36)
                                .foregroundColor(.white)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(1)))
                        }
                    }
                        
                    HStack(spacing: 10){
                            Spacer()
                            Button(action:{
                                puVM.removeAdvancedFilter()
                            }){
                                Text("Clear Filter")
                                    .font(.Medium10)
                                    .foregroundColor(.white)
                            }
                        Button(action:{
                            puVM.advancedFilterCheck()
                        }){
                            Text("Apply Filter")
                                .font(.Medium10)
                                .foregroundColor(.white)
                        }.frame(height: 34)
                            .padding(.horizontal, 30)
                            .background(LinearGradient.secondaryGradient)
                            .cornerRadius(10)
                        }
                    .padding(.trailing, 20)
                        
                }.padding(.top,25)
            }
         .frame(maxWidth: .infinity,alignment: .leading)
         .padding(.top,10)
        }.frame(maxWidth: .infinity)
           .frame(height: 325)
            .background(Color.detailbg)
            .cornerRadius(17)
            .padding(.horizontal,25)
    }
}
struct InterNetConnect : View {
    var body: some View {
        VStack{
            Text("Please Check Your Internet Connection")
                .foregroundColor(.white)
        }.frame(width: 200,height: 250)
            .background(Color.gray)
            .cornerRadius(10)
    }
}
