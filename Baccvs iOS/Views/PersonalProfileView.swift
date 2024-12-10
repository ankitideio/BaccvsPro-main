//
//  PersonalProfileView.swift
//  Baccvs iOS
//  Created by pm on 14/02/2023.
import SwiftUI
import Photos
import Combine
import SDWebImageSwiftUI
import PhotosUI
import AVKit
import CoreTransferable
struct PersonalProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var image = UIImage()
    @State private var showSheet = false
    @StateObject var cpVM = CheckProfileViewModel()
    @StateObject var meVM = MyEventsViewModel()
    @StateObject var ciVM = CustomImageViewModel()
    @StateObject var deVM = DeleteEventViewModel()
    @State  var showalert : Bool =  false
    @State var isEditing = false
    @State private var isPrivate : Bool = false
    @ObservedObject var mediaItems = PickedMediaItems()
    private let columns : [GridItem] = [GridItem(.flexible()),GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var seVM = UpdateProfileViewModel()
    @StateObject var diVM =   DeleteImageViewModel()
    @State var selectedEvent = GetPostsForUsersHomeBody()
    @StateObject var uVM  = UpgrageViewModel()

    var body: some View {
        ZStack{
            VStack{
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        VStack(spacing:10){
                            VStack{

                                if (seVM.croppedImage == nil){
                                    AnimatedImage(url: URL(string: cpVM.checkprofileModel.body.profileImageURL))
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
                                        .onTapGesture {
                                            seVM.showPicker.toggle()
                                        }
                                        //
                                }else if  (seVM.croppedImage != nil){
                                    Image(uiImage: seVM.croppedImage!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 82,height: 89)
                                        .cornerRadius(23)
                                }

                                }
                            HStack{
                                Text(cpVM.checkprofileModel.body.name)
                                .foregroundColor(.white)
                                .font(.Regular14)
                                Button(action: {
                                          isPrivate.toggle()
                                      }, label: {
                                                 Image(self.isPrivate ?  "eyeslash" : "eye")
                                      }).background(Image("eyebg"))
                            }
                            VStack{
                                Text(cpVM.checkprofileModel.body.description)
                                    .font(.Regular10)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.white)
                                    .padding(.horizontal,26)
                            }
                            HStack(spacing:25){
                                VStack{
                                    Text("Events")
                                        .foregroundColor(.white)
                                        .font(.Medium14)
                                    Text("\(cpVM.checkprofileModel.body.events)")
                                        .font(.Regular14)
                                        .foregroundColor(.lightColor)
                                }

                                NavigationLink {
                                    FollowersPageView()
                                } label: {
                                    VStack{
                                        Text("Followers")
                                            .foregroundColor(.white)
                                            .font(.Medium14)
                                        Text("\(cpVM.checkprofileModel.body.followers)")
                                            .foregroundColor(.lightColor)
                                            .font(.Regular14)
                                    }
                                }
                                NavigationLink {
                                    FollowingsView()
                                } label: {
                                    VStack{
                                        Text("Following")
                                            .foregroundColor(.white)
                                            .font(.Medium14)
                                        Text("\(cpVM.checkprofileModel.body.following)")
                                            .foregroundColor(.lightColor)
                                            .font(.Regular14)
                                    }
                                }
                            }.padding(.top,15)
                         ScrollView(.horizontal,showsIndicators: false){
                                    HStack{
                                        HStack{
                                            Image("cakeic")
                         Text("\(cpVM.checkprofileModel.body.dateOfBirth.age() ?? 0) years")
//                                            Text(cpVM.checkprofileModel.body.dateOfBirth)
                                                .font(.Regular14)
                                                .foregroundColor(.white)
                                            HStack{
                                                Divider()
                                                    .frame(width: 2, height: 20)
                                                .background(Color("pbEmptyColor"))}
                                            Image("maleorfemaleic")
                                                .renderingMode(.template)
                                                .foregroundColor(.secondaryColor)
                                                .frame(width: 21,height: 21)
                                            Text(cpVM.checkprofileModel.body.gender)
                                                .font(.Regular14)
                                                .foregroundColor(.white)
                                            HStack{
                                                Divider()
                                                    .frame(width: 2, height: 20)
                                                .background(Color("pbEmptyColor"))}
                                            Image("zodicic")
                                                .renderingMode(.template)
                                                .foregroundColor(.secondaryColor)
                                                .frame(width: 21,height: 21)
                                            Text(cpVM.checkprofileModel.body.zodaic)
                                                .font(.Regular14)
                                                .foregroundColor(.white)
                                            HStack{
                                                Divider()
                                                    .frame(width: 2, height: 20)
                                                .background(Color("pbEmptyColor"))}
                                            Image("drinkicc")
                                                .renderingMode(.template)
                                                .foregroundColor(.secondaryColor)
                                                .frame(width: 21,height: 21)
                                        }
                                        HStack{
                                            Text(cpVM.checkprofileModel.body.drinking)
                                                .font(.Regular14)
                                                .foregroundColor(.white)
                                            HStack{
                                                Divider()
                                                    .frame(width: 2, height: 20)
                                                .background(Color("pbEmptyColor"))}
                                            Image("job")
                                                .frame(width: 21,height: 21)
                                            Text(cpVM.checkprofileModel.body.jobTitle)
                                                .font(.Regular14)
                                                .foregroundColor(.white)
                                            HStack{
                                                Divider()
                                                    .frame(width: 2, height: 20)
                                                .background(Color("pbEmptyColor"))}
                                            Image("smokingic")
                                                .renderingMode(.template)
                                                .foregroundColor(.secondaryColor)
                                                .frame(width: 21,height: 21)
                                            Text(cpVM.checkprofileModel.body.smoking)
                                                .font(.Regular14)
                                                .foregroundColor(.white)
                                       }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal)
                                    .padding(.top,10)
                                }
                        }
                    } .frame(maxWidth: .infinity,alignment: .center)


                    VStack(alignment: .leading){
                        HStack{
                            Text("Party Pictures")
                                .font(.Medium18)
                                .foregroundColor(.white)
                            Spacer()
                            Button {
                                isEditing.toggle()
                            } label: {
                                Image(isEditing ?  "editiconselected" : "editicon")
                                    .frame(width: 40, height: 40)
                            }

                        }
                        ScrollView(.vertical,showsIndicators: false){
                            LazyVGrid(columns: columns){
                                ForEach(cpVM.checkprofileModel.body.storyImage.indices,id: \.self)
                                { n in
                                    Button {
                                        if !isEditing{
                                            ciVM.imagesArray = cpVM.checkprofileModel.body.storyImage
                                            ciVM.selectedImageIndex = n
                                            ciVM.showImageViewer.toggle()
                                        }
                                        else{
//                                            cpVM.imagesArray.remove(at: n)
                                        }
                                    } label: {
                                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                                            AnimatedImage(url: URL(string:
                                                cpVM.checkprofileModel.body.storyImage[n].image))
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width:100 ,height:100)
                                                .cornerRadius(12)


                                            if isEditing{
                                                Image("cross")
                                                    .resizable()
                                                    .frame(width:20 ,height:20)
                                                    .offset(x: 10, y: -5)
                                                    .onTapGesture {
                                                        diVM.deleteImageModel.image_id = cpVM.checkprofileModel.body.storyImage[n].id
                           cpVM.checkprofileModel.body.storyImage.remove(at: n)
//                                                        cpVM.imagesArray.remove(at: n)
                                                        diVM.deleteImage()
                                                    }
                                            }
                                        }.padding(.top, 10)
                                    }
                                }
                            }
                            if isEditing {
                                Text("Pending Upload")
                                    .font(.Medium18)
                                    .foregroundColor(.white)
                                LazyVGrid(columns: columns){
                                    ForEach(mediaItems.items,id: \.id){ n in
                                        Button {
                                            if !isEditing{
                                                ciVM.showImageViewer.toggle()
                                            }
                                            else{

                                            }

                                        } label: {
                                            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                                                Image(uiImage: n.photo ?? UIImage())
                                                    .resizable()
                                                    .frame(width:100 ,height:100)
                                                    .cornerRadius(10)

                                                if isEditing{
                                                    Image("cross")
                                                        .resizable()
                                                        .frame(width:20 ,height:20)
                                                        .offset(x: 10, y: -5)
                                                        .onTapGesture {
                                                            let index = mediaItems.items.firstIndex(where: {$0.id == n.id})
                                                            mediaItems.deleteAt(index: index ?? 0)
                                                            mediaItems.items.remove(at: index ?? 0)
                                                        }
                                                }
                                            }.padding(.top, 10)
                                        }
                                    }
                                }
                                HStack(spacing: 20){
                                    if mediaItems.items.isEmpty{
                                        Button {
                                            showSheet.toggle()
                                        } label: {
                                            Text("Add Image")
                                                .font(.Medium16)
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity)
                                        }.frame(height:65)
                                            .background(LinearGradient.secondaryGradient)
                                            .cornerRadius(60)
                                    }else{
                                        Button {
                                            showSheet.toggle()
                                        } label: {
                                            Text("Add Image")
                                                .font(.Medium16)
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity)
                                        }.frame(height:65)
                                            .background(Color.backgroundColor)
                                            .cornerRadius(60)
                                        Button {
                                            if (cpVM.imagesArray.count + mediaItems.items.count) <= 6 {
                                                mediaItems.items.forEach { n in
                                                    cpVM.postStoryImagesModel.storys.append( Media(part_vedio_url: n.photo?.jpegData(compressionQuality: 1.0) ?? Data(), mimeType: "image/jpeg", fileName: "\(arc4random()).jpeg", paramName: "storys"))
                                                }
                                                cpVM.uploadStoryImages{comp in
                                                    if comp {
                                                        mediaItems.items = []
                                                        
                                                    }
                                                }
                                            }

                                        } label: {
                                            Text("Upload Image")
                                                .font(.Medium16)
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity)
                                        }.frame(height:65)
                                            .background(LinearGradient.secondaryGradient)
                                            .cornerRadius(60)
                                    }
                                }
                            }
                        }
                     }.padding(.horizontal,15)
                    .padding(.top,30)
                   //TODO: Past Event
                    VStack(spacing: 20){
                        Text("Past Events")
                            .font(.Medium18)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading,20)
                        ForEach(meVM.myEventModel.body,id: \.id){ item in
                            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                                AnimatedImage(url: URL(string:  item.tumNail))
                                    .resizable()
                                    .placeholder {
                                        Rectangle().foregroundColor(.gray)
                                            .frame(height: 343)
                                            .cornerRadius(10)
                                    }.scaledToFill()
                                    .transition(.fade)
                                    .frame(height: 343)
                                    .cornerRadius(10)
                                NavigationLink(destination: EventDetailView(evetDetails : item)) {
                                    Image("playimg")
                                        .frame(width: 79,height: 79)
                                        .padding(.trailing,120)
                                        .padding(.top,120)
                                }
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
                    meVM.myEventModel.body.removeAll(where:{$0.id == selectedEvent.id})
                                                deVM.delEvent()
                                        }), secondaryButton: .cancel()
                                    )
                                })
                                
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
                                    .padding(.horizontal, -10)
                                    .background(MyCustomShape().foregroundColor(.backgroundColor)).padding(.top,290)
                            }
                                .frame(height: 343)
                                .clipShape(RoundedRectangle(cornerRadius: 17))
                                .padding(.horizontal, 30)
                                
                            // lower bar
                            
                            
                                
                        }
                    }
                }.padding(.top,20)
