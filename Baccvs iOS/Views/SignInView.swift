//
//  SignInView.swift
//  Baccvs iOS
//
//  Created by pm on 17/02/2023.
//
import UIKit
import SwiftUI
import Combine
import Connectivity
struct SignInView: View {
    @AppStorage("isLogedIn") var isLogedIn : Bool = Bool()
    @StateObject var lVM = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var isConnectedToInternet = true
    private let connectivity = Connectivity()
    private var isLoginButtonEnabled: Bool {
           !lVM.loginModel.username.isEmpty && !lVM.loginModel.password.isEmpty
       }
    private var isEmailValid: Bool {
        isValidEmail(lVM.loginModel.username)
    }
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    TextField("", text: $lVM.loginModel.username)
                        .placeholder(when: lVM.loginModel.username.isEmpty) {
                            Text("Touri.said@hotmail.com").foregroundColor(.gray)
                                .font(.Regular14)
                        }.foregroundColor(.white)
                        .padding()
                        
                    if lVM.loginModel.username.isEmpty == false {
                        Image(systemName: isEmailValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(isEmailValid ? .green : .red)
                            .padding(.trailing,20)
                    }
                    
                }.frame(height: TextFieldHeight)
                    .background(Color.textfieldColor)
                    .cornerRadius(24)
                HStack{
                    CustomSecreField(text: $lVM.loginModel.password)
                        .placeholder(when: lVM.loginModel.password.isEmpty) {
                            Text("SaidBacc94!").foregroundColor(.lightTextColor)
                                .font(.Regular14)
                        }.foregroundColor(.white)
                    
                }.padding()
                    .frame(height: TextFieldHeight)
                    .background(Color.textfieldColor.cornerRadius(24))
                    .padding(.top,20)
                NavigationLink( destination: TabNavPage() , isActive: $lVM.isClient ){
                    
                }
                NavigationLink( destination: HomePage() , isActive: $lVM.isAdm ){
                
                }

                Button(action:{
                    sendEmailAlert()
                        if isEmailValid {
                            checkInternetConnection()
                                       }
                }){
                    Text("Login")
                        .font(.Medium16)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Invalid Sign In"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .frame(height:65)
                    .background(isLoginButtonEnabled ? LinearGradient.secondaryGradient : LinearGradient.recBaseGradient)
                    .cornerRadius(60)
                    .padding(.top,100)
                    .disabled(!isLoginButtonEnabled)
                    
                
            }
            .padding(.top,100)
                .padding(.horizontal,25)
                .onTapGesture {
                          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                      }
            if lVM.showProgress{
                ProgressView()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
            }
        }
        .alert(isPresented: $lVM.showAlert, content: {
            getAlert(alertType: lVM.alertType, message: lVM.message)
        })
        .onAppear(perform: startMonitoringInternetConnection)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $lVM.isLogedIn, destination: {
                if lVM.isAdmin == 1 {
                    HomePage()
                }else {
                    TabNavPage()
                }
            })
            .background(bgView())
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Image("leftarrow")
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                ToolbarItem(placement: .principal){
                    VStack{
                        Text("Sign in")
                            .foregroundColor(.white)
                            .font(.Medium20)
                    }
                }
            }
        
    }
    
    func sendEmailAlert() {
        if !isValidEmail(lVM.loginModel.username) {
            showAlert = true
            alertMessage = "Invalid Email Address. Please Enter a Correct Format."
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    
    func checkInternetConnection() {
        isConnectedToInternet = connectivity.isConnected
        if !isConnectedToInternet {
            showAlert = true
            alertMessage = "No internet connection. Please check your network settings."
        } else {
            lVM.userLogin { log in
                // Handle successful login
            }
        }
    }

    func startMonitoringInternetConnection() {
        connectivity.framework = .network
        connectivity.whenConnected = { _ in
            isConnectedToInternet = true
        }
        connectivity.whenDisconnected = { _ in
            isConnectedToInternet = false
        }
        connectivity.startNotifier()
    }


}
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
