//
//  SignupDetailView.swift
//  Baccvs iOS
//
//  Created by IDEIO SOFT on 19/12/23.
//

import SwiftUI


struct SignupDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var referralVM = CheckReferralCodeViewMode()
    @State private var fullName: String = String()
    @State private var emailAddress: String = String()
    @State private var dateOfBirth: String = String()
    @State private var instagramUserName: String = String()
    @State private var languageSpoken: String = String()
    @State private var password: String = String()
    @State private var confirmPassword: String = String()
    @State private var images: [String] = ["image2", "image1"]
    var body: some View {
        
        
        ZStack{
            ScrollView{
                VStack{
                    Spacer()
                    VStack(spacing:15){
                        Text("Sign up")
                            .font(.Medium20)
                            .foregroundColor(.white)
                        Text("Please fill out the form.")
                            .font(.Regular14)
                            .foregroundColor(.lightTextColor)
                      
                        TextField("", text: $fullName)
                            .placeholderPhone(when: fullName.isEmpty) {
                                Text("Full Name").foregroundColor(Color(hex: "#B5B4C8"))
                                    .font(.Regular16)
                            }
                            .font(.Regular16)
                            .background(Color.clear)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width-60,height: 62)
                            
                            
                                .background(
                                       LinearGradient(
                                           gradient: Gradient(
                                               colors: [
                                                Color(hex: "#CD3AFF").opacity(0.3),
                                                   Color(hex: "#000000").opacity(1.0)
                                               ]
                                           ),
                                           startPoint: .top,
                                           endPoint: .bottom
                                       )
                                       .mask(Rectangle())
                                   )
                                        
                            .foregroundColor(Color(hex: "#B5B4C8"))
                               .cornerRadius(24)
                               .padding(.top, 50)
                               
                      
                        TextField("", text: $emailAddress)
                            .placeholderPhone(when: emailAddress.isEmpty) {
                                Text("Email Address").foregroundColor(Color(hex: "#B5B4C8"))
                                    .font(.Regular16)
                            }
                            .font(.Regular16)
                            .background(Color.clear)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width-60,height: 62)
                            
                            
                                .background(
                                       LinearGradient(
                                           gradient: Gradient(
                                               colors: [
                                                Color(hex: "#CD3AFF").opacity(0.3),
                                                   Color(hex: "#000000").opacity(1.0)
                                               ]
                                           ),
                                           startPoint: .top,
                                           endPoint: .bottom
                                       )
                                       .mask(Rectangle())
                                   )
                                        
                            .foregroundColor(Color(hex: "#B5B4C8"))
                               .cornerRadius(24)
                               .padding(.top,0)
                              
                        
                        TextField("", text: $dateOfBirth)
                            .placeholderPhone(when:dateOfBirth.isEmpty) {
                                Text("Date of Birth").foregroundColor(Color(hex: "#B5B4C8"))
                                    .font(.Regular16)
                            }
                            .font(.Regular16)
                            .background(Color.clear)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width-60,height: 62)
                            
                            
                                .background(
                                       LinearGradient(
                                           gradient: Gradient(
                                               colors: [
                                                Color(hex: "#CD3AFF").opacity(0.3),
                                                   Color(hex: "#000000").opacity(1.0)
                                               ]
                                           ),
                                           startPoint: .top,
                                           endPoint: .bottom
                                       )
                                       .mask(Rectangle())
                                   )
                                        
                            .foregroundColor(Color(hex: "#B5B4C8"))
                               .cornerRadius(24)
                               .padding(.top,0)
                               
                        
                        TextField("", text: $instagramUserName)
                            .placeholderPhone(when:instagramUserName.isEmpty) {
                                Text("Instagram username").foregroundColor(Color(hex: "#B5B4C8"))
                                    .font(.Regular16)
                            }
                            .font(.Regular16)
                            .background(Color.clear)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width-60,height: 62)
                            
                            
                                .background(
                                       LinearGradient(
                                           gradient: Gradient(
                                               colors: [
                                                Color(hex: "#CD3AFF").opacity(0.3),
                                                   Color(hex: "#000000").opacity(1.0)
                                               ]
                                           ),
                                           startPoint: .top,
                                           endPoint: .bottom
                                       )
                                       .mask(Rectangle())
                                   )
                                        
                            .foregroundColor(Color(hex: "#B5B4C8"))
                               .cornerRadius(24)
                               .padding(.top, 0)
                               
                        
                        Text("Please use an instagram account that is most representative of your online identity as it will be used for verification purposes.")
                            .font(.Regular12)
                            .foregroundColor(Color(hex: "#8F8F8F"))
                            .frame(width: UIScreen.main.bounds.width-60, alignment: .center)
                        HStack(spacing:20) {
                            Spacer()
                            
                            Button("", action:{
                                
                            })
                               Text("Male")
                               .font(.Regular16)
                               .frame(width: UIScreen.main.bounds.width/2-42,height:62)
                               .foregroundColor(Color(hex: "#B9B9B9"))
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(
                                            colors: [
                                                Color(hex: "#CD3AFF").opacity(0.3),
                                                Color(hex: "#000000").opacity(1.0)
                                            ]
                                        ),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                    .mask(Rectangle())
                                )
                                .cornerRadius(15)
                            Button("", action:{
                                
                            })
                            Text("Female")
                            .font(.Regular16)
                            .frame(width: UIScreen.main.bounds.width/2-42,height:62)
                            .foregroundColor(Color(hex: "#B9B9B9"))
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(
                                            colors: [
                                                Color(hex: "#CD3AFF").opacity(0.3),
                                                Color(hex: "#000000").opacity(1.0)
                                            ]
                                        ),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                    .mask(Rectangle())
                                )
                                .cornerRadius(15)
                            Spacer()
                        }
                        Text("Description")
                            .font(.Medium20)
                            .foregroundColor(Color(hex: "#B9B9B9"))
                            .padding(.top, 20)
                        
                        MultiTextField().frame(width: UIScreen.main.bounds.width-100, height: 177, alignment: .center)
                            .font(.Regular24)
                            .padding(20)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: [
                                            Color(hex: "#CD3AFF").opacity(0.3),
                                            Color(hex: "#000000").opacity(1.0)
                                        ]
                                    ),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .mask(Rectangle())
                            )
                        
                            .cornerRadius(15)
                            .padding(.top,10)
                        
                        TextField("", text: $languageSpoken)
                            .placeholderPhone(when:languageSpoken.isEmpty) {
                                Text("Languages spoken").foregroundColor(Color(hex: "#B5B4C8"))
                                    .font(.Regular16)
                            }
                            .font(.Regular16)
                            .background(Color.clear)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width-60,height: 62)
                            
                            
                                .background(
                                       LinearGradient(
                                           gradient: Gradient(
                                               colors: [
                                                Color(hex: "#CD3AFF").opacity(0.3),
                                                   Color(hex: "#000000").opacity(1.0)
                                               ]
                                           ),
                                           startPoint: .top,
                                           endPoint: .bottom
                                       )
                                       .mask(Rectangle())
                                   )
                                        
                            .foregroundColor(Color(hex: "#B5B4C8"))
                               .cornerRadius(24)
                               .padding(.top, 0)
                              
                        
                        TextField("", text: $password)
                            .placeholderPhone(when: password.isEmpty) {
                                Text("Password").foregroundColor(Color(hex: "#B5B4C8"))
                                    .font(.Regular16)
                            }
                            .font(.Regular16)
                            .background(Color.clear)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width-60,height: 62)
                            
                            
                                .background(
                                       LinearGradient(
                                           gradient: Gradient(
                                               colors: [
                                                Color(hex: "#CD3AFF").opacity(0.3),
                                                   Color(hex: "#000000").opacity(1.0)
                                               ]
                                           ),
                                           startPoint: .top,
                                           endPoint: .bottom
                                       )
                                       .mask(Rectangle())
                                   )
                                        
                            .foregroundColor(Color(hex: "#B5B4C8"))
                               .cornerRadius(24)
                               .padding(.top, 0)
                              
                        
                        TextField("", text: $confirmPassword)
                            .placeholderPhone(when:confirmPassword.isEmpty) {
                                Text("Confirm Password").foregroundColor(Color(hex: "#B5B4C8"))
                                    .font(.Regular16)
                            }
                            .font(.Regular16)
                            .background(Color.clear)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width-60,height: 62)
                            
                            
                                .background(
                                       LinearGradient(
                                           gradient: Gradient(
                                               colors: [
                                                Color(hex: "#CD3AFF").opacity(0.3),
                                                   Color(hex: "#000000").opacity(1.0)
                                               ]
                                           ),
                                           startPoint: .top,
                                           endPoint: .bottom
                                       )
                                       .mask(Rectangle())
                                   )
                                        
                            .foregroundColor(Color(hex: "#B5B4C8"))
                               .cornerRadius(24)
                               .padding(.top, 0)
                               
                        