//                Spacer()
            }
            if cpVM.showProgress{
                ZStack{
                    ProgressView()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.5))
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
                    Text("Please wait while the Photos is being uploaded.")
                        .foregroundColor(.white)
                        .padding(.top, 50)
                }
              }
//            .alert(isPresented: $cpVM.showAlert, content: {
//                getAlert(alertType: cpVM.alertType, message: cpVM.message)
//            })
//            .sheet(isPresented: $showSheet){
//
//
//            }
            if cpVM.showProgress{
                ProgressView()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryColor))
            }
            if self.cpVM.show{
                CustomPicker(selected: self.$cpVM.selected, show: self.$cpVM.show)
            }
        }.onAppear{
            cpVM.getCheckProfile()
        }
        .enableLightStatusBar()
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .background(bgView())
        .cropImagePicker(
            options: [.square],
            show: $seVM.showPicker,
            croppedImage: $seVM.croppedImage
        ).onChange(of: seVM.croppedImage) { newImage in
            seVM.updateProfileModel.file = Media(part_vedio_url: newImage?.jpegData(compressionQuality: 1.0) ?? Data(), mimeType: "image/jpeg", fileName: "\(arc4random()).jpeg", paramName: "file")
            seVM.updateProfile()
        }
        .sheet(isPresented: $showSheet) {
            if isEditing{
                PhotoPicker(selectionLimit: (6 - cpVM.imagesArray.count), filter: .any(of: [.images]), mediaItems: mediaItems) { didSelectItem in
                    // Handle didSelectItems value here...
                    if didSelectItem{
                        mediaItems.items = []
                    }
                    print(didSelectItem)
                    showSheet = false
                }
            }else{
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            }
        }
        .overlay(
            ZStack{
                if ciVM.showImageViewer{
                    CustomImageView()
                }
            }
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
                        Text(cpVM.checkprofileModel.body.name)
                            .font(.Regular18)
                            .foregroundColor(.white)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Menu {
                        NavigationLink(destination: PersonalProfilleDetailView(), label: {
                            Text("Profile Detail")
                                .font(.Regular14)
                        })
                        if uVM.isPro {
                            Button {
                                if cpVM.checkprofileModel.body.public_or_private{
                                    cpVM.turnProfileToPivate()
                                }else{
                                    cpVM.turnProfileToPublic()
                                }
                            } label: {
                                Text("Turn Profile to \(cpVM.checkprofileModel.body.public_or_private ?  "Private" : "Public")")
                                .foregroundColor(.black)
                                    .font(.Regular14)
                            }
                        } else {
                            NavigationLink(destination: OffersView(), label: {
                                Text("Turn Profile to Private ")
                                    .foregroundColor(.black)
                                        .font(.Regular14)
                            })
                            
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
         .environmentObject(ciVM)
    }
    func removeImage(offsets: Int) {
        cpVM.selected.remove(at: offsets)
    }
}

struct PersonalProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalProfileView()
    }
}

