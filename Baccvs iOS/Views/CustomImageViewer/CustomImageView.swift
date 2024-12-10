//
//  CustomImageView.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 15/04/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct CustomImageView: View {
    @EnvironmentObject var pGalleryVM : CustomImageViewModel
    
    // since onChnage has a problem in Drag Gesture....
    @GestureState var draggingOffset: CGSize = .zero
    @State var selection = 0
    var body: some View {
        
        ZStack{
            
            if pGalleryVM.showImageViewer{
                
                Color.black
//                    .opacity(pGalleryVM.bgOpacity)
                    .ignoresSafeArea()

//                 TabView Has a problem in ignroing edges...
                ScrollView(.init()){

                    TabView(selection: $pGalleryVM.selectedImageIndex){

                        ForEach(pGalleryVM.imagesArray.indices,id: \.self){image in

//                            WebImage(url: URL(string: pGalleryVM.imagesArray[image]))
                            AnimatedImage(url: URL(string: pGalleryVM.imagesArray[image].image))
//                            Image(pGalleryVM.imagesArray[image].image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .tag(image)
                                .scaleEffect(pGalleryVM.selectedImageIndex == image ? (pGalleryVM.imageScale > 1 ? pGalleryVM.imageScale : 1) : 1)
                            // Moving Only Image...
                            // For SMooth Animation...
                                .offset(y: pGalleryVM.imageViewerOffset.height)
                                .gesture(

                                    // Magnifying Gesture...
                                    MagnificationGesture().onChanged({ (value) in
                                        pGalleryVM.imageScale = value
                                    }).onEnded({ (_) in
                                        withAnimation(.spring()){
                                            pGalleryVM.imageScale = 1
                                        }
                                    })
                                    // To avoid scroll while scaling
                                    .simultaneously(with: DragGesture(minimumDistance: pGalleryVM.imageScale == 1 ? 10000 : 0))
                                    // Double To Zoom...
                                    .simultaneously(with: TapGesture(count: 2).onEnded({
                                        withAnimation{
                                            pGalleryVM.imageScale = pGalleryVM.imageScale > 1 ? 1 : 4
                                        }
                                    }))
                                )
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                }
                .ignoresSafeArea()
                .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
        
            // CLose Button...
            Button(action: {
                withAnimation(.default){
                    // Removing All.....
                    pGalleryVM.showImageViewer.toggle()
                }
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.white.opacity(0.35))
                    .clipShape(Circle())
            })
            .padding(10)
            .opacity(pGalleryVM.showImageViewer ? pGalleryVM.bgOpacity : 0)
            
            ,alignment: .topTrailing
        )
        .gesture(DragGesture().updating($draggingOffset, body: { (value, outValue, _) in
            
            outValue = value.translation
            pGalleryVM.onChange(value: draggingOffset)
            
        }).onEnded(pGalleryVM.onEnd(value:)))
    }
}
