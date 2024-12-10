//
//  CustomImageViewModel.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 15/04/2023.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import UIKit
class CustomImageViewModel : ObservableObject{
    @Published var selectedImageIndex = 0
    @Published var showImageViewer = false
    @Published var imageViewerOffset: CGSize = .zero
    
    // BG Opacity...
    @Published var bgOpacity: Double = 1
    
    // Scaling....
    @Published var imageScale: CGFloat = 1
    @Published var imagesArray : [StoryImage] = []
    func onChange(value: CGSize){
        
        // updating Offset...
        imageViewerOffset = value
        
        // calculating opactity....
        let halgHeight = UIScreen.main.bounds.height / 2
        
        let progress = imageViewerOffset.height / halgHeight
        
        withAnimation(.default){
            bgOpacity = Double(1 - (progress < 0 ? -progress : progress))
        }
    }
    
    func onEnd(value: DragGesture.Value){
        
        withAnimation(.easeInOut){
            
            var translation = value.translation.height
            
            if translation < 0{
                translation = -translation
            }
            
            if translation < 250{
                imageViewerOffset = .zero
                bgOpacity = 1
            }
            else{
                showImageViewer.toggle()
                imageViewerOffset = .zero
                bgOpacity = 1
            }
        }
    }
}
