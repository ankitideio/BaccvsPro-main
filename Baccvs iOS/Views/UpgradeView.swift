//
//  UpgradeView.swift
//  Baccvs iOS
//  Created by pm on 08/02/2023.

//import SwiftUI
//import RevenueCat
//struct UpgradeView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State var currentOffring : Offering?
//    @StateObject var uVM = UpgrageViewModel()
//    @State var termsandCon = false
//    @State var privacyPol = false
//    @State var termsOfServicesActive : Bool = false
//    var body: some View {
//        ZStack{
//            VStack{
//                VStack(alignment: .leading,spacing: 50){
//                    Text("Be a top profile to get more plans.")
//                        .foregroundColor(.white)
//                        .font(.Medium24)
//                        .multilineTextAlignment(.leading)
//                    Text("Select a plan")
//                        .font(.Regular14)
//                        .foregroundColor(.white)
//
//                }.frame(maxWidth: .infinity,alignment: .leading)
//                .padding(.top,50)
//                .padding(.horizontal,25)
//                if currentOffring != nil{
//                    if uVM.isPro{
//                        VStack{
//                            Text("Purchased")
//                        }.frame(height: 100)
//                            .background(Color.green)
//                            .cornerRadius(15)
//                            .padding(.top,13)
//                    }else{
//                        ForEach(currentOffring?.availablePackages ?? []) { pkg in
//                            HStack{
//                                VStack(alignment: .leading, spacing:7){
//                                    Text("\(pkg.storeProduct.subscriptionPeriod?.periodTitle ?? "")")
//                                        .font(.Bold14)
//                                    .foregroundColor(.white)
//
//                                    Text("Total price \(pkg.storeProduct.localizedPriceString)")
//                                        .font(.Regular13)
//                                        .foregroundColor(.white)
//                                }
//                                .padding(.horizontal,17)
//                                Spacer()
//                                VStack(spacing:7){
//                                    Text("\(pkg.storeProduct.localizedPriceString)")
//                                        .font(.Bold14)
//                                    .foregroundColor(.white)
//
//                                    Text("Monthly")
//                                        .font(.Regular13)
//                                        .foregroundColor(.white)
//                                }
//                                .padding(.horizontal,17)
//                            }.frame(height: 100)
//                                .background(Color.textfieldColor)
//                                .cornerRadius(15)
//                                .padding(.top,13)
//                                .padding(.horizontal,25)
//                                .onTapGesture {
//                                    uVM.showProgress = true
//                                    Purchases.shared.purchase(package: pkg) { (transaction, customerInfo, error, userCancelled) in
//                                        if userCancelled, error == nil {
//                                            print("purchased")
//                                            uVM.showProgress = false
//                                            if customerInfo?.entitlements["pro"]?.isActive == true {
//                                                // Unlock that great "pro" content
//                                                uVM.isPro = true
//                                                uVM.isProModel.pro = true
//                                                uVM.isProprofile()
//
//                                            }else {
//                                                uVM.isProModel.pro = false
//                                                uVM.isProprofile()
//                                                uVM.showProgress = false
//                                            }
//                                        }
//                                        if error != nil{
//                                            uVM.showProgress = false
//                                        }
//
//                                    }
//                                }
//                        }
//                    }
//
//                }
//                Spacer()
//
//                Button(action:{
//                    Purchases.shared.restorePurchases { customerInfo, error in
//                        print(customerInfo)
//                        if customerInfo?.entitlements["pro"]?.isActive == true {
//                            // Unlock that great "pro" content
//                            uVM.isPro = true
//                            uVM.isProModel.pro = true
//                            uVM.isProprofile()
//
//                        }else {
//                            uVM.isProModel.pro = false
//                            uVM.isProprofile()
//                            uVM.showProgress = false
//                        }
//                    //... check customerInfo to see if entitlement is now active
//                    }
//                }){
//                    Text("Restore Purchase")
//                        .font(.Medium14)
//                        .foregroundColor(.white)
//                }
//                Text("You can manage and cancel your subscriptions by going to your Apple ID account settings after purchase.")
//                    .font(.Regular10)
//                    .foregroundColor(.white)
//                HStack{
//                    Button {
//                        termsandCon = false
//                        privacyPol = true
//                        termsOfServicesActive.toggle()
//
//                    } label: {
//                        Text("Privacy Policy")
//                            .font(.Medium10)
//                            .foregroundColor(.white)
//                    }
//
//                    Text("|")
//                        .foregroundColor(.white)
//                    Button {
//
//                        privacyPol = false
//                        termsandCon = true
//                        termsOfServicesActive.toggle()
//
//                    } label: {
//                        Text("Terms of Use")
//                            .font(.Medium10)
//                            .foregroundColor(.white)
//                    }
//                }.padding(.bottom, 20)
//
//            }.frame(maxWidth: .infinity,maxHeight: .infinity)
//                .navigationBarBackButtonHidden(true)
//                .background(bgView())
//                .onAppear{
//                    // Using Completion Blocks
//                    Purchases.shared.getCustomerInfo { (customerInfo, error) in
//                        // access latest customerInfo
//                        if customerInfo?.entitlements["pro"]?.isActive == true {
//                            uVM.isPro = true
//                            // Unlock that great "pro" content
//                            print("true")
//                        }
//                    }
//
//                    Purchases.shared.getOfferings { (offerings, error) in
//                        if let offerings = offerings?.current {
//                          // Display current offering with offerings.current
//                            currentOffring = offerings
//                            print(currentOffring?.availablePackages as Any)
//                      }
//                    }
//                }
//                .sheet (isPresented: $termsOfServicesActive){
//                    if termsandCon{
//                        WebView(url: URL(string: "https://www.baccvs.com/terms-of-use/")!)
//
//                                            .ignoresSafeArea()
//                                            .navigationTitle("Baccvs")
//                                            .navigationBarTitleDisplayMode(.inline)
//                    }else if privacyPol{
//                        WebView(url: URL(string: "https://www.baccvs.com/privacy-policy/")!)
//
//                                            .ignoresSafeArea()
//                                            .navigationTitle("Baccvs")
//                                            .navigationBarTitleDisplayMode(.inline)
//                    }
//
//                }
//                .toolbar{
//                    ToolbarItem(placement: .navigationBarLeading){
//                            Image("leftarrow")
//                            .onTapGesture {
//                                presentationMode.wrappedValue.dismiss()
//                            }
//
//             }
//                    ToolbarItem(placement: .principal){
//                      Text("Upgrade")
//                            .font(.Medium20)
//                            .foregroundColor(.white)
//
//                    }
//
//                }
//            if uVM.showProgress{
//                ProgressView()
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .background(Color.black.opacity(0.5))
//                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
//            }
//        }
//
//
//    }
//}
//
//struct UpgradeView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpgradeView()
//    }
//}



