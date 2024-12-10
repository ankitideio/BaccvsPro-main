//
//  SignupView.swift
//  Baccvs iOS
//
//  Created by pm on 31/01/2023.

import SwiftUI
struct SignupView: View {
    @StateObject var sVM = SignupViewModel()
    @State var dateOfBirth = Date.now
    @Environment(\.presentationMode) var presentationMode
    var reffralCode: String = ""
    var phoneNumber: String = ""
    @State var termsOfServices : Bool = false
    @State var termsOfServicesActive : Bool = false
    private var isEmailValid: Bool {
        isValidEmail(sVM.signup.email)
    }
    

    private var isCompleteButtonEnabled: Bool {
           !sVM.signup.name.isEmpty &&
           !sVM.signup.email.isEmpty &&
           !sVM.signup.instagram.isEmpty &&
           !sVM.signup.description.isEmpty &&
           !sVM.signup.password.isEmpty &&
           !sVM.confirmpassword.isEmpty
       }
    
    @State private var showAlert = false
    @State private var alertMessage = ""

     var body: some View {
         ZStack{
             VStack{
                 ScrollView( .vertical ,showsIndicators: false){
                     VStack(spacing: 10)
                     {
                         Text("Signup")
                             .font(.Medium32)
                             .foregroundColor(.white)
                         Text("Please fill out the form.")
                             .foregroundColor(.lightTextColor)
                             .font(.Regular14)
                     }
                     VStack(spacing:10){
                         TextField("", text: $sVM.signup.name)
                             .placeholder(when: sVM.signup.name.isEmpty) {
                                 Text("Name").foregroundColor(.gray)
                                     .font(.Regular14)
                             }.foregroundColor(.white)
                             .padding()
                             .frame(height: TextFieldHeight)
                             .background(Color.textfieldColor)
                             .cornerRadius(24)
                         
                         HStack{
                             TextField("", text: $sVM.signup.email)
                                 .placeholder(when: sVM.signup.email.isEmpty) {
                                     Text("Email Address").foregroundColor(.gray)
                                         .font(.Regular14)
                                 }.foregroundColor(.white)
                                 .padding()
                                 
                             if sVM.signup.email.isEmpty == false {
                                 Image(systemName: isEmailValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                                     .foregroundColor(isEmailValid ? .green : .red)
                                     .padding(.trailing,20)
                             }
                             
                         }.frame(height: TextFieldHeight)
                             .background(Color.textfieldColor)
                             .cornerRadius(24)
                         
                         
                         HStack{
                             DatePicker("Date of Birth", selection: $dateOfBirth,displayedComponents: [.date])
                                 .font(.Regular14)
                                 .foregroundColor(.gray)
                                 .padding()
                                 .accentColor(.textfieldColor)
                                 .environment(\.colorScheme, .dark)
                             
                         }.background(Color.textfieldColor)
                             .padding()
                             .frame(height: TextFieldHeight)
                             .background(Color.textfieldColor)
                             .cornerRadius(24)
                         TextField("", text: $sVM.signup.instagram)
                             .placeholder(when: sVM.signup.instagram.isEmpty) {
                                 Text("Instagram Username").foregroundColor(.gray)
                                     .font(.Regular14)
                             }.foregroundColor(.white)
                             .padding()
                             .frame(height: TextFieldHeight)
                             .background(Color.textfieldColor)
                             .cornerRadius(24)
                     }.padding(.horizontal,30)
                     VStack(spacing:10){
                             Text("Please use an instagram account that is most representative of your online identity as it will be used for verification purposes.")
                                 .multilineTextAlignment(.leading)
                                 .font(.Regular12)
                                 .foregroundColor(.lightTextColor)
                             
      
                             HStack{
                                 Button(action:{
                                     sVM.signup.gender = "Male"
                                 }){
                                     Text("Male")
                                         .font(.Regular14)
                                         .foregroundColor(sVM.signup.gender == "Male" ?  .white : .lightTextColor)
                                         .frame(maxWidth: .infinity)
                                 }.frame(width: 152,height:TextFieldHeight)
                                     .background(sVM.signup.gender == "Male" ? .ChatTextFieldColor : Color.textfieldColor)
                                     .cornerRadius(24)
                                 Spacer()
                                 Button(action:{
                                     sVM.signup.gender = "Female"
                                 }){
                                     Text("Female")
                                         .font(.Regular14)
                           .foregroundColor(sVM.signup.gender == "Female" ?  .white : .lightTextColor)
                                         .frame(maxWidth: .infinity)
                                 }.frame(width: 152,height: TextFieldHeight)
                  .background(sVM.signup.gender == "Female" ? .ChatTextFieldColor : Color.textfieldColor)
                                     .cornerRadius(24)
                                 
                             }
                         Text("Description")
                             .foregroundColor(.white)
                             .font(.Regular14)
                             .foregroundColor(.secondarytextColor)
                         TextEditor(text: $sVM.signup.description)
                             .font(.Regular14)
                             .frame(maxWidth: .infinity)
                             .frame(height: 162)
                             .scrollContentBackground(.hidden)
                             .background(Color.textfieldColor)
                             .foregroundColor(.white)
                             .cornerRadius(24)
                         
                         HStack{
                             CustomSecreField(text: $sVM.signup.password)
                                 .placeholder(when: sVM.signup.password.isEmpty) {
                                     Text("password").foregroundColor(.lightTextColor)
                                         .font(.Regular14)
                                 }.foregroundColor(.white)
                             
                         }.padding()
                             .frame(height: TextFieldHeight)
                             .background(Color.textfieldColor.cornerRadius(24))
                         
                         HStack{
                             CustomSecreField(text: $sVM.confirmpassword)
                                 .placeholder(when: sVM.confirmpassword.isEmpty) {
                                     Text("Confirm password").foregroundColor(.lightTextColor)
                                         .font(.Regular14)
                                 }.foregroundColor(.white)
                             
                         }.padding()
                             .frame(height: TextFieldHeight)
                             .background(Color.textfieldColor.cornerRadius(24))
                           
                         
                         HStack{
                            Button {
                               termsOfServices.toggle()
                           } label: {
                               Image(systemName: "checkmark")
                                   .renderingMode(.template)
                                   .foregroundColor(termsOfServices ? .white : .gray)
                                   
                                   
                                   
                           }.frame(width: 24, height: 24)
                                 
                                 .background(termsOfServices ? Color.bg1 : Color.gray)
                                 .cornerRadius(5)
                             Button {
                                 termsOfServicesActive.toggle()
                             } label: {
                                 Text("Terms and conditions Accept.")
                                     .foregroundColor(.white)
                                     .font(.Regular14)
                             }

//                             Text("Terms and conditions Accept.")
                                 
                             
                         }.frame(maxWidth: .infinity,alignment : .leading)

                             NavigationLink(destination: SelectProfileImage(), isActive: $sVM.isComplete ){
                                 
                             }
                             Button(action:{
                                 sVM.signup.deviceToken = "gh"
                                 sVM.isComplete = true
                                 if termsOfServices{
                                     print(isCompleteButtonEnabled && termsOfServices)
                                     if sVM.confirmpassword == sVM.signup.password{
                                         sVM.signup.referralCodeByNextUser = reffralCode
                                         sVM.signup.phoneNumber = phoneNumber
                                         sVM.signup.dateOfBirth = dateOfBirth.toString()
                                         sendEmailAlert()
                                         sVM.Signup()
                                         
                                     }else {
                                         sVM.isComplete = false
                                         sVM.showAlert = true
                                         showAlert = true
                                         alertMessage = "Passwords Do Not Match. Match Your Password"
                                       
                                     }
                                 }else {
                                     sVM.isComplete = false
                                     sVM.showAlert = true
                                     showAlert = true
                                     alertMessage = "Please Accept Terms and Conditions to Continue"
                                 }
                             }){
                                 Text("Complete")
                                     .font(.Medium16)
                                     .foregroundColor(.white)
                                     .frame(maxWidth: .infinity)
                             }.frame(height: 65)
                             .background(isCompleteButtonEnabled ? LinearGradient.secondaryGradient : LinearGradient.recBaseGradient)
                             .cornerRadius(60)
                             .disabled(!isCompleteButtonEnabled )
                            
                        
                         }.padding(.horizontal,30)

                 }.padding(.top,10)
                 Spacer()
             }.alert(isPresented: $sVM.showAlert, content: {
                 getAlert(alertType: sVM.alertType, message: sVM.message)
             })
             .onTapGesture {
                       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                   }
             .sheet (isPresented: $termsOfServicesActive){
                 WebView(url: URL(string: "https://www.baccvs.com/privacy-policy/")!)

                                     .ignoresSafeArea()
                                     .navigationTitle("Sarunw")
                                     .navigationBarTitleDisplayMode(.inline)
             }
             if sVM.showProgress{
                 ProgressView()
                     .foregroundColor(.white)
                     .frame(maxWidth: .infinity, maxHeight: .infinity)
                     .background(Color.black.opacity(0.5))
                     .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
             }
         }.alert(isPresented: $showAlert) {
             Alert(title: Text("Invalid Signup"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
         }
        .frame(maxWidth: .infinity)
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
                    VStack{
                        ProgressBar(progress: (UIScreen.main.bounds.width * 0.8) - 45)
                    }

                }

            }
    
    }
    
    func sendEmailAlert() {
        if !isValidEmail(sVM.signup.email) {
            showAlert = true
            alertMessage = "Invalid Email Address. Please enter a correct format."
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
   
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(reffralCode: "", phoneNumber: "")
    }
}


struct CustomSecreField: View{
    @State var isSecuredField : Bool = true
    @Binding var text :String
    var body: some View{
        HStack{
            if isSecuredField{
                SecureField("",text: $text)
            }else{
                TextField("", text: $text)
            }
        } .overlay(alignment:.trailing){
            Image(systemName: isSecuredField ? "eye.slash" : "eye")
                .frame(width: 14,height: 14)
                .foregroundColor(.gray)
                .onTapGesture {
                    isSecuredField.toggle()
                }
        }
          
    }
}
struct TermsAndConditionsWeb : View{
    var body: some View {
        Link("DevTechie", destination: URL(string: "https://www.baccvs.com/privacy-policy/")!)
    }
}
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    // 1
    let url: URL

    
    // 2
    func makeUIView(context: Context) -> WKWebView {

        return WKWebView()
    }
    
    // 3
    func updateUIView(_ webView: WKWebView, context: Context) {

        let request = URLRequest(url: url)
        webView.load(request)
    }
}
