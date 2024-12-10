//
//  GroupPhotoView.swift
//  Baccvs iOS
//
//  Created by meet sharma on 22/12/23.
//

import SwiftUI

struct GroupPhotoView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var referralVM = CheckReferralCodeViewMode()
    @State private var images: [String] = ["image2", "image1"]
    let columns = [
          GridItem(.flexible()),
          GridItem(.flexible())
      ]
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 15) {
                    Text("Add photos")
                        .font(.Medium20)
                        .foregroundColor(Color(hex: "#FFFFFF"))

                    Text("Add at least 3 pictures or videos to complete your profile. Any profile that doesn’t represent the user can be banned.")
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .font(.Regular14)
                        .foregroundColor(Color(hex: "#B69CFF"))
                        .multilineTextAlignment(.center)
                    
                    HStack(spacing:10) {
                        Spacer()
                        Button(action: {
                            
                        }) {
                            
                            ZStack {
                              
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(style: StrokeStyle(lineWidth: 8, dash: [5]))
                                    .frame(width: UIScreen.main.bounds.width/3-16, height: 144)
//                                    .background(Color(hex: "#21262E"))
                                    .background(
                                                   Image("image3")
                                                       .resizable()
                                                       .aspectRatio(contentMode: .fill)
                                               )
                                    .cornerRadius(8)
                                    .foregroundColor(Color(hex: "#3C444F"))
                                VStack {
                                    Spacer()
                                       Image("cross 1")
                                      .resizable()
                                      .aspectRatio(contentMode: .fit)
                                       .frame(width: 28, height: 28)
                                       .padding(.bottom,-12)
                                        }
                                    
                            }
                           
                        }
                        Button(action: {
                            
                        }) {
                            
                            ZStack {
                              
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(style: StrokeStyle(lineWidth: 8, dash: [5]))
                                    .frame(width: UIScreen.main.bounds.width/3-16, height: 144)
//                                    .background(Color(hex: "#21262E"))
                                    .background(
                                                   Image("image4")
                                                       .resizable()
                                                       .aspectRatio(contentMode: .fill)
                                               )
                                    .cornerRadius(8)
                                    .foregroundColor(Color(hex: "#3C444F"))
                                VStack {
                                    Spacer()
                                       Image("cross 1")
                                      .resizable()
                                      .aspectRatio(contentMode: .fit)
                                       .frame(width: 28, height: 28)
                                       .padding(.bottom,-12)
                                        }
                                    
                            }
                           
                        }
                       
                        Button(action: {
                            
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(style: StrokeStyle(lineWidth: 8, dash: [5]))
                                    .frame(width: UIScreen.main.bounds.width/3-16, height: 144)
                                    .background(Color(hex: "#21262E"))
                                    .cornerRadius(8)
                                    .foregroundColor(Color(hex: "#3C444F"))
                                Image("plus")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 28, height: 28)
                            }
                        }
                        Spacer()
                    }.frame(width: UIScreen.main.bounds.width-16)
                        .padding(.top,20)
                    HStack(spacing: 10) {
                        Spacer()
                        Button(action: {
                      
                        }) {
                            CustomButton()
                        }
            
                        Button(action: {
               
                        }) {
                            CustomButton()
                        }

                        Button(action: {
                
                        }) {
                            CustomButton()
                        }
                        
                        Spacer()
                    }.frame(width: UIScreen.main.bounds.width,alignment: .center)
                        .padding(.top,10)
                       
                   
                    Button(action:{
                       
                     }){
                         NavigationLink(destination: Offersviewsheet(), label: {
                             Text("Complete")
                             .font(.Medium16)
                             .foregroundColor(Color(hex: "#CD3AFF"))
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
                     .padding(.top,100)
                }
            }
            .disabled(referralVM.showProgress)
            .padding(.top, 30)
            .alert(isPresented: $referralVM.showAlert) {
                getAlert(alertType: referralVM.alertType, message: referralVM.message)
            }

            if referralVM.showProgress {
                ProgressView()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image("leftarrow")
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            ToolbarItem(placement: .principal) {
                VStack {
                    ProgressBar(progress: (UIScreen.main.bounds.width * 0.95) - 40)
                }
            }
        }
        .background(bgView())
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
    }

    func removeImage(imageName: String) {
        images.removeAll { $0 == imageName }
    }
}

struct GroupPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        GroupPhotoView()
    }
}
struct CustomButton: View {
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 8)
                .stroke(style: StrokeStyle(lineWidth: 8, dash: [5]))
                .frame(width: UIScreen.main.bounds.width/3-16, height: 144,alignment: .center)
                .background(Color(hex: "#21262E"))
                .cornerRadius(8)
                .foregroundColor(Color(hex: "#3C444F"))

            Image("plus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 28, height: 28)
        }
    }
}