import SwiftUI
import RevenueCat
struct UpgradeView : View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isClicked = false
    @State var currentOffring : Offering?
    @StateObject var uVM = UpgrageViewModel()
    @State var termsandCon = false
    @State var privacyPol = false
    @State var termsOfServicesActive : Bool = false
    private var isEnabled: Bool {
           !isClicked == false
       }
    var texts = [
           "Enjoy Unlimited Events",
           "Private Your Profile",
           "Unlimited Messages",
           "Unlimited Profile Likes",
           "Unlimited Events Create",
           "Get Unlimited Followers",
           "Create Unlimited Groups"]
    var textsdef = [
           "Experience endless entertainment with Unlimited Events.",
           "Secure your privacy with Private Profile.",
           "Stay connected without limits with Unlimited Messages.",
           "Showcase your popularity with Unlimited Profile Likes",
           "Host events without restrictions with Unlimited Event Creation.",
           "Gain a massive following with Get Unlimited Followers.",
           "Build countless communities with Create Unlimited Groups."]
    var body: some View {
        ZStack{
            VStack{
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        Text("Become a Pro Member")
                            .foregroundColor(.white)
                            .font(.SemiBold20)
            Text("Enjoy more by getting access to all the feature s of the BACCVS APP")
                            .foregroundColor(.white)
                            .font(.Regular12)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .padding(.top,5)
                        if currentOffring != nil{
                            if uVM.isPro{
                                VStack{
                                    Text("Purchased")
                                }.frame(height: 100)
                                    .background(Color.green)
                                    .cornerRadius(15)
                                    .padding(.top,13)
                            }else{
                                ForEach(currentOffring?.availablePackages ?? []) { pkg in
                                    VStack(spacing: 20){
                                        HStack{
                                            Button(action:{}){
                                                HStack(spacing :5){
                                                    Image("tag")
                                                    Text("Special Offer")
                                                        .foregroundColor(.white)
                                                        .font(.Medium10)
                                                }
                                                .frame(maxWidth: .infinity)
                                            }.frame(width: 99,height : 28)
                                                .background( LinearGradient.secondaryGradient )
                                                .cornerRadius(40)
                                            
                                            Text("Save $15")
                                                .foregroundColor(.white)
                                                .font(.Regular11)
                                                .padding(.leading,15)
                                            Spacer()
                                            Image( isClicked ? "clickfill" : "empty" )
                                        }
                                        .padding(.horizontal,20)
                                        HStack(spacing :15){
                                            Text("\(pkg.storeProduct.subscriptionPeriod?.periodTitle ?? "")")
                                                .font(.SemiBold16)
                                                .foregroundColor(.white)
                                            Text("Total price \(pkg.storeProduct.localizedPriceString)")
                                                .font(.SemiBold16)
                                                .foregroundColor(.white)
                                        }
                                        .frame(maxWidth  : .infinity,alignment : .leading)
                                        .padding(.leading,20)
                                        HStack{
                                            Text("Billed monthly.")
                                            
                                                .font(.Regular13)
                                                .foregroundColor(.lightColor)
                                        }
                                        .frame(maxWidth  : .infinity,alignment : .leading)
                                        .padding(.leading,20)
                                        .padding(.bottom, 30)
                                     
                                    }.frame(width: 315, height: 135)
                                        .padding(.top,40)
                                        .background( Color.bgcolor)
                                        .cornerRadius(25)
                                        .shadow(color: .black.opacity(0.25), radius: 2, x: 2, y: 0)
                                        .overlay( RoundedRectangle(cornerRadius: 25)
                                            .inset(by: 0.5)
                                            .stroke(isClicked ? Color.activestroke : Color.black.opacity(0.01), lineWidth: 1))
                                        .onTapGesture{
                                            isClicked.toggle()
                                        }
                                    
                                    
                                    VStack{
                                         Text("Get all features")
                                             .font(.Medium16)
                                             .foregroundColor(.white)
                                             .frame(maxWidth: .infinity)
                                     }.frame(height:65)
                        .background(isEnabled ? LinearGradient.secondaryGradient : LinearGradient.recBaseGradient)
                                         .cornerRadius(60)
                                         .padding(.top,40)
                                         .onTapGesture {
                                             uVM.showProgress = true
                                             Purchases.shared.purchase(package: pkg) { (transaction, customerInfo, error, userCancelled) in
                                                 if userCancelled, error == nil {
                                                     print("purchased")
                                                     uVM.showProgress = false
                                                     if customerInfo?.entitlements["pro"]?.isActive == true {
                                                         // Unlock that great "pro" content
                                                         uVM.isPro = true
                                                         uVM.isProModel.pro = true
                                                         uVM.isProprofile()
                                                         
                                                     }else {
                                                         uVM.isProModel.pro = false
                                                         uVM.isProprofile()
                                                         uVM.showProgress = false
                                                     }
                                                 }
                                                 if error != nil{
                                                     uVM.showProgress = false
                                                 }
                                                 
                                             }
                                         }
                                         .padding(.horizontal,10)
                                         .disabled(!isEnabled)
                                        
                                    
                                }
                                
                            }
                        }
                      
                        
                            Text("What you will get")
                            .foregroundColor(.white)
                            .font(.SemiBold20)
                            .padding(.top,30)
          
                        ForEach(0..<6, id:\.self){ index in
                            HStack{
                                Image("alogo\(index + 1)")
                                VStack(spacing:6){
                                       Text(texts[index])
                                        .font(.SemiBold14)
                                        .foregroundColor(.white)
                                        .frame(maxWidth : .infinity,alignment : .leading)
                                    Text(textsdef[index])
                                        .multilineTextAlignment(.leading)
                                        .font(.Regular12)
                                        .foregroundColor(Color.lightColor)
                                        .frame(maxWidth : .infinity,alignment : .leading)
                                }
                            }
                        }.padding(.vertical,10)
                        
                        
                        Button(action:{
                            Purchases.shared.restorePurchases { customerInfo, error in
                                print(customerInfo)
                                if customerInfo?.entitlements["pro"]?.isActive == true {
                                    
                                    uVM.isPro = true
                                    uVM.isProModel.pro = true
                                    uVM.isProprofile()
                                    
                                }else {
                                    uVM.isProModel.pro = false
                                    uVM.isProprofile()
                                    uVM.showProgress = false
                                }
                            //... check customerInfo to see if entitlement is now active
                            }
                        }){
                            Text("Restore Purchase")
                                .font(.Medium14)
                                .foregroundColor(.white)
                        }
                        Text("You can manage and cancel your subscriptions by going to your Apple ID account settings after purchase.")
                            .font(.Regular10)
                            .foregroundColor(.white)
                        HStack{
                            Button {
                                termsandCon = false
                                privacyPol = true
                                termsOfServicesActive.toggle()
                                
                            } label: {
                                Text("Privacy Policy")
                                    .font(.Medium10)
                                    .foregroundColor(.white)
                            }
                            
                            Text("|")
                                .foregroundColor(.white)
                            Button {
                                
                                privacyPol = false
                                termsandCon = true
                                termsOfServicesActive.toggle()
                                
                            } label: {
                                Text("Terms of Use")
                                    .font(.Medium10)
                                    .foregroundColor(.white)
                            }
                        }.padding(.bottom, 20)
                     
                    }.padding(.horizontal,25)
                }
                .padding(.top,32)
            }
            if uVM.showProgress{
                ProgressView()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
            }
        } .background(bgView())
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Image("leftarrow")
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
    }
                ToolbarItem(placement: .navigationBarTrailing){
                  Image("badge")
                    
                }

            }
            .onAppear{
                // Using Completion Blocks
                Purchases.shared.getCustomerInfo { (customerInfo, error) in
                    // access latest customerInfo
                    if customerInfo?.entitlements["pro"]?.isActive == true {
                        uVM.isPro = true
                        // Unlock that great "pro" content
                        print("true")
                    }
                }
                
                Purchases.shared.getOfferings { (offerings, error) in
                    if let offerings = offerings?.current {
                      // Display current offering with offerings.current
                        currentOffring = offerings
                        print(currentOffring?.availablePackages as Any)
                  }
                }
            }
            .sheet (isPresented: $termsOfServicesActive){
                if termsandCon{
                    WebView(url: URL(string: "https://www.baccvs.com/terms-of-use/")!)

                                        .ignoresSafeArea()
                                        .navigationTitle("Baccvs")
                                        .navigationBarTitleDisplayMode(.inline)
                }else if privacyPol{
                    WebView(url: URL(string: "https://www.baccvs.com/privacy-policy/")!)

                                        .ignoresSafeArea()
                                        .navigationTitle("Baccvs")
                                        .navigationBarTitleDisplayMode(.inline)
                }
                
            }
    }
}

struct UpgradeView_Previews: PreviewProvider {
    static var previews: some View {
        UpgradeView()
    }
}
