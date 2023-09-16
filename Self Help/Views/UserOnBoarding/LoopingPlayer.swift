//
//  LoopingPlayer.swift
//  LoopingPlayer
//
//  Created by SchwiftyUI on 3/28/20.
//  Copyright © 2020 SchwiftyUI. All rights reserved.
//

import SwiftUI
import AVFoundation

struct LoopingPlayer: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return QueuePlayerUIView(frame: .zero)
        
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Do nothing here
    }
}

class QueuePlayerUIView: UIView {
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Load Video
        let fileUrl = Bundle.main.url(forResource: "Finalsnow2", withExtension: "mp4")!
        let playerItem = AVPlayerItem(url: fileUrl)
        
        // Setup Player
        let player = AVQueuePlayer(playerItem: playerItem)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        // Loop
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        
        // Play
        player.play()
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
            // Adjust the frame to cover the entire screen, excluding safe areas
            if let superview = self.superview {
                let safeAreaInsets = superview.safeAreaInsets
                let frame = CGRect(x: -safeAreaInsets.left,
                                    y: -safeAreaInsets.top,
                                    width: superview.frame.width + safeAreaInsets.left + safeAreaInsets.right,
                                    height: superview.frame.height + safeAreaInsets.top + safeAreaInsets.bottom)
                playerLayer.frame = frame
            }
        }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PlayerUIView: UIView {
    private var playerLayer = AVPlayerLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Load Video
        let fileUrl = Bundle.main.url(forResource: "Finalsnow2", withExtension: "mp4")!
        let playerItem = AVPlayerItem(url: fileUrl)
        
        // Setup Player
        let player = AVPlayer(playerItem: playerItem)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        // Loop
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self, selector: #selector(rewindVideo(notification:)), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        // Play
        player.play()
    }
    
    @objc
    func rewindVideo(notification: Notification) {
        playerLayer.player?.seek(to: .zero)
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
            // Adjust the frame to cover the entire screen, excluding safe areas
            if let superview = self.superview {
                let safeAreaInsets = superview.safeAreaInsets
                let frame = CGRect(x: -safeAreaInsets.left,
                                    y: -safeAreaInsets.top,
                                    width: superview.frame.width + safeAreaInsets.left + safeAreaInsets.right,
                                    height: superview.frame.height + safeAreaInsets.top + safeAreaInsets.bottom)
                playerLayer.frame = frame
            }
        }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct LoopingPlayer_Previews: PreviewProvider {
    static var previews: some View {
        LoopingPlayer()
    }
}
