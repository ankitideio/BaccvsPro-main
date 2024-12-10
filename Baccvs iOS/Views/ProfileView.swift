//
//  ProfileView.swift
//  Baccvs iOS
//
//  Created by pm on 13/02/2023.
import SwiftUI
import SDWebImageSwiftUI
struct ProfileView: View {
    private let columns : [GridItem] = [GridItem(.flexible()),GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var pdVM =  UserProfielDetailViewModel()
    @StateObject var ciVM =  CustomImageViewModel()
    @StateObject var fuVM =  FollowingViewModel()
    @StateObject var buVM =  BlockUserViewModel()
    @StateObject var ueVM =  PersonEventViewModel()
    @StateObject var reVM =  ReportEventViewModel()
    @StateObject var ufVM =  UnFollowViewModel()
    @StateObject var auVM = GetAllUsersViewModel()
    @StateObject var uVM  = UpgrageViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var isPrivate : Bool = false
    @State var showAlert = false
    @State  var showalert : Bool =  false
    var id : String

    var body: some View {
        ZStack{
            VStack{
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        VStack(spacing:10){
                            VStack{
                                AnimatedImage(url: URL(string: pdVM.getUserProfileModel.body.profileImageURL))
                                    .resizable()
                                    .placeholder {
                                        Rectangle().foregroundColor(.gray)
                                            .frame(width: 82,height: 89)
                                            .cornerRadius(23)
                                    }
                                    .scaledToFill()
                                    .transition(.fade)
                                    .frame(width: 82,height: 89)
                                    .cornerRadius(23)
                            }
                            HStack(spacing:25){
                                VStack{
                                    Text("Events")
                                        .foregroundColor(.white)
                                        .font(.Medium14)
                                    Text("\(pdVM.getUserProfileModel.body.events)")
                                        .font(.Regular14)
                                        .foregroundColor(.lightColor)
                                }
                                VStack{
                                    Text("Followers")
                                        .foregroundColor(.white)
                                        .font(.Medium14)
                                    Text("\(pdVM.getUserProfileModel.body.followers)")
                                        .foregroundColor(.lightColor)
                                        .font(.Regular14)
                                }
                                VStack{
                                    Text("Following")
                                        .foregroundColor(.white)
                                        .font(.Medium14)
                                    Text("\(pdVM.getUserProfileModel.body.following)")
                                        .foregroundColor(.lightColor)
                                        .font(.Regular14)
                                }
                            }
                            .padding(.top,15)
                            VStack{
                                Text(pdVM.getUserProfileModel.body.description)
                                    .font(.Regular10)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.white)
                                    .padding(.horizontal,26)
                            }
                        }
                        HStack(spacing: 20){
                            if uVM.isPro {
                                Button(action:{
                                      if fuVM.buttonText == "Follow" {
                                          fuVM.buttonText = "Unfollow"
                                          fuVM.followingModel.following = pdVM.getUserProfileModel.body.id
                                          fuVM.followingUser()
                                          
                                      } else {
                                          fuVM.buttonText = "Follow"
                                          ufVM.unfollowModel.user_id = pdVM.getUserProfileModel.body.id
                                          ufVM.unFollow()
                                      }
                                  }){
                                      Text(fuVM.buttonText)
                                          .font(.Medium14)
                                          .foregroundColor(.white)
                                          .frame(width: 106,height: 43)
                                          .background(Color.textfieldColor)
                                          .cornerRadius(10)
                                  }
                                NavigationLink(destination: ChatRoomView(senderId: pdVM.getUserProfileModel.body.id, senderImage: pdVM.getUserProfileModel.body.profileImageURL, senderName: pdVM.getUserProfileModel.body.name), label: {
                                    Text("Message")
                                        .font(.Medium14)
                                        .foregroundColor(.white)
                                        .frame(width: 106,height: 43)
                                        .background(Color.textfieldColor)
                                        .cornerRadius(10)
                                })
                            }else{
                               NavigationLink(destination: OffersView(), label: {
                                    Image("blurmessage")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width : 256 ,height: 65)
                                })
                            }
                            Button(action: {
                    pdVM.peopleLikeModel.user_id = pdVM.getUserProfileModel.body.id
                    pdVM.getUserProfileModel.body.isLike = !pdVM.getUserProfileModel.body.isLike
                    pdVM.peopleLikeModel.dir = pdVM.getUserProfileModel.body.isLike
                    pdVM.profileLike()
                            }) {
                                Image( pdVM.getUserProfileModel.body.isLike ? "flamefill" : "fire")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 22, height: 22)
                            }
                            }.frame(maxWidth: .infinity,alignment : .center)
                                  
                           ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    HStack{
                                        Image("cakeic")
                                        Text("\(pdVM.getUserProfileModel.body.dateOfBirth.age() ?? 0) years")
                                            .font(.Regular14)
                                            .foregroundColor(.white)
                                        HStack{
                                            Divider()
                                                .frame(width: 2, height: 20)
                                            .background(Color("pbEmptyColor"))}
                                        Image("maleorfemaleic")
                                            .frame(width: 21,height: 21)
                                        Text(pdVM.getUserProfileModel.body.gender)
                                            .font(.Regular14)
                                            .foregroundColor(.white)
                                        HStack{
                                            Divider()
                                                .frame(width: 2, height: 20)
                                            .background(Color("pbEmptyColor"))}
                                        Image("zodicic")
                                            .frame(width: 21,height: 21)
                                        Text(pdVM.getUserProfileModel.body.zodaic)
                                            .font(.Regular14)
                                            .foregroundColor(.white)
                                        HStack{
                                            Divider()
                                                .frame(width: 2, height: 20)
                                            .background(Color("pbEmptyColor"))}
                                        Image("drinkicc")
                                            .frame(width: 21,height: 21)
                                    }
                                    HStack{
                                        Text(pdVM.getUserProfileModel.body.drinking)
                                            .font(.Regular14)
                                            .foregroundColor(.white)
                                        HStack{
                                            Divider()
                                                .frame(width: 2, height: 20)
                                            .background(Color("pbEmptyColor"))}
                                        Image("job")
                                            .frame(width: 21,height: 21)
                                        Text(pdVM.getUserProfileModel.body.jobTitle)
                                            .font(.Regular14)
                                            .foregroundColor(.white)
                                        HStack{
                                            Divider()
                                                .frame(width: 2, height: 20)
                                            .background(Color("pbEmptyColor"))}
                                        Image("smokingic")
                                            .frame(width: 21,height: 21)
                                        Text(pdVM.getUserProfileModel.body.smoking)
                                            .font(.Regular14)
                                            .foregroundColor(.white)
                                    }
                                }.frame(maxWidth: .infinity)
                                    .padding(.horizontal)
                                    .padding(.top,10)
                            }
                            .padding(.top,10)
                            VStack(alignment: .leading){
                                Text("Party Pictures")
                                    .font(.Medium18)
                                    .foregroundColor(.white)
                                ScrollView(.vertical,showsIndicators: false){
                                    LazyVGrid(columns: columns){
                                        ForEach(pdVM.getUserProfileModel.body.storyImage.indices,id: \.self){ n in
                                            Button {
                                                ciVM.imagesArray = pdVM.getUserProfileModel.body.storyImage
                                                ciVM.selectedImageIndex = n
                                                ciVM.showImageViewer.toggle()
                                            } label: {
                                                AnimatedImage(url: URL(string:
                                            pdVM.getUserProfileModel.body.storyImage[n].image
                                                                       ))
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width:100 ,height:100)
                                                .cornerRadius(12)
//                                                Image(pdVM.imagesArray[n])
//                                                    .resizable()
//                                                    .frame(width:100 ,height:100)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal,15)
                            .padding(.top,30)
                        }.frame(maxWidth: .infinity,alignment: .center)
                        VStack{
                            ForEach(ueVM.getPersonEventModel.body,id: \.id){ item in
                                NavigationLink(destination: EventDetailView(evetDetails: item), label: {
                                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                                        VStack{
                                            Image("playimg")
                                                .frame(width: 79,height: 79)
                                        }.frame(maxWidth: .infinity,alignment: .center)
                                            .padding(.top,110)
                                        
                                        ZStack{
                                            HStack{
                                                AnimatedImage(url: URL(string: item.eventOwnerImage))
                                                    .resizable()
                                                    .placeholder {
                                                        Rectangle().foregroundColor(.gray)
                                                            .frame(width: 56,height: 70)
                                                            .cornerRadius(5)
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
                                            .background(MyCustomShape().foregroundColor(.backgroundColor))
                                            .padding(.top,300)
                                        
                                    } .frame(width: 325,height: 343)
                                        .background{
                                            AnimatedImage(url: URL(string: item.tumNail))
                                                .resizable()
                                                .placeholder {
                                                    Rectangle().foregroundColor(.gray)
                                                        .frame(width: 325,height: 343)
                                                        .cornerRadius(10)
                                                }
                                                .scaledToFill()
                                                .transition(.fade)
                                                .frame(width: 325,height: 343)
                                                .cornerRadius(10)
                                        }
                                        .cornerRadius(17)
                                })
                            }.padding(.top,10)
                        }
                    }.padding(.top,20)
                    Spacer()
                }.blur(radius: pdVM.getUserProfileModel.body.isBlocked ? 24 : 0)
                if  pdVM.showProgress{
                    ProgressView()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.5))
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
                }
                if pdVM.getUserProfileModel.body.isBlocked {
                    BlurView()
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
                            Text(pdVM.getUserProfileModel.body.name)
                                .font(.Regular18)
                                .foregroundColor(.white)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        if !pdVM.getUserProfileModel.body.isBlocked {
                            Menu {
                                //                        Button(action: {
                                //                          self.showAlert = true
                                //                        }) {
                                //                          Text("Report User")
                                //                        }.alert(isPresented:  $showAlert) {
                                //                            Alert(title: Text("Report User"), message: Text("Would You Like to Report this User"),
                                //                                primaryButton: .default (Text("OK")) {
                                ////                                  print("OK button tapped")
                                //                                },
                                //                                secondaryButton: .cancel()
                                //                            )
                                //                        }
                                
                                
                                Button(action: {
                                    buVM.blockUserModel.user_id = pdVM.getUserProfileModel.body.id
                                    self.showAlert = true
                                }) {
                                    Text("Block User")
                                }
                                
                                
                            } label: {
                                Button {
                                } label: {
                                    Image("tooltipicon")
                                        .foregroundColor(.white)
                                }.frame(width: 34,height: 34)
                                    .cornerRadius(12)
                            }
                        }
                        
                        
                    }
                }.alert(isPresented:  $showAlert) {
                    Alert(title: Text("Block"), message: Text("Would You Like to Block this User"),
                          primaryButton: .default (Text("OK")) {
                        //                                  print("OK button tapped")
                        buVM.blockUser{ comp in
                            if comp{
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    },
                          secondaryButton: .cancel()
                    )
                }
                .overlay(
                    ZStack{
                        if ciVM.showImageViewer{
                            CustomImageView()
                        }
                    }
                )
                .onAppear{
                    pdVM.userProfileModel.check = id
                    pdVM.userProfileDetail()
                    ueVM.personEventModel.person_id = id
                    ueVM.userEventDetail()
                }
                .environmentObject(ciVM)
        }
    }
    
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView(id: "")
        }
    }
    
    
    struct BlurView :  View {
        var body: some View{
            VStack{
                Text("You blocked this person")
                    .foregroundColor(.white)
                    .font(.Regular14)
            }.frame(maxWidth: .infinity,maxHeight: .infinity)
                .navigationBarBackButtonHidden(true)
                .background(Color.black.opacity(0.02))
            
            
        }
    }

