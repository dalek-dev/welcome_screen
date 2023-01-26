//
//  VideoPlayer.swift
//  login_transition
//
//  Created by Victor Miranda on 24/01/23.
//

import SwiftUI
import AVFoundation

struct VideoPlayer: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        //
    }
}

class PlayerUIView: UIView {
    private var playerLayer = AVPlayerLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Load Video
        let fileUrl = Bundle.main.url(forResource: "bycicle", withExtension: "mp4")!
        let playerItem = AVPlayerItem(url: fileUrl)
        
        // Setup Player
        let player = AVPlayer(playerItem: playerItem)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        // Loop
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self, selector: #selector(rewindVideo(notification: )), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        // Play Video
        player.play()
        player.isMuted = true
        
    }
    
    @objc
    func rewindVideo(notification: Notification){
        playerLayer.player?.seek(to: .zero)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct VideoPlayer_Previews: PreviewProvider{
    static var previews: some View{
        VideoPlayer()
    }
}
