//
//  SelectProfileImage.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 11/02/2023.
//

import SwiftUI
struct SelectProfileImage: View {
    @StateObject var seVM = UpdateProfileViewModel()
//    @State private var showPicker = false
//    @State private var croppedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            VStack{
                VStack(spacing: 10){
                    Text("Signup")
                        .font(.Medium32)
                        .foregroundColor(.white)
                    Text("Please fill out the form.")
                        .foregroundColor(.lightTextColor)
                        .font(.Regular14)
                }.padding(.top,30)
                .padding(.bottom, 10)
                if (seVM.croppedImage != nil){
                    Image(uiImage: seVM.croppedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 400)
                        .cornerRadius(20)
                    NavigationLink( destination: Offersviewsheet(), isActive: $seVM.isComp){
                        
                    }
                    
                    Button(action:{
                        seVM.updateProfileModel.file = Media(part_vedio_url: seVM.croppedImage?.jpegData(compressionQuality: 1.0) ?? Data(), mimeType: "image/jpeg", fileName: "\(arc4random()).jpeg", paramName: "file")
                        seVM.updateProfile()
                    }){
                        Text("Complete")
                            .font(.Medium16)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    } .frame(height:65)
                        .background(LinearGradient.secondaryGradient)
                        .cornerRadius(60)
                        .padding(.horizontal, 30)
                }else{
                    Button {
                        seVM.showPicker.toggle()
                    } label: {
                        Text("Please select your profile image")
                            .font(.Medium16)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }.frame(height:65)
                        .background(LinearGradient.secondaryGradient)
                        .cornerRadius(60)
                        .padding(.horizontal, 30)
                        .padding(.top,30)
                    
                }
                Spacer()
                    .frame(maxWidth: .infinity)
            }.alert(isPresented: $seVM.showAlert, content: {
                getAlert(alertType: seVM.alertType, message: seVM.message)
            })
            if seVM.showProgress{
                ProgressView()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
            }
           
        } .navigationBarBackButtonHidden(true)
            .enableLightStatusBar()
            .background(bgView())
            .cropImagePicker(
                options: [.square],
                show: $seVM.showPicker,
                croppedImage: $seVM.croppedImage
            )
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Image("leftarrow")
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                ToolbarItem(placement: .principal){
                    VStack{
                        ProgressBar(progress: (UIScreen.main.bounds.width * 1) - 45)
                    }
                    
                }
            }
    }
}

struct SelectProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        SelectProfileImage()
    }
}
