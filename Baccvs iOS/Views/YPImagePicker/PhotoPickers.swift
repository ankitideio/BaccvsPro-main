//
//  PhotoPickers.swift
//  Baccvs iOS
//
//  Created by pm on 29/08/2023.
//


import Foundation
import YPImagePicker
import UIKit
import SwiftUI
import AVFoundation
struct PhotoPickers: UIViewControllerRepresentable {
    @Binding var mediaItems : [SelectedMediaYPModel]
    var maxItems : Int
        func makeUIViewController(context: Context) -> some UIViewController {

            
            var config = YPImagePickerConfiguration()
            YPImagePickerConfiguration.shared = config
            config.library.mediaType = YPlibraryMediaType.video
            config.screens = [.library]
            config.library.maxNumberOfItems = maxItems
            
            config.video.compression = AVAssetExportPresetMediumQuality
            config.video.fileType = .mov
            config.video.libraryTimeLimit = 300.0
            config.video.minimumTimeLimit = 3.0
            config.video.trimmerMaxDuration = 300.0
            config.video.trimmerMinDuration = 3.0
            
            let picker = YPImagePicker(configuration: config)
            picker.delegate = context.coordinator
            
            picker.didFinishPicking { [unowned picker] items, cancelled in
                mediaItems = []
                    mediaItems = items.map({ yp in
                        switch yp {
                            case .photo(let photo):
                            return SelectedMediaYPModel(photo: photo.image, video: nil, data: photo.image.jpegData(compressionQuality: 1.0) ?? Data(), isImage: true)
                            case .video(let video):
                            let videoData = try? Data(contentsOf: video.url)
                            return SelectedMediaYPModel(photo: nil, video: video.url, data: videoData ?? Data(), isImage: false)
                        }
                        
                    })
                    picker.dismiss(animated: true, completion: nil)
                }
            
            

            return picker
        }
    
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

        }
    
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
    
        class Coordinator: NSObject, UINavigationControllerDelegate {
    
            let parent: PhotoPickers
    
            init(_ parent: PhotoPickers) {
                self.parent = parent
            }
        }
    }

struct SelectedMediaYPModel : Identifiable{
    var id = UUID().uuidString
    var photo : UIImage?
    var video : URL?
    var data : Data
    var isImage : Bool
}
struct SelectedImageYPModel{
    var photo : UIImage = UIImage()
    var data : Data = Data()
}
