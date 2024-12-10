//
//  PlayerView.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 05/04/2023.
//

import AVFoundation
import UIKit

final class PlayerView: UIView {
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
    
    var player: AVPlayer? {
        get {
            playerLayer.player
        }
        set {
            playerLayer.videoGravity = .resizeAspectFill
            playerLayer.player = newValue
        }
    }
}
