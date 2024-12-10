//
//  PersonalProfilleDetailView.swift
//  Baccvs iOS
//
//  Created by pm on 15/02/2023.
//

import SwiftUI
import Combine
import Foundation
import UIKit
struct PersonalProfilleDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var dpVM =  CheckProfileViewModel()
    @StateObject var upVM =  UpdateProfileInformViewModel()
    @State  var selectedPricing: String = ""

    var body: some View {
        ZStack{
            VStack{
                ScrollView(.vertical,showsIndicators: false){
                    VStack(spacing:20){
                        VStack(alignment: .leading,spacing:5){
                            HStack{
                                Image("profileic")
                                TextField("", text: $dpVM.checkprofileModel.body.name)
                                    .foregroundColor(.white)
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 19).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(0.5)))
                            }
                        }
                        VStack(alignment:.leading,spacing:5){
                            Text("Gender")
                                .padding(.horizontal,25)
                                .font(.Medium16)
                                .foregroundColor(.white)
                            HStack{
                                Image("maleorfemaleic")
                                TextField("", text:$dpVM.checkprofileModel.body.gender)
                                    .foregroundColor(.white)
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 19).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(0.5)))
                            }
                        }
                        VStack(alignment:.leading,spacing:5){
                            Text("Age")
                                .padding(.horizontal,25)
                                .font(.Medium16)
                                .foregroundColor(.white)
                            HStack{
                                Image("ageic")
                    Text("\(dpVM.checkprofileModel.body.dateOfBirth.age() ?? 0) years")
                                    .padding()
                                    .frame(maxWidth: .infinity,alignment : .leading)
                                    .foregroundColor(.white)
                                    .overlay(RoundedRectangle(cornerRadius: 19).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(0.5)))
                            }
                        }
                        
                        VStack(alignment:.leading,spacing:5){
                            Text("Zodiac")
                                .padding(.horizontal,25)
                                .font(.Medium16)
                                .foregroundColor(.white)
                            HStack{
                                Image("zodicic")
                                Menu {
                                    ForEach(dpVM.zodic, id: \.self) { item in
                                               Button {
                                                   dpVM.checkprofileModel.body.zodaic = item
                                               } label: {
                                                   Text( item)
                                               }
                                           }
                                       } label: {
                                           Text(dpVM.checkprofileModel.body.zodaic)
                                        .frame(maxWidth: .infinity,alignment:.leading)
                                               .foregroundColor(.white)
                                               .padding()
                                               .frame(maxWidth: .infinity)
                                               .frame(height: TextFieldHeight)
                                               .overlay(RoundedRectangle(cornerRadius: 19).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(0.5)))
                                       }
                            }
                        }
                        VStack(alignment:.leading,spacing:5){
                            Text("Location")
                                .padding(.horizontal,25)
                                .font(.Medium16)
                                .foregroundColor(.white)
                            HStack{
                                Image("locationicc")
                                TextField("", text:$dpVM.checkprofileModel.body.longitude)
                                    .foregroundColor(.white)
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 19).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(0.5)))
                            }
                        }
                        VStack(alignment:.leading,spacing:5){
                            Text("Job Title")
                                .padding(.horizontal,25)
                                .font(.Medium16)
                                .foregroundColor(.white)
                            HStack{
                                Image("jobicc")
                                TextField("", text:$dpVM.checkprofileModel.body.jobTitle)
                                    .foregroundColor(.white)
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 19).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(0.5)))
                            }
                        }
                        
                    }.padding(.horizontal,25)
                    Text("Select a Plan")
                        .font(.Medium16)
                        .foregroundColor(.secondaryColor)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.horizontal,25)
                        .padding(.top,20)
                    VStack{
                        VStack(alignment:.leading,spacing:5){
                            Text("Drinking")
                                .padding(.horizontal,25)
                                .font(.Medium16)
                                .foregroundColor(.white)
                            HStack{
                                Image("drinkicc")
                                Menu {
                                    ForEach(dpVM.drinking, id: \.self) { item in
                                               Button {
                                                   dpVM.checkprofileModel.body.drinking = item
                                               } label: {
                                                   Text(item)
                                               }
                                           }
                                       } label: {
                                Text(dpVM.checkprofileModel.body.drinking)
                                        .frame(maxWidth: .infinity,alignment:.leading)
                                               .foregroundColor(.white)
                                               .padding()
                                               .frame(maxWidth: .infinity)
                                               .frame(height: TextFieldHeight)
                                               .overlay(RoundedRectangle(cornerRadius: 19).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(0.5)))
                                       }
                            }
                        }
                        .padding(.horizontal,25)
                        VStack(alignment:.leading,spacing:5){
                            Text("Smoking")
                                .padding(.horizontal,25)
                                .font(.Medium16)
                                .foregroundColor(.white)
                            HStack{
                                Image("smokingic")
                                Menu {
                                    ForEach(dpVM.smoking, id: \.self) { item in
                                               Button {
                                                   dpVM.checkprofileModel.body.smoking = item
                                               } label: {
                                                   Text(item)
                                               }
                                           }
                                       } label: {
                                           Text(dpVM.checkprofileModel.body.smoking)
                                        .frame(maxWidth: .infinity,alignment:.leading)
                                               .foregroundColor(.white)
                                               .padding()
                                               .frame(maxWidth: .infinity)
                                               .frame(height: TextFieldHeight)
                                               .overlay(RoundedRectangle(cornerRadius: 19).stroke(lineWidth: 0.5).foregroundColor(Color.gray.opacity(0.5)))
                                       }
                            }
                        }
                        .padding(.horizontal,25)
                       Button(action:{
                           
                            upVM.updateProfiledetailModel.name = dpVM.checkprofileModel.body.name
                            upVM.updateProfiledetailModel.gender = dpVM.checkprofileModel.body.gender
                  upVM.updateProfiledetailModel.date_of_birth = dpVM.checkprofileModel.body.dateOfBirth
                            upVM.updateProfiledetailModel.zodaic = dpVM.checkprofileModel.body.zodaic
                            upVM.updateProfiledetailModel.longitude = dpVM.checkprofileModel.body.longitude
                            upVM.updateProfiledetailModel.job_title = dpVM.checkprofileModel.body.jobTitle
                            upVM.updateProfiledetailModel.drinking = dpVM.checkprofileModel.body.drinking
                            upVM.updateProfiledetailModel.smoking = dpVM.checkprofileModel.body.smoking
                            upVM.isUpdate = true
                            upVM.updateProfileInform()
                           
                        }){
                            Text("Update")
                                .font(.Medium16)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                        }.frame(height:65)
                            .background(LinearGradient.secondaryGradient)
                            .cornerRadius(60)
                            .padding(.horizontal,25)
                            .padding(.top,20)
                    }.alert(isPresented: $upVM.showAlert, content: {
                        getAlert(alertType: upVM.alertType, message: upVM.message)
                    })
                    .padding(.top,20)
                }.padding(.top,20)
            }
            if dpVM.showProgress{
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
                    VStack{
                        Text("Profile Details")
                            .font(.Regular18)
                            .foregroundColor(.white)
                    }
                }
            }
            .onAppear{
                dpVM.getCheckProfile()
            }
    }
}

struct PersonalProfilleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalProfilleDetailView()
    }
}


extension View {
    func alertTF(title: String,message: String,hintText: String,primaryTitle: String, secondaryTitle : String,primaryAction : @escaping(String)->(),secondaryAction:@escaping(String)->()){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField{  field in
            
            field.placeholder = hintText
            
        }
        
        alert.addAction(.init(title: secondaryTitle, style: .cancel, handler: { _ in
            
            secondaryAction("")
            
        }))
        
        
        alert.addAction(.init(title: primaryTitle, style: .default, handler: { _ in
            
            if let text = alert.textFields?[0].text{
                primaryAction(text)
            }
            else{
                primaryAction("")
            }
            
        }))
//        presentation Alert
        
        rootController().present(alert, animated: true, completion: nil )
    }
//    Root View Controller
    func rootController()->UIViewController{
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController  else {
            return .init()
        }
        
        return root
    }
}