//                        Text("Add atleast 3 pictures to complete your profile.Any profile that doesn’t represent the user can be banned.")
//                            .font(.Regular12)
//                            .foregroundColor(Color(hex: "#8F8F8F"))
//                            .frame(width: UIScreen.main.bounds.width-60, alignment: .center)
//                        
//                        HStack(spacing:0) {
//                            Spacer()
//                            Button(action: {
//                                
//                            }) {
//                                ZStack {
//                                    RoundedRectangle(cornerRadius: 15)
//                                        .stroke(style: StrokeStyle(lineWidth: 8, dash: [5]))
//                                        .frame(width: 107, height: 123)
//                                        .background(Color(hex: "#21262E"))
//                                        .cornerRadius(15)
//                                        .foregroundColor(Color(hex: "#3C444F"))
//                                    Image("plus")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(width: 28, height: 28)
//                                }
//                            }
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                HStack(spacing: 10) {
//                                    ForEach(images, id: \.self) { imageName in
//                                        Image(imageName)
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fill)
//                                            .frame(width: 107, height: 123)
//                                            .cornerRadius(10)
//                                            .overlay(
//                                                Button(action: {
//                                                    removeImage(imageName: imageName)
//                                                }) {
//                                                    Image(uiImage: UIImage(named: "cross 1") ?? UIImage())
//                                            
//                                                }
//                                            .padding(.top, 123)
//                                            
//                                            )
//                                    }
//                                }
//                                .padding()
//                            }
//                            Spacer()
//                        }
//                        .padding(40)
                        Button(action:{
                           
                         }){
                             NavigationLink(destination: GroupPhotoView(), label: {
                                 Text("Continue")
                                 .font(.Medium16)
                                 .foregroundColor(.white)
                             })
                            
                         }
                      
                        .frame(width: UIScreen.main.bounds.width-60,height:65)
                             .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color(hex: "#5F09AF"),Color(hex: "#291846")]),
                                            startPoint: UnitPoint(x: 0.9, y: 0.5),
                                            endPoint: UnitPoint(x: 0.1, y: 0.5)
                                        )
                                    )
                         .cornerRadius(5)
                         .padding(.top,70)
                    }
                    
                    .disabled(referralVM.showProgress)
                    
                    Spacer()
                } .padding(.top,30)
                    .alert(isPresented: $referralVM.showAlert, content: {
                        getAlert(alertType: referralVM.alertType, message: referralVM.message)
                    })
                if  referralVM.showProgress{
                    ProgressView()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.5))
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Image("leftarrow")
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                ToolbarItem(placement: .principal){
                    VStack{
                        ProgressBar(progress: (UIScreen.main.bounds.width * 0.8) - 40)
                        
                    }
                    
                }
            }
            .background(bgView())
            .navigationBarHidden(false)
            
            .navigationBarBackButtonHidden(true)
            
        }
        
    }
//    func removeImage(imageName: String) {
//        images.removeAll { $0 == imageName }
//    }
    
}

#Preview {
    SignupDetailView()
}


struct MultiTextField:UIViewRepresentable{
    func makeCoordinator() -> Coordinator {
        return MultiTextField.Coordinator(parent1: self)
    }
   
    func makeUIView(context: UIViewRepresentableContext<MultiTextField>) -> UITextView {
        let view = UITextView()
        
        view.text = "Write a little bio to make people know you better."
        view.textColor = UIColor(Color(hex: "#B9B9B9"))
        view.backgroundColor = .clear
        
        view.delegate = context.coordinator
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true
        
        return view
    }
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiTextField>) {
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .black
        
    }
    func textViewDidChange(_ textView: UITextView) {
        
    }
    class Coordinator:NSObject,UITextViewDelegate{
        var parent: MultiTextField
        init (parent1:MultiTextField){
            parent = parent1
        }
        
    }
}



extension View {
    func placeholderSignUp<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .center,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