struct CustomPicker : View {
    @Binding var selected : [SelectedImages]
    @State var grid : [[Images]] = []
    @Binding var show : Bool
    @State var disabled = false
    var body: some View{
        GeometryReader{_ in
            VStack{
                if !self.grid.isEmpty{
                    HStack{
                        Text("Pick a Proudct")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.top)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20){
                            
                            ForEach(self.grid,id: \.self){i in
                                
                                HStack{
                                    
                                    ForEach(i,id: \.self){j in
                                        
                                        Card(data: j, selected: self.$selected)
                                    }
                                }
                            }
                        }
                        .padding(.bottom)
                    }
                    
                    Button(action: {
                        
                        self.show.toggle()
                        
                    }) {
                        
                        Text("Select")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .frame(width: UIScreen.main.bounds.width / 2)
                    }
                    .background(Color.red.opacity((self.selected.count != 0) ? 1 : 0.5))
                    .clipShape(Capsule())
                    .padding(.bottom)
                    .disabled((self.selected.count != 0) ? false : true)
                    
                }
                else{
                    
                    if self.disabled{
                        
                        Text("Enable Storage Access In Settings !!!")
                    }
                    if self.grid.count == 0{
                        
                        Indicator()
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 1.5)
            .background(Color.white)
            .cornerRadius(12)
        }.padding(.horizontal,20)
        .background(Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
        .onTapGesture {
            self.show.toggle()
        })
        .onAppear {
            
            PHPhotoLibrary.requestAuthorization { (status) in
                
                if status == .authorized{
                    
                    self.getAllImages()
                    self.disabled = false
                }
                else{
                    
                    print("not authorized")
                    self.disabled = true
                }
            }
        }
    }
    func getAllImages(){
        
        let opt = PHFetchOptions()
        opt.includeHiddenAssets = false
        
        let req = PHAsset.fetchAssets(with: .image, options: .none)
        
        DispatchQueue.global(qos: .background).async {

           let options = PHImageRequestOptions()
           options.isSynchronous = true
                
        // New Method For Generating Grid Without Refreshing....
            
          for i in stride(from: 0, to: req.count, by: 3){
                    
                var iteration : [Images] = []
                    
                for j in i..<i+3{
                    if j < req.count{
                        PHCachingImageManager.default().requestImage(for: req[j], targetSize: CGSize(width: 150, height: 150), contentMode: .default, options: options) { (image, _) in
                            
                            let data1 = Images(image: image!, selected: false, asset: req[j])
                            
                            iteration.append(data1)

                        }
                    }
                }
                    
                self.grid.append(iteration)
            }
            
        }
    }
}
struct Card : View {
    @State var data : Images
    @Binding var selected : [SelectedImages]
    var body: some View{
        ZStack{
            Image(uiImage: self.data.image)
            .resizable()
            if self.data.selected{
                ZStack{
                    Color.black.opacity(0.5)
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            }
        }
        .frame(width: (UIScreen.main.bounds.width - 80) / 3, height: 90)
        .onTapGesture {
            if !self.data.selected{
                self.data.selected = true
                // Extracting Orginal Size of Image from Asset
                DispatchQueue.global(qos: .background).async {
                    let options = PHImageRequestOptions()
                    options.isSynchronous = true
                    // You can give your own Image size by replacing .init() to CGSize....
                    PHCachingImageManager.default().requestImage(for: self.data.asset, targetSize: .init(), contentMode: .default, options: options) { (image, _) in
                        self.selected.append(SelectedImages(asset: self.data.asset, image: image!))
                    }
                }
            }
            else{
                for i in 0..<self.selected.count{
                    if self.selected[i].asset == self.data.asset{
                        self.selected.remove(at: i)
                        self.data.selected = false
                        return
                    }
                    
                }
            }
        }
    }
}
struct Indicator : UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView  {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    func updateUIView(_ uiView:  UIActivityIndicatorView, context: Context) {
    }
}
struct Images: Hashable {
    var image : UIImage
    var selected : Bool
    var asset : PHAsset
}
struct SelectedImages: Hashable{
    var asset : PHAsset
    var image : UIImage
}
