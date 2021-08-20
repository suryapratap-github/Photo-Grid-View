//
//  extensions.swift
//  Photo Grid View
//
//  Created by Surya Pratap Singh on 18/08/21.
//

import UIKit
import SDWebImage
import AVKit
import AVFoundation

//MARK: UIImageView
extension UIImageView {
    func loadImage(strUrl: String?, placeHolder:UIImage? = UIImage(named: "placeholder"), contentMode: ContentMode = .scaleAspectFill) {
        let imgPlaceholder = placeHolder
        self.contentMode = contentMode
        if let string = strUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: string) {
            sd_setImage(with: url, placeholderImage: imgPlaceholder, options: [], completed: nil)
            return
        }
        self.image = imgPlaceholder
    }
    
    
    func loadVideo(forUrl url: URL) {
        let videoAsset = AVAsset(url: url)
        let videoPlayerItem = AVPlayerItem(asset: videoAsset)
        let player = AVPlayer(playerItem: videoPlayerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.bounds
        self.layer.addSublayer(playerLayer)
        player.play()
    }

}
